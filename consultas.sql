REQUISITO 1

SELECT quarto_numero, quarto_ala
FROM quarto, hospedagem
WHERE hospedagem_quarto = quarto_numero AND hospedagem_data_entrada = '12-09-2016'


REQUISITO 2

SELECT mae_nome, count(bebe)
From mae, bebe
WHERE bebe_mae = mae_cpf
GROUP BY mae_cpf

REQUISITO 3

SELECT mae_nome, mae_plano_de_saude
FROM mae
WHERE mae_plano_de_saude
NOTNULL

REQUISITO 4

SELECT bebe_codigo, medico_nome, medico_crm
FROM bebe, medico
WHERE bebe_medico = medico_crm