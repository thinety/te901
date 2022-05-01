import base64 as _base64
import hashlib as _hashlib
import hmac as _hmac

from datetime import datetime as _datetime, timedelta as _timedelta
import os as _os
from math import ceil as _ceil

from attrs import define as _define

from . import _database


def _generate_phc_string(password):
    salt = _os.urandom(24)

    derived_key = _hashlib.scrypt(
        password=bytes(password, 'utf-8'),
        salt=salt,
        n=2**14,
        r=8,
        p=1,
        dklen=48,
    )

    salt = _base64.standard_b64encode(salt).decode('utf-8')
    derived_key = _base64.standard_b64encode(derived_key).decode('utf-8')

    phc_string = f'$scrypt$ln=14,r=8,p=1${salt}${derived_key}'

    return phc_string

def _verify_password(password, phc_string):
    (_, algorithm, params, salt, derived_key) = phc_string.split('$')

    # should check algorithm and params here

    salt = _base64.standard_b64decode(salt)
    derived_key = _base64.standard_b64decode(derived_key)

    new_derived_key = _hashlib.scrypt(
        password=bytes(password, 'utf-8'),
        salt=salt,
        n=2**14,
        r=8,
        p=1,
        dklen=48,
    )

    if _hmac.compare_digest(new_derived_key, derived_key):
        return True

    return False


def calculate_extra_hours(expected_withdrawal_date, expected_amount_of_days, withdrawal_date, dropoff_date):
    used_time = dropoff_date - _datetime(
        expected_withdrawal_date.year,
        expected_withdrawal_date.month,
        expected_withdrawal_date.day,
        withdrawal_date.hour,
        withdrawal_date.minute,
        withdrawal_date.second,
    )

    extra_time = used_time - _timedelta(expected_amount_of_days)

    if extra_time.days < 0:
        return 0

    return extra_time.days * 24 + _ceil(extra_time.seconds / 3600)


class L901:
    def __init__(self, filepath):
        self._connection = _database.Connection(filepath)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        self._connection.close()

    def register_client(
        self,
        *,
        email,
        password,
        name,
        telephone,
        address,
        cpf,
        cnh,
    ):
        phc_string = _generate_phc_string(password)

        with self._connection.cursor(transaction=True) as cursor:
            cursor.execute(
                '''
                INSERT INTO client (
                    email,
                    phc_string,
                    name,
                    telephone,
                    address,
                    cpf,
                    cnh
                ) VALUES (?, ?, ?, ?, ?, ?, ?);
                ''',
                (
                    email,
                    phc_string,
                    name,
                    telephone,
                    address,
                    cpf,
                    cnh,
                ),
            )

    def login_client(
        self,
        *,
        email,
        password,
    ):
        with self._connection.cursor() as cursor:
            cursor.execute(
                '''
                SELECT phc_string, id, name FROM client WHERE email = ?;
                ''',
                (email,),
            )
            (phc_string, id, name) = cursor.fetchone()

        if not _verify_password(password, phc_string):
            raise Exception('Wrong password')

        return _Client(id, name, self._connection)

    def login_employee(
        self,
        *,
        email,
        password,
    ):
        with self._connection.cursor() as cursor:
            cursor.execute(
                '''
                SELECT e.phc_string, e.id, e.name, er.id, er.description, b.id, b.address
                FROM employee AS e
                    JOIN employee_role AS er
                        ON e.role_id = er.id
                    LEFT JOIN employee_branch AS eb
                        ON e.id = eb.employee_id
                    LEFT JOIN branch AS b
                        ON eb.branch_id = b.id
                WHERE email = ?;
                ''',
                (email,),
            )
            (phc_string, id, name, role_id, role_description, branch_id, branch_address) = cursor.fetchone()

        if not _verify_password(password, phc_string):
            raise Exception('Wrong password')

        role = (role_id, role_description)

        if branch_id is not None:
            branch = (branch_id, branch_address)
        else:
            branch = None

        return _Employee(id, name, role, branch, self._connection)

    def get_categories(self):
        with self._connection.cursor() as cursor:
            cursor.execute(
                '''
                SELECT id, code, description FROM vehicle_category;
                '''
            )
            categories = cursor.fetchall()

        categories = [
            _VehicleCategory(id, code, description)
                for (id, code, description) in categories
        ]

        return categories

    def get_vehicles(self, *, category_id):
        with self._connection.cursor() as cursor:
            cursor.execute(
                '''
                SELECT id, model, color
                FROM vehicle
                WHERE category_id = ?
                    AND id NOT IN (
                        SELECT vehicle_id
                        FROM rental AS r
                            LEFT JOIN dropoff AS d
                                ON r.id = d.rental_id
                        WHERE d.rental_id IS NULL
                    );
                ''',
                (category_id,),
            )
            vehicles = cursor.fetchall()

        vehicles = [_Vehicle(id, model, color) for (id, model, color) in vehicles]

        return vehicles

    def get_branches(self):
        with self._connection.cursor() as cursor:
            cursor.execute(
                '''
                SELECT id, address FROM branch;
                '''
            )
            branches = cursor.fetchall()

        branches = [_Branch(id, address) for (id, address) in branches]

        return branches


