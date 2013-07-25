USE DB 

EXEC sp_MSforeachtable 'DROP TABLE ?' 
EXEC sp_MSforeachtable 'DROP TABLE ?' 

DECLARE @X INT
--GO
SELECT @X

GO

DECLARE @X INT = 10

SELECT @X

SET @X += 10 -- += -= *= /= %= -> @X = @X % 10

SELECT @X

CREATE TABLE PRODUTO
(
	COD_PRODUTO INT IDENTITY, 
	NOME_PRODUTO VARCHAR(50), 
	PRECO_PRODUTO DEC(9, 2)
)

INSERT PRODUTO 
VALUES ('MARTELO', 10), 
	('MARRETA', 20), 
	('SERROTE', 30)

DECLARE @PRECO_PRODUTO DEC(9, 2)

SELECT @PRECO_PRODUTO = PRECO_PRODUTO
FROM PRODUTO 
WHERE COD_PRODUTO = 1

SELECT @PRECO_PRODUTO

GO

DECLARE @PRECO_PRODUTO DEC(9, 2)

SELECT @PRECO_PRODUTO = PRECO_PRODUTO
FROM PRODUTO 
WHERE COD_PRODUTO = 100

SELECT @PRECO_PRODUTO

GO

CREATE PROC USP_OBTER_PRECO_PRODUTO 
	@COD_PRODUTO INT, 
	@PRECO_PRODUTO DEC(9,2) OUTPUT
AS
	SELECT @PRECO_PRODUTO = PRECO_PRODUTO
	FROM PRODUTO 
	WHERE COD_PRODUTO = @COD_PRODUTO
GO

DECLARE @PRECO_PRODUTO DEC(9, 2)

EXEC USP_OBTER_PRECO_PRODUTO 1, @PRECO_PRODUTO OUTPUT

SELECT @PRECO_PRODUTO

GO

CREATE SYNONYM P
FOR DB.DBO.PRODUTO
GO

SELECT *
FROM P

USE MASTER 

--IF EXISTS(SELECT)
--	--VERDADEIRO
--ELSE --OPCIONAL
--	--FALSO

--IF COND
--BEGIN 
--	LINHA
--	LINHA
--END 
--ELSE
--BEGIN
--	LINHA
--	LINHA
--END

DECLARE @X INT = 102

IF @X % 2 = 0 
	PRINT '@X � PAR'
ELSE
	PRINT '@X � �MPAR'

DECLARE @I INT = 1

WHILE @I <= 3
BEGIN
	PRINT @I

	SET @I += 1 
END

WHILE 1=1 
BEGIN
	PRINT CONVERT(VARCHAR, GETDATE(), 121)
END

GO

DECLARE @T TABLE(C1 INT IDENTITY, COD_PRODUTO INT, NOME_PRODUTO VARCHAR(50), PRECO_PRODUTO DEC(9,2)) 

DECLARE @X INT = 1 
DECLARE @QTD INT

INSERT @T 
SELECT * 
FROM PRODUTO

SELECT @QTD = COUNT(*) FROM @T

WHILE @X <= @QTD
BEGIN
	SELECT * 
	FROM @T 
	WHERE C1 = @X

	SET @X += 1
END
