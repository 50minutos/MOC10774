USE DB

USE MASTER

EXEC SP_HELPTEXT SYSOBJECTS

SELECT * 
FROM SYSOBJECTS

SELECT * 
FROM SYS.OBJECTS

SELECT OBJECT_DEFINITION (object_id), 
	* 
FROM sys.VIEWS

SELECT SO.NAME AS 'OBJECT', 
	SC.NAME AS 'COLUMN', 
	ST.NAME AS 'TYPE', 
	SC.MAX_LENGTH AS 'LENGTH', 
	SC.PRECISION AS 'PRECISION', 
	SC.SCALE AS 'SCALE', 
	SC.COLLATION_NAME AS 'COLLATION'
FROM SYS.OBJECTS SO 
INNER JOIN SYS.COLUMNS SC
	ON SO.OBJECT_ID = SC.OBJECT_ID
INNER JOIN SYS.TYPES ST
	ON SC.USER_TYPE_ID = ST.USER_TYPE_ID
WHERE SO.OBJECT_ID = OBJECT_ID('PEDIDO')

EXEC SP_TABLES PEDIDO

EXEC SP_HELP PEDIDO

GO

CREATE VIEW UV_PEDIDO
AS
	SELECT COD_CLIENTE, 
		NOME_CLIENTE, 
		VALOR_PEDIDO
	FROM PEDIDO
GO

EXEC SP_HELP UV_PEDIDO

EXEC SP_HELPTEXT UV_PEDIDO

SELECT SO.NAME, 
	SC.TEXT
FROM SYS.OBJECTS SO 
INNER JOIN SYSCOMMENTS SC 
	ON SO.OBJECT_ID = SC.ID
	
EXEC SP_HELPTEXT SYSCOMMENTS

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'PEDIDO'

SELECT *
FROM INFORMATION_SCHEMA.TABLES

SELECT *
FROM INFORMATION_SCHEMA.VIEWS

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UV_PEDIDO'

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'COD_CLIENTE'

SELECT *
FROM SYS.DM_EXEC_REQUESTS

EXEC SP_WHO

USE MASTER

EXEC SP_HELP SP_HELPTEXT

SELECT *
FROM SYS.DM_EXEC_REQUESTS

SELECT *
FROM SYS.DM_EXEC_SQL_TEXT(0x02000000E354C1325BCDD424957868E83FD274DAD8E9224D0000000000000000000000000000000000000000)

EXEC SP_WHO

DBCC INPUTBUFFER(53)

DBCC OUTPUTBUFFER(53)

EXEC SP_DATABASES

EXEC SP_HELPDB

EXEC SP_HELPDB DB

USE DB

EXEC SP_HELP

EXEC SP_HELP PEDIDO

EXEC SP_HELPTEXT UV_PEDIDO

EXEC SP_HELPINDEX PEDIDO

CREATE CLUSTERED INDEX IDX_PEDIDO_COD_CLIENTE
ON PEDIDO(COD_CLIENTE)

EXEC SP_HELPINDEX PEDIDO

SELECT DB_NAME()

SELECT DB_NAME(5)

SELECT DB_ID()

SELECT DB_ID('DB')

SELECT COLUMNPROPERTY(OBJECT_ID('PEDIDO'), 'COD_CLIENTE', 'ISIDENTITY')

EXEC SP_HELP PEDIDO

EXEC SP_HELPTEXT SP_HELP

USE DB

SELECT *
FROM SYS.IDENTITY_COLUMNS 
WHERE object_id = OBJECT_ID('PRODUTO')