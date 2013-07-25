USE DB

GO

CREATE PROC USP_MENSAGEM
AS
	SELECT 'HELLO WORLD!!!'
GO

EXEC USP_MENSAGEM
EXEC USP_MENSAGEM
EXEC USP_MENSAGEM

EXEC SP_HELP
EXEC SP_HELP

SP_HELP
SP_HELP

GO

CREATE PROC USP_RETORNA_INT
AS
	RETURN 120
GO

DECLARE @X INT 

--COMANDO
EXEC @X = USP_RETORNA_INT

SELECT @X 

--FUN��O 
EXEC(N'SELECT GETDATE()')

GO

CREATE PROC USP_RETORNA_DEC
AS
	RETURN PI()
GO

DECLARE @X DEC(16,5)

EXEC @X = USP_RETORNA_DEC

SELECT @X

GO

CREATE PROC USP_RETORNA_DATE_VARCHAR
AS
	RETURN 'XPTO' --GETDATE()
GO

EXEC USP_RETORNA_DATE_VARCHAR

GO

CREATE PROC USP_SOMAR
	@X INT, 
	@Y INT
AS
	SELECT @X + @Y
GO

EXEC USP_SOMAR @X = 10, @Y = 20

GO

CREATE PROC USP_DIVIDIR
	@X DEC(9,2), 
	@Y DEC(9,2)
AS
	SELECT @X / @Y
GO

EXEC USP_DIVIDIR @X = 10, @Y = 20
EXEC USP_DIVIDIR @Y = 10, @X = 20
EXEC USP_DIVIDIR 10, 20

GO

CREATE PROC USP_SOMAR_OUTPUT
	@X INT, 
	@Y INT, 
	@Z INT OUTPUT, 
	@MENOR INT OUTPUT, 
	@MAIOR INT OUTPUT
AS
	SET @Z = @X + @Y
	SET @MENOR = IIF(@X < @Y, @X, @Y)
	SET @MAIOR = IIF(@X > @Y, @X, @Y)
GO

DECLARE @Z INT, @MENOR INT, @MAIOR INT

EXEC USP_SOMAR_OUTPUT 10, 20, @Z OUTPUT, @MENOR OUTPUT, @MAIOR OUTPUT

SELECT 10, 20, @Z, @MENOR, @MAIOR

GO

EXEC SP_TABLES

GO

CREATE PROC USP_PRODUTO_SELECT
AS
	SELECT *
	FROM PRODUTO
GO

CREATE PROC USP_PRODUTO_INSERT
	@NOME_PRODUTO VARCHAR(50), 
	@PRECO_PRODUTO DEC(9,2)
AS
	INSERT PRODUTO
	VALUES (@NOME_PRODUTO, @PRECO_PRODUTO)
GO

CREATE PROC USP_PRODUTO_UPDATE
	@COD_PRODUTO INT, 
	@NOME_PRODUTO VARCHAR(50), 
	@PRECO_PRODUTO DEC(9,2)
AS
	UPDATE PRODUTO
	SET NOME_PRODUTO = @NOME_PRODUTO, 
		PRECO_PRODUTO = @PRECO_PRODUTO
	WHERE COD_PRODUTO = @COD_PRODUTO
GO

CREATE PROC USP_PRODUTO_DELETE
	@COD_PRODUTO INT
AS
	DELETE PRODUTO
	WHERE COD_PRODUTO = @COD_PRODUTO
GO

EXEC USP_PRODUTO_SELECT
EXEC USP_PRODUTO_INSERT 'CHAVE DE FENDA', 10
EXEC USP_PRODUTO_UPDATE 2, 'MARRETA ALTERADA', 20
EXEC USP_PRODUTO_DELETE 1
EXEC USP_PRODUTO_SELECT

GO

CREATE PROC USP_OPCIONAL
	@X INT, 
	@Y INT = 2 --OPCIONAL
AS
	SELECT POWER(@X, @Y)
GO
 
EXEC USP_OPCIONAL 3, 3
EXEC USP_OPCIONAL 3

GO

CREATE PROC USP_OPCIONAL_2
	@X INT = 10, 
	@Y INT = 2 
AS
	SELECT POWER(@X, @Y)
GO
 
--EXEC USP_OPCIONAL_2 (SELECT 1)

DECLARE @QTD INT

SELECT @QTD = COUNT(*) FROM PRODUTO

EXEC USP_OPCIONAL_2 @Y = @QTD

DECLARE @X NVARCHAR(MAX) = 'SELECT * FROM PRODUTO WHERE NOME_PRODUTO LIKE ''%' + 'MAR' + '%'''

EXEC(@X)

--SQL INJECTION

GO

DECLARE @X NVARCHAR(MAX) = 'SELECT * FROM PRODUTO WHERE NOME_PRODUTO LIKE ''%' + 'MAR'';EXEC SP_MSFOREACHTABLE ''DROP TABLE ?'' --' + '%'''

EXEC(@X)

SELECT * 
FROM PRODUTO

--PHP INJECTION

--c#
--...
--var cmd = 'SELECT * FROM PRODUTO WHERE NOME_PRODUTO LIKE ''@X''';
--cmd.Parameters.AddWithValue('@X', 'MAR'';EXEC SP_MSFOREACHTABLE ''DROP TABLE ?'' --')
--...

GO

DECLARE @X NVARCHAR(MAX) = 'SELECT * FROM PRODUTO WHERE NOME_PRODUTO LIKE ''%' + 'MAR' + '%'''

EXEC SP_EXECUTESQL @X

GO

DECLARE @S NVARCHAR(MAX) = 'SELECT * FROM PRODUTO WHERE NOME_PRODUTO LIKE ''%@X%'''

EXEC SP_EXECUTESQL @S, N'@X VARCHAR(50)', N'MAR'

SELECT * 
FROM SYS.OBJECTS 
WHERE OBJECT_ID = 1

CREATE TABLE PRODUTO
(
	COD_PRODUTO INT IDENTITY, 
	NOME_PRODUTO VARCHAR(50), 
	PRECO_PRODUTO DEC(9,2)
)

SELECT * 
FROM PRODUTO
WHERE COD_PRODUTO = 1

SELECT * 
FROM PRODUTO
WHERE COD_PRODUTO = 2