@_define(frozen=True)
class _Client:
    _id: int
    name: str
    _connection: _database.Connection

    def rent_vehicle(
        self,
        *,
        vehicle_id,
        withdrawal_branch_id,
        expected_withdrawal_date,
        dropoff_branch_id,
        expected_dropoff_date,
    ):
        with self._connection.cursor(transaction=True) as cursor:
            cursor.execute(
                '''
                INSERT INTO rental (
                    client_id,
                    vehicle_id,
                    withdrawal_branch_id,
                    expected_withdrawal_date,
                    dropoff_branch_id,
                    expected_dropoff_date
                ) VALUES (?, ?, ?, ?, ?, ?);
                ''',
                (
                    self._id,
                    vehicle_id,
                    withdrawal_branch_id,
                    int(expected_withdrawal_date.timestamp()),
                    dropoff_branch_id,
                    int(expected_dropoff_date.timestamp()),
                ),
            )

@_define(frozen=True)
class _Employee:
    _id: int
    name: str
    role: tuple[int, str]
    branch: tuple[int, str] | None
    _connection: _database.Connection

    def get_open_withdrawals(self):
        with self._connection.cursor() as cursor:
            if self.branch is not None:
                cursor.execute(
                    '''
                    SELECT r.id, c.name, v.model
                    FROM rental AS r
                        JOIN client AS c
                            ON r.client_id = c.id
                        JOIN vehicle AS v
                            on r.vehicle_id = v.id
                    WHERE r.id NOT IN (SELECT rental_id FROM withdrawal)
                        AND r.expected_withdrawal_date < strftime('%s', 'now')
                        AND r.withdrawal_branch_id = ?
                    ORDER BY r.expected_withdrawal_date ASC
                    LIMIT 5;
                    ''',
                    (self.branch[0],),
                )
            else:
                cursor.execute(
                    '''
                    SELECT r.id, c.name, v.model
                    FROM rental AS r
                        JOIN client AS c
                            ON r.client_id = c.id
                        JOIN vehicle AS V
                            on r.vehicle_id = v.id
                    WHERE r.id NOT IN (SELECT rental_id FROM withdrawal)
                        AND r.expected_withdrawal_date < strftime('%s', 'now')
                    ORDER BY r.expected_withdrawal_date ASC
                    LIMIT 5;
                    '''
                )
            open_withdrawals = cursor.fetchall()

        open_withdrawals = [
            _PendingRental(rental_id, client_name, vehicle_model)
                for (rental_id, client_name, vehicle_model) in open_withdrawals
        ]

        return open_withdrawals

    def withdrawal_vehicle(self, *, rental_id, remarks):
        with self._connection.cursor(transaction=True) as cursor:
            cursor.execute(
                '''
                INSERT INTO withdrawal (attendant_id, rental_id, remarks)
                VALUES (?, ?, ?);
                ''',
                (self._id, rental_id, remarks),
            )

    def get_open_dropoffs(self):
        with self._connection.cursor() as cursor:
            if self.branch is not None:
                cursor.execute(
                    '''
                    SELECT r.id, c.name, v.model
                    FROM rental AS r
                        JOIN withdrawal AS w
                            ON r.id = w.rental_id
                        JOIN client AS c
                            ON r.client_id = c.id
                        JOIN vehicle AS v
                            ON r.vehicle_id = v.id
                    WHERE r.id NOT IN (SELECT rental_id FROM dropoff)
                        AND r.expected_dropoff_date < strftime('%s', 'now')
                        AND r.dropoff_branch_id = ?
                    ORDER BY r.expected_dropoff_date ASC
                    LIMIT 5;
                    ''',
                    (self.branch[0],),
                )
            else:
                cursor.execute(
                    '''
                    SELECT r.id, c.name, v.model
                    FROM rental AS r
                        JOIN withdrawal AS w
                            ON r.id = w.rental_id
                        JOIN client AS c
                            ON r.client_id = c.id
                        JOIN vehicle AS v
                            ON r.vehicle_id = v.id
                    WHERE r.id NOT IN (SELECT rental_id FROM dropoff)
                        AND r.expected_dropoff_date < strftime('%s', 'now')
                    ORDER BY r.expected_dropoff_date ASC
                    LIMIT 5;
                    '''
                )
            open_dropoffs = cursor.fetchall()

        open_dropoffs = [
            _PendingRental(rental_id, client_name, vehicle_model)
                for (rental_id, client_name, vehicle_model) in open_dropoffs
        ]

        return open_dropoffs

    def get_dropoff_info(self, *, rental_id):
        with self._connection.cursor() as cursor:
            cursor.execute(
                '''
                SELECT r.expected_withdrawal_date, r.expected_dropoff_date, w.date, vc.price
                FROM rental AS r
                    JOIN withdrawal AS w
                        ON r.id = w.rental_id
                    JOIN vehicle AS v
                        ON r.vehicle_id = v.id
                    JOIN vehicle_category as vc
                        ON v.category_id = vc.id
                WHERE r.id = ?;
                ''',
                (rental_id,),
            )
            (expected_withdrawal_date, expected_dropoff_date, withdrawal_date, daily_price) = cursor.fetchone()

        expected_withdrawal_date = _datetime.fromtimestamp(int(expected_withdrawal_date))

        expected_dropoff_date = _datetime.fromtimestamp(int(expected_dropoff_date))
        expected_amount_of_days = (expected_dropoff_date - expected_withdrawal_date).days

        withdrawal_date = _datetime.fromtimestamp(int(withdrawal_date))

        daily_price = float(daily_price) / 100

        return _DropoffInfo(
            expected_withdrawal_date,
            expected_amount_of_days,
            withdrawal_date,
            daily_price,
        )

    def dropoff_vehicle(self, *, rental_id, date, remarks, price):
        with self._connection.cursor(transaction=True) as cursor:
            cursor.execute(
                '''
                INSERT INTO dropoff (attendant_id, rental_id, date, remarks, price)
                VALUES (?, ?, ?, ?, ?);
                ''',
                (
                    self._id,
                    rental_id,
                    int(date.timestamp()),
                    remarks,
                    int(price * 100),
                ),
            )


@_define(frozen=True)
class _VehicleCategory:
    id: int
    code: str
    description: str

@_define(frozen=True)
class _Vehicle:
    id: int
    model: str
    color: str

@_define(frozen=True)
class _Branch:
    id: int
    address: str

@_define(frozen=True)
class _PendingRental:
    rental_id: int
    client_name: str
    vehicle_model: str

@_define(frozen=True)
class _DropoffInfo:
    expected_withdrawal_date: _datetime
    expected_amount_of_days: int
    withdrawal_date: _datetime
    daily_price: float
