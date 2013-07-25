
CREATE TABLE CIDADE
(
	COD_CIDADE INT IDENTITY, 
	NOME_CIDADE VARCHAR(50),
	SIGLA_ESTADO CHAR(2) 
)

INSERT CIDADE 
VALUES ('SAO PAULO', 'SP'), 
('BELO HORIZONTE', 'MG'), 
('POUSO ALEGRE', 'MG'), 
('SAO JOAO DA BOA VISTA', 'SP')

SELECT SIGLA_ESTADO
FROM CIDADE

SELECT DISTINCT SIGLA_ESTADO
FROM CIDADE

--SELECT DISTINCT SIGLA_ESTADO, NOME_CIDADE
--FROM CIDADE

SELECT SIGLA_ESTADO
FROM CIDADE
GROUP BY SIGLA_ESTADO

SELECT *, 
	PRECO_PRODUTO * 1.1 AS 'NOVO_PRECO_PRODUTO'
FROM PRODUTO

SELECT *, 
	PRECO_PRODUTO * 1.1 'NOVO_PRECO_PRODUTO'
FROM PRODUTO

SELECT *, 
	PRECO_PRODUTO * 1.1 AS [NOVO_PRECO_PRODUTO]
FROM PRODUTO

SELECT *, 
	PRECO_PRODUTO * 1.1 [NOVO_PRECO_PRODUTO]
FROM PRODUTO

SELECT *, 
	PRECO_PRODUTO * 1.1 AS NOVO_PRECO_PRODUTO
FROM PRODUTO

SELECT *, 
	PRECO_PRODUTO * 1.1 NOVO_PRECO_PRODUTO
FROM PRODUTO

SELECT *, 
	'NOVO_PRECO_PRODUTO' = PRECO_PRODUTO * 1.1
FROM PRODUTO

SELECT *, 
	[NOVO_PRECO_PRODUTO] = PRECO_PRODUTO * 1.1
FROM PRODUTO

SELECT *, 
	NOVO_PRECO_PRODUTO = PRECO_PRODUTO * 1.1
FROM PRODUTO

SELECT NOME_PRODUTO AS 'NOME DA BAGA�A'
FROM PRODUTO

SELECT NOME_PRODUTO AS [PRIMARY]
FROM PRODUTO

SELECT COD_PRODUTO, 
	NOME_PRODUTO, 
	PRECO_PRODUTO, 
	VENDA_PRODUTO = PRECO_PRODUTO * RAND(), 
	CUSTO_PRODUTO = PRECO_PRODUTO * 0.7
FROM PRODUTO 
ORDER BY VENDA_PRODUTO

SELECT *
FROM PRODUTO 
ORDER BY NEWID()

SELECT NEWID()

SELECT NAME 
FROM SYS.objects

SELECT NAME 
FROM SYS.columns

SELECT SO.NAME AS 'TABLE/VIEW', 
	SC.NAME AS 'COLUMN'
FROM SYS.objects SO
JOIN SYS.columns SC
	ON SO.object_id = SC.object_id

SELECT SO.NAME AS 'TABLE/VIEW', 
	SC.NAME AS 'COLUMN'
FROM SYS.objects SO
JOIN SYS.columns SC
	ON SO.object_id = SC.object_id
WHERE SO.object_id = OBJECT_ID('PRODUTO')

CREATE TABLE PESSOA 
(
	COD_PESSOA INT IDENTITY, 
	NOME_PESSOA VARCHAR(50), 
	SEXO_PESSOA CHAR(1)
)

INSERT PESSOA 
VALUES ('AD�O', 'M'), 
	('EVA', 'F'), 
	('CAIM', 'M'), 
	('ABEL', 'N'), 
	('EPAMINONDAS', NULL)

SELECT COD_PESSOA,
	NOME_PESSOA, 
	CASE SEXO_PESSOA 
		WHEN 'M' THEN 'MASCULINO'
		WHEN 'F' THEN 'FEMININO'
		ELSE 'N�O INFORMADO' 
	END AS 'SEXO_PESSOA'
FROM PESSOA

SELECT COD_PESSOA,
	NOME_PESSOA, 
	CASE WHEN SEXO_PESSOA = 'M' 
		THEN 'MASCULINO'
	ELSE 
		CASE WHEN SEXO_PESSOA = 'F' 
				THEN 'FEMININO'
				ELSE 'N�O INFORMADO' 
		END 
	END AS 'SEXO_PESSOA'
FROM PESSOA
