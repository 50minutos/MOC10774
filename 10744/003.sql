USE DB

SELECT '-' + RTRIM(LTRIM('   abc   ')) + '-'

DECLARE @X VARCHAR(50) = 'AGNALDO' --ASCII (CHAR, VARCHAR, TEXT)
DECLARE @Y NVARCHAR(50) = 'AGNALDO' --UNICODE (NCHAR, NVARCHAR, NTEXT)

SELECT LEN(@X), 
	DATALENGTH(@X), 
	LEN(@Y), 
	DATALENGTH(@Y)

SELECT GETDATE(), --LOCAL
	SYSDATETIME(), --LOCAL
	SYSDATETIMEOFFSET(), --LOCAL COM FUSO
	SYSUTCDATETIME() --GREENWICH (FUSO HOR�RIO 0)

SELECT DAY(GETDATE()), 
	MONTH(GETDATE()), 
	YEAR(GETDATE())

SELECT DATEDIFF(DD, '19660912', GETDATE())

SELECT SUSER_SNAME(), 
	USER_NAME(), 
	HOST_NAME(),
	@@SPID, 
	APP_NAME()

GO

DECLARE @X INT
DECLARE @Y INT, @Z INT 

SELECT @X, @Y, @Z 

SET @X = 1
SET @Y = 2 --, @Z = 3
SELECT @Z = 3

SELECT @X, @Y, @Z 

DECLARE @N VARCHAR(50)

SET @N = @N + 'ABC'

SELECT @N

DECLARE @I INT 

SET @I += 1 -- -= *= /= %=

SELECT @I

--SELECT 1 = 2

GO

DECLARE @X INT = 1, @Y INT = 2
SELECT @X = @Y
--PRINT @X = @Y
SELECT @X, @Y

EXEC sp_tables

CREATE TABLE PRODUTO
(
	COD_PRODUTO INT IDENTITY, 
	NOME_PRODUTO VARCHAR(50), 
	PRECO_PRODUTO DEC(9, 2)
)

INSERT PRODUTO
VALUES ('MARTELO', 10), 
	('SERROTE', 20), 
	('MARRETA', 30)

SELECT *
FROM PRODUTO
WHERE COD_PRODUTO = 1

SELECT *, 
	PRECO_PRODUTO * 0.9
FROM PRODUTO

SELECT GETDATE() - 1, 
	RAND() * 10000

SELECT GETDATE() , 
	DATEADD(HH, -1, GETDATE())

SELECT 1/24, 
	1.0/24

SELECT GETDATE() - 1/24, 
	GETDATE() - 1.0/24.0

SELECT GETDATE(),
	GETDATE(),
	GETDATE(),
	GETDATE(),
	GETDATE()

DECLARE @DATA DATETIME2 = '17520914'

SELECT @DATA, 
	DATEADD(DD, -1, @DATA)

/*
CAMISETA BRANCA P 10
CAMISETA BRANCA M 05
CAMISETA BRANCA G 04
CAMISETA BRANCA X 12
CAMISETA PRETA  P 10
CAMISETA PRETA  M 05
CAMISETA PRETA  G 04
CAMISETA PRETA  X 12

--PIVOTEAR A TABELA

				   P     M     G     X
CAMISETA BRANCA   10    05    04    12
CAMISETA PRETA    10    05    04    12

--PIVOT/UNPIVOT TABLE
*/

--SELECT, SUBQUERY, CTE, UNION, EXCEPT, INTERSECT, AGREGA��O, ROWSET, CLASSIFICA��O, OFFSET, FETCH...

SELECT * 
FROM PRODUTO

DELETE PRODUTO
WHERE COD_PRODUTO = 2

SELECT * 
FROM PRODUTO

INSERT PRODUTO
VALUES ('A��CAR', 4)

SELECT * 
FROM PRODUTO

DBCC SHOWCONTIG('PRODUTO')

DBCC DBREINDEX('PRODUTO')

DBCC SHOWCONTIG('PRODUTO')

DECLARE @NOME_PRODUTO VARCHAR(50)

--SELECT @NOME_PRODUTO = NOME_PRODUTO	
--FROM PRODUTO
--WHERE COD_PRODUTO = 1

--SELECT @NOME_PRODUTO = NOME_PRODUTO	
--FROM PRODUTO
--WHERE COD_PRODUTO = 10

SELECT @NOME_PRODUTO = NOME_PRODUTO	
FROM PRODUTO

SELECT @NOME_PRODUTO

SELECT *
FROM PRODUTO
WHERE NOME_PRODUTO <> NULL --UNKNOWN (DESCONHECIDO)

SELECT *
FROM PRODUTO
WHERE NOME_PRODUTO IS NOT NULL --TRUE, FALSE

SELECT *
FROM PRODUTO

SELECT *
FROM PRODUTO
ORDER BY NOME_PRODUTO

--CTRL+L - PLANO DE EXECU��O ESTIMADO

SELECT *, 
	PRECO_PRODUTO * 1.1
FROM PRODUTO
