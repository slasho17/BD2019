CREATE DATABASE maternidade;

CREATE TABLE quarto
(
    quarto_numero smallint PRIMARY KEY CHECK(
        quarto_numero > 599
            AND quarto_numero < 700
    ),
    quarto_ala varchar(30) NOT NULL
);

CREATE TABLE plano_de_saude
(
    plano_de_saude_nome varchar(30) PRIMARY KEY
);

CREATE TABLE mae
(
    mae_cpf varchar(11) PRIMARY KEY,
    mae_forma_pagamento varchar(30) NOT NULL,
    mae_nome varchar(50) NOT NULL,
    mae_data_nascimento date NOT NULL,
    mae_telefone varchar(19) NOT NULL,
    mae_endereco_rua varchar(80) NOT NULL,
    mae_endereco_cep varchar(8) NOT NULL,
    mae_endereco_numero varchar(15) NOT NULL,
    mae_plano_de_saude varchar(30),

    FOREIGN KEY(mae_plano_de_saude) REFERENCES plano_de_saude(plano_de_saude_nome)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE medico
(
    medico_crm varchar(14) PRIMARY KEY,
    medico_cpf varchar(11) NOT NULL,
    medico_nome varchar(50) NOT NULL,
    medico_data_nascimento date NOT NULL,
    medico_telefone varchar(19) NOT NULL,
    medico_endereco_rua varchar(80) NOT NULL,
    medico_endereco_cep varchar(8) NOT NULL,
    medico_endereco_numero varchar(15) NOT NULL
);

CREATE TABLE timestamp_demo
(
    ts TIMESTAMP,
    tstz TIMESTAMPTZ
);
SET timezone
= 'America/Sao_Paulo';

CREATE TABLE bebe
(
    bebe_codigo int PRIMARY KEY,
    bebe_genero char(1) NOT NULL CHECK(
        bebe_genero = 'M' OR
            bebe_genero = 'F'
    ),
    bebe_hora_nascimento TIMESTAMP NOT NULL,
    bebe_peso_gramas real NOT NULL,
    bebe_altura_cm real NOT NULL,
    bebe_observacoes text NOT NULL,
    bebe_tipo_parto varchar(8) CHECK(
        bebe_tipo_parto =  'Normal' OR
            bebe_tipo_parto =  'Cesárea'
    ),
    bebe_mae varchar(11) NOT NULL,
    bebe_medico varchar(14) NOT NULL,

    FOREIGN KEY (bebe_mae) REFERENCES mae(mae_cpf)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (bebe_medico) REFERENCES medico(medico_crm)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE especializacao
(
    especializacao_medico varchar(14),
    especializacao_especializacao varchar(20),

    PRIMARY KEY(especializacao_medico,especializacao_especializacao),

    FOREIGN KEY (especializacao_medico) REFERENCES medico(medico_crm)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE hospedagem
(
    hospedagem_mae varchar(14) ,
    hospedagem_quarto smallint ,
    hospedagem_data_entrada date,

    PRIMARY KEY(hospedagem_mae,hospedagem_quarto, hospedagem_data_entrada),

    FOREIGN KEY (hospedagem_mae) REFERENCES mae(mae_cpf)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY(hospedagem_quarto) REFERENCES quarto(quarto_numero)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE cuida_mae
(
    cuida_mae_cpf varchar(11),
    cuida_mae_crm varchar(14),

    PRIMARY KEY (cuida_mae_cpf,cuida_mae_crm),

    FOREIGN KEY (cuida_mae_cpf) REFERENCES mae(mae_cpf)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (cuida_mae_crm) REFERENCES medico(medico_crm)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);