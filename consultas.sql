--REQUISITO 1

SELECT q.numero_quarto, q.ala_quarto
FROM Quarto q, Hospedagem h
WHERE q.numero_quarto = h.numero_quarto AND h.data_entrada = <Data entrada>


--REQUISITO 2

SELECT m.mae_nome, count(Bebe)
From Mae m, Bebe b
WHERE b.mae = m.mae_cpf
GROUP BY m.mae_cpf

--REQUISITO 3

SELECT m.mae_nome, m.mae_plano_de_saude
FROM Mae m
WHERE m.mae_plano_de_saude
NOTNULL

--REQUISITO 4

SELECT m.nome_medico, m.crm
FROM bebe b, medico m
WHERE b.medico = m.crm

--REQUISITO 5
SELECT b.mae, b.codigo, m.mae_nome 
FROM Bebe b, Mae m
WHERE m.mae_cpf = b.mae AND b.medico = <crm>

--REQUISITO 6
SELECT c.cpf_mae, c.data_inicio, m.mae_nome
FROM Cuida_da_mae c, Mae m
WHERE m.mae_cpf = c.cpf_mae AND c.crm_medico = <crm>

--REQUISITO 7
select count(codigo) from Bebe
where date(hora_nascimento) = <data>

--REQUISITO 8
SELECT tipo_parto, COUNT(*)
FROM Bebe
WHERE tipo_parto = 'Cesárea'
GROUP BY tipo_parto