# te901

To setup the environment, run:
```bash
python -m venv venv
. venv/bin/activate

pip install --upgrade pip
pip install --editable lib
```

To setup the database:
```bash
sqlite3 db/.sqlite3 0<db/setup.sql
sqlite3 db/.sqlite3 0<db/data.sql
```

The scripts are available in the `bin` directory:
1. `l901_rent.py`
2. `l901_withdrawal.py`
3. `l901_dropoff.py`
