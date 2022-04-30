CREATE TABLE client (
    id          INTEGER     PRIMARY KEY,
    email       TEXT        NOT NULL UNIQUE,
    phc_string  TEXT        NOT NULL,
    name        TEXT        NOT NULL,
    telephone   TEXT        NOT NULL,
    address     TEXT        NOT NULL,
    cpf         TEXT        NOT NULL,
    cnh         TEXT        NOT NULL
);

CREATE TABLE branch (
    id          INTEGER     PRIMARY KEY,
    address     TEXT        NOT NULL
);

CREATE TABLE employee_role (
    id          INTEGER     PRIMARY KEY,
    description TEXT        NOT NULL
);

CREATE TABLE employee (
    id          INTEGER     PRIMARY KEY,
    email       TEXT        NOT NULL UNIQUE,
    phc_string  TEXT        NOT NULL,
    name        TEXT        NOT NULL,
    telephone   TEXT        NOT NULL,
    address     TEXT        NOT NULL,
    cpf         TEXT        NOT NULL,
    cnh         TEXT        NOT NULL,
    role_id     INTEGER     NOT NULL REFERENCES employee_role(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE employee_branch (
    employee_id INTEGER     PRIMARY KEY REFERENCES employee(id),
    branch_id   INTEGER     NOT NULL REFERENCES branch(id)
);

CREATE TABLE vehicle_category (
    id          INTEGER     PRIMARY KEY,
    code        TEXT        NOT NULL,
    description TEXT        NOT NULL,
    price       INTEGER     NOT NULL -- preço em centavos para evitar erros devido à representação em memória do float64
);

CREATE TABLE vehicle_situation (
    id          INTEGER     PRIMARY KEY,
    description TEXT        NOT NULL
);

CREATE TABLE vehicle (
    id              INTEGER     PRIMARY KEY,
    model           TEXT        NOT NULL,
    color           TEXT        NOT NULL,
    plate           TEXT        NOT NULL,
    renavam         TEXT        NOT NULL,
    category_id     INTEGER     NOT NULL REFERENCES vehicle_category(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    branch_id       INTEGER     NOT NULL REFERENCES branch(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    situation_id    INTEGER     NOT NULL REFERENCES vehicle_situation(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE rental (
    id                          INTEGER     PRIMARY KEY,
    client_id                   INTEGER     NOT NULL REFERENCES client(id) ON UPDATE CASCADE ON DELETE CASCADE,
    date                        INTEGER     NOT NULL DEFAULT (strftime('%s', 'now')), -- unix timestamp
    vehicle_id                  INTEGER     NOT NULL REFERENCES vehicle(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    withdrawal_branch_id        INTEGER     NOT NULL REFERENCES branch(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    expected_withdrawal_date    INTEGER     NOT NULL,
    dropoff_branch_id           INTEGER     NOT NULL REFERENCES branch(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    expected_dropoff_date       INTEGER     NOT NULL
);

CREATE TABLE withdrawal (
    rental_id       INTEGER     PRIMARY KEY REFERENCES rental(id) ON UPDATE CASCADE ON DELETE CASCADE,
    date            INTEGER     NOT NULL DEFAULT (strftime('%s', 'now')),
    attendant_id    INTEGER     NOT NULL REFERENCES employee(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE dropoff (
    rental_id       INTEGER     PRIMARY KEY REFERENCES rental(id) ON UPDATE CASCADE ON DELETE CASCADE,
    date            INTEGER     NOT NULL DEFAULT (strftime('%s', 'now')),
    attendant_id    INTEGER     NOT NULL REFERENCES employee(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    remarks         TEXT        NOT NULL,
    price           INTEGER     NOT NULL
);
