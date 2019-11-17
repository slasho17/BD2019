CREATE DATABASE maternidade;

CREATE TABLE Quarto
(
    numero_quarto smallint PRIMARY KEY CHECK(
        numero_quarto > 599
            AND numero_quarto < 700
    ),
    ala_quarto varchar(30) NOT NULL
);

CREATE TABLE Plano_de_saude
(
    nome_plano_saude varchar(30) PRIMARY KEY
);

CREATE TABLE Mae
(
    mae_cpf varchar(11) PRIMARY KEY,
    mae_forma_pagamento varchar(30) NOT NULL,
    mae_nome varchar(50) NOT NULL,
    mae_data_nascimento date NOT NULL,
    mae_telefone varchar(19) NOT NULL,
    mae_endereco_rua varchar(80) NOT NULL,
    mae_endereco_CEP varchar(8) NOT NULL,
    mae_endereco_numero varchar(15) NOT NULL,
    mae_plano_de_saude varchar(30),

    FOREIGN KEY(mae_plano_de_saude) REFERENCES plano_de_saude(nome_plano_saude)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Medico
(
    crm varchar(14) PRIMARY KEY,
    cpf_medico varchar(11) NOT NULL,
    nome_medico varchar(50) NOT NULL,
    nascimento_medico date NOT NULL,
    telefone_medico varchar(19) NOT NULL,
    rua varchar(80) NOT NULL,
    CEP varchar(8) NOT NULL,
    numero varchar(15) NOT NULL
);

CREATE TABLE timestamp_demo
(
    ts TIMESTAMP,
    tstz TIMESTAMPTZ
);
SET timezone
= 'America/Sao_Paulo';

CREATE TABLE Bebe
(
    codigo int PRIMARY KEY,
    bebe_genero char(1) NOT NULL CHECK(
        bebe_genero = 'M' OR
            bebe_genero = 'F'
    ),
    hora_nascimento TIMESTAMP NOT NULL,
    bebe_peso real NOT NULL,
    bebe_altura real NOT NULL,
    bebe_observacoes text NOT NULL,
    tipo_parto varchar(8) CHECK(
        tipo_parto =  'Normal' OR
        tipo_parto =  'Cesárea'
    ),
    mae varchar(11) NOT NULL,
    medico varchar(14) NOT NULL,

    FOREIGN KEY (mae) REFERENCES Mae(mae_cpf)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (medico) REFERENCES Medico(crm)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Especializacao
(
    crm_medico varchar(14),
    especializacao varchar(20),

    PRIMARY KEY(crm_medico,especializacao),

    FOREIGN KEY (crm_medico) REFERENCES Medico(crm)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Hospedagem
(
    cpf_mae varchar(14) ,
    numero_quarto smallint ,
    data_entrada date,

    PRIMARY KEY(data_entrada, cpf_mae, numero_quarto),

    FOREIGN KEY (cpf_mae) REFERENCES Mae(mae_cpf)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY(numero_quarto) REFERENCES Quarto(numero_quarto)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Cuida_da_mae
(
    cpf_mae varchar(11),
    crm_medico varchar(14),
    data_inicio date,

    PRIMARY KEY (cpf_mae,crm_medico, data_inicio),

    FOREIGN KEY (cpf_mae) REFERENCES Mae(mae_cpf)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (crm_medico) REFERENCES Medico(crm)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);