USE DB

EXEC sp_MSforeachtable 'DROP TABLE ?'

CREATE TABLE PESSOA
(
	COD_PESSOA INT IDENTITY, 
	NOME_PESSOA VARCHAR(50), 
	SEXO_PESSOA CHAR(1)
)

CREATE TABLE FUNCIONARIO
(
	COD_FUNCIONARIO INT IDENTITY, 
	NOME_FUNCIONARIO VARCHAR(50), 
	DATA_CONTRATACAO_FUNCIONARIO DATE
)


CREATE TABLE CLIENTE
(
	COD_CLIENTE INT IDENTITY, 
	NOME_CLIENTE VARCHAR(50), 
	RG VARCHAR(12), 
	CPF CHAR(11)
)

INSERT PESSOA 
VALUES ('AD�O', 'M'), 
	('EVA', 'F'), 
	('CAIM', 'M'), 
	('ABEL', 'M')

INSERT FUNCIONARIO 
VALUES ('AD�O', '20130506'), 
	('EVA', GETDATE())

INSERT CLIENTE 
VALUES ('EPAMINONDAS', '1.234.543-X', '11122233344')

SELECT NOME_PESSOA
FROM PESSOA
UNION --N�O RETORNA REPETIDOS (E RETORNA ORDENADOS)
SELECT NOME_FUNCIONARIO
FROM FUNCIONARIO

SELECT NOME_PESSOA
FROM PESSOA
UNION ALL--RETORNA REPETIDOS (E RETORNA DESORDENADOS)
SELECT NOME_FUNCIONARIO
FROM FUNCIONARIO

SELECT COD_PESSOA AS 'COD', 
	NOME_PESSOA AS 'NOME', 
	SEXO_PESSOA AS 'SEXO', 
	NULL AS 'DATA_CONTRATACAO', 
	NULL AS 'RG', 
	NULL AS 'CPF'
FROM PESSOA
UNION
SELECT COD_FUNCIONARIO, 
	NOME_FUNCIONARIO, 
	NULL, 
	DATA_CONTRATACAO_FUNCIONARIO, 
	NULL, 
	NULL
FROM FUNCIONARIO
UNION 
SELECT COD_CLIENTE, 
	NOME_CLIENTE, 
	NULL, 
	NULL, 
	RG, 
	CPF
FROM CLIENTE

SELECT NOME_CLIENTE AS 'NOME', 
	'CLIENTE' AS 'TABELA'
FROM CLIENTE
UNION ALL
SELECT NOME_PESSOA, 
	'PESSOA'
FROM PESSOA
UNION ALL
SELECT NOME_FUNCIONARIO, 
	'FUNCIONARIO'
FROM FUNCIONARIO
ORDER BY NOME

SELECT NOME_FUNCIONARIO
FROM FUNCIONARIO
INTERSECT
SELECT NOME_PESSOA
FROM PESSOA

SELECT NOME_PESSOA
FROM PESSOA
EXCEPT
SELECT NOME_FUNCIONARIO
FROM FUNCIONARIO

SELECT *
FROM PESSOA

SELECT *, 
	CASE SEXO_PESSOA 
		WHEN 'M' THEN 'MASCULINO'
		WHEN 'F' THEN 'FEMININO'
		ELSE 'N�O INFORMADO'
	END AS SEXO_PESSOA
FROM PESSOA

SELECT *, 
	IIF(SEXO_PESSOA = 'M', 'MASCULINO', IIF(SEXO_PESSOA = 'F', 'FEMININO', 'N�O INFORMADO'))
FROM PESSOA

GO

CREATE FUNCTION UDF_SEXO
(
	@LETRA CHAR(1)
)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @RETORNO VARCHAR(20) = 'N�O INFORMADO'

	IF @LETRA = 'M' 
		SET @RETORNO = 'MASCULINO'

	IF @LETRA = 'F' 
		SET @RETORNO = 'FEMININO'

	RETURN @RETORNO
END

SELECT *, 
	DBO.UDF_SEXO(SEXO_PESSOA)
FROM PESSOA

CREATE TABLE SEXO
(
	LETRA_SEXO CHAR(1), 
	DESCRICAO_SEXO VARCHAR(20)
)

INSERT SEXO
VALUES ('M', 'MASCULINO'), 
	('F', 'FEMININO') 

SELECT *
FROM PESSOA P
JOIN SEXO S
	ON S.LETRA_SEXO =  P.SEXO_PESSOA

GO

CREATE FUNCTION UDF_SEXO_TABELA()
RETURNS @RETORNO TABLE
(
	LETRA_SEXO CHAR(1), 
	DESCRICAO_SEXO VARCHAR(20)
)
AS
BEGIN
	INSERT @RETORNO
	VALUES ('M', 'MASCULINO'), 
		('F', 'FEMININO') 
	
	RETURN
END
GO

SELECT *
FROM DBO.UDF_SEXO_TABELA()

SELECT *
FROM PESSOA P 
JOIN DBO.UDF_SEXO_TABELA() X
	ON X.LETRA_SEXO = P.SEXO_PESSOA

SELECT *
FROM PESSOA P
CROSS APPLY DBO.UDF_SEXO_TABELA() X
WHERE X.LETRA_SEXO = P.SEXO_PESSOA

CREATE TABLE TIPO_PRODUTO 
(
	COD_TIPO_PRODUTO INT IDENTITY PRIMARY KEY, 
	NOME_TIPO_PRODUTO VARCHAR(50) UNIQUE
)

CREATE TABLE PRODUTO
(
	COD_PRODUTO INT IDENTITY PRIMARY KEY, 
	NOME_PRODUTO VARCHAR(50), 
	PRECO_PRODUTO DEC(9,2), 
	COD_TIPO_PRODUTO INT REFERENCES TIPO_PRODUTO
)

INSERT TIPO_PRODUTO 
VALUES ('MATERIAL DE ESCRIT�RIO'), 
	('FERRAMENTA')
	
INSERT PRODUTO 
VALUES ('CADERNO 10 MAT 200 FLS', 10, 1), 
	('GRAMPEADOR 26/6', 20, 1), 
	('R�GUA 30 CM COM 30 UN', 30, 1), 
	('MARRETA', 40, 2), 
	('MARTELO', 50, 2), 
	('SERROTE', 60, 2), 
	('SARGENTO', 70, 2)

GO

CREATE FUNCTION UDF_PRODUTOS_POR_TIPO_PRODUTO
(
	@COD_TIPO_PRODUTO INT
)
RETURNS @RETORNO TABLE 
	(
		COD_PRODUTO INT, 
		NOME_PRODUTO VARCHAR(50), 
		PRECO_PRODUTO DEC(9,2), 
		COD_TIPO_PRODUTO INT, 
		NOME_TIPO_PRODUTO VARCHAR(50)
	)
AS
BEGIN
	INSERT @RETORNO
	SELECT P.COD_PRODUTO,
		P.NOME_PRODUTO, 
		P.PRECO_PRODUTO, 
		TP.COD_TIPO_PRODUTO,   
		TP.NOME_TIPO_PRODUTO
	FROM PRODUTO P 
	JOIN TIPO_PRODUTO TP 
		ON TP.COD_TIPO_PRODUTO = P.COD_TIPO_PRODUTO
	WHERE TP.COD_TIPO_PRODUTO = @COD_TIPO_PRODUTO

	RETURN
END
GO

SELECT *
FROM UDF_PRODUTOS_POR_TIPO_PRODUTO(2)

--SELECT * 
--FROM TIPO_PRODUTO TP
--JOIN UDF_PRODUTOS_POR_TIPO_PRODUTO(TP.COD_TIPO_PRODUTO) X
--	ON ...

SELECT *
FROM TIPO_PRODUTO
CROSS APPLY UDF_PRODUTOS_POR_TIPO_PRODUTO(COD_TIPO_PRODUTO)

GO