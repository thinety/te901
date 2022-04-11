CREATE TABLE cliente (
    id          INTEGER     PRIMARY KEY,
    email       TEXT        NOT NULL UNIQUE,
    senha       TEXT        NOT NULL,
    nome        TEXT        NOT NULL,
    cpf         TEXT        NOT NULL,
    telefone    TEXT        NOT NULL,
    endereco    TEXT        NOT NULL,
    cnh         TEXT        NOT NULL
);

CREATE TABLE agencia (
    id          INTEGER     PRIMARY KEY,
    endereco    TEXT        NOT NULL
);

CREATE TABLE funcao_colaborador (
    id          INTEGER     PRIMARY KEY,
    descricao   TEXT        NOT NULL
);

CREATE TABLE colaborador (
    id          INTEGER     PRIMARY KEY,
    email       TEXT        NOT NULL UNIQUE,
    senha       TEXT        NOT NULL,
    nome        TEXT        NOT NULL,
    cpf         TEXT        NOT NULL,
    telefone    TEXT        NOT NULL,
    endereco    TEXT        NOT NULL,
    cnh         TEXT        NOT NULL,
    id_funcao   INTEGER     NOT NULL REFERENCES funcao_colaborador(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE agencia_colaborador (
    id_colaborador      INTEGER     PRIMARY KEY REFERENCES colaborador(id),
    id_agencia          INTEGER     NOT NULL REFERENCES agencia(id)
);

CREATE TABLE categoria_veiculo (
    id          INTEGER     PRIMARY KEY,
    codigo      TEXT        NOT NULL,
    descricao   TEXT        NOT NULL,
    preco       INTEGER     NOT NULL -- preço em centavos para evitar erros devido à representação em memória do float64
);

CREATE TABLE situacao_veiculo (
    id          INTEGER     PRIMARY KEY,
    descricao   TEXT        NOT NULL
);

CREATE TABLE veiculo (
    id              INTEGER     PRIMARY KEY,
    placa           TEXT        NOT NULL,
    renavam         TEXT        NOT NULL,
    id_categoria    INTEGER     NOT NULL REFERENCES categoria_veiculo(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    id_agencia      INTEGER     NOT NULL REFERENCES agencia(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    id_situacao     INTEGER     NOT NULL REFERENCES situacao_veiculo(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE locacao (
    id                      INTEGER     PRIMARY KEY,
    id_cliente              INTEGER     NOT NULL REFERENCES cliente(id) ON UPDATE CASCADE ON DELETE CASCADE,
    data                    INTEGER     NOT NULL DEFAULT (strftime('%s', 'now')), -- unix timestamp
    id_veiculo              INTEGER     NOT NULL REFERENCES veiculo(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    id_agencia_retirada     INTEGER     NOT NULL REFERENCES agencia(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    data_esperada_retirada  INTEGER     NOT NULL,
    id_agencia_devolucao    INTEGER     NOT NULL REFERENCES agencia(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    data_esperada_devolucao INTEGER     NOT NULL
);

CREATE TABLE retirada (
    id_locacao      INTEGER     PRIMARY KEY REFERENCES locacao(id) ON UPDATE CASCADE ON DELETE CASCADE,
    data            INTEGER     NOT NULL DEFAULT (strftime('%s', 'now')),
    id_atendente    INTEGER     NOT NULL REFERENCES colaborador(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE devolucao (
    id_locacao      INTEGER     PRIMARY KEY REFERENCES locacao(id) ON UPDATE CASCADE ON DELETE CASCADE,
    data            INTEGER     NOT NULL DEFAULT (strftime('%s', 'now')),
    id_atendente    INTEGER     NOT NULL REFERENCES colaborador(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    observacoes     TEXT        NOT NULL,
    preco           INTEGER     NOT NULL
);
