CREATE DATABASE DB
GO

USE DB

CREATE TABLE ESTADO
(
	SIGLA_ESTADO CHAR(2), 
	NOME_ESTADO VARCHAR(50)
)

INSERT ESTADO
VALUES ('SP', 'S�O PAULO'), 
	('MG', 'MINAS GERAIS')

CREATE TABLE CIDADE
(
	COD_CIDADE INT IDENTITY, 
	NOME_CIDADE VARCHAR(50), 
	SIGLA_ESTADO CHAR(2)
)

INSERT CIDADE 
VALUES ('S�O PAULO', 'SP'), 
('BERZONTE', 'MG'), 
('POUSO ALEGRE', 'MG'), 
('SOROCABA', 'SP'), 
('RIO DE JANEIRO', 'RJ'), 
('CAMPINAS', NULL)

SELECT *
FROM CIDADE C
/*INNER*/ JOIN ESTADO E --RETORNA OS DADOS QUE EXISTEM NAS DUAS TABELAS
	ON E.SIGLA_ESTADO = C.SIGLA_ESTADO

SELECT *
FROM CIDADE C
/*INNER*/ JOIN ESTADO E --RETORNA OS DADOS QUE EXISTEM NAS DUAS TABELAS
	ON E.SIGLA_ESTADO = C.SIGLA_ESTADO
WHERE E.SIGLA_ESTADO = 'SP'

SELECT *
FROM CIDADE C
/*INNER*/ JOIN ESTADO E --RETORNA OS DADOS QUE EXISTEM NAS DUAS TABELAS
	ON E.SIGLA_ESTADO = C.SIGLA_ESTADO
		AND E.SIGLA_ESTADO = 'SP'

SELECT *
FROM CIDADE 
CROSS JOIN ESTADO --PRODUTO CARTESIANO ENTRE AS DUAS TABELAS

SELECT *
FROM SYS.objects O1
CROSS JOIN SYS.objects O2
CROSS JOIN SYS.objects O3

SELECT *
FROM CIDADE C 
LEFT /*OUTER*/ JOIN ESTADO E --RETORNA TODA A TABELA DA ESQUERDA
	ON E.SIGLA_ESTADO = C.SIGLA_ESTADO

INSERT ESTADO 
VALUES ('CE', 'CEAR�')
 
SELECT *
FROM CIDADE C 
RIGHT /*OUTER*/ JOIN ESTADO E --RETORNA TODA A TABELA DA DIREITA
	ON E.SIGLA_ESTADO = C.SIGLA_ESTADO
	
SELECT *
FROM CIDADE C 
FULL /*OUTER*/ JOIN ESTADO E --RETORNA TODAS AS DUAS TABELAS
	ON E.SIGLA_ESTADO = C.SIGLA_ESTADO
	
--CLIENTE 1000
--PEDIDO 10000
--ITEM_PEDIDO 100000 

--SELECT *
--FROM ITEM_PEDIDO IP
--JOIN PEDIDO P
--	ON P.COD_PEDIDO = IP.COD_PEDIDO
--JOIN CLIENTE C
--	ON C.COD_CLIENTE = P.COD_CLIENTE
--WHERE C.COD_CLIENTE = 1 

--SELECT *
--FROM CLIENTE C 
--JOIN PEDIDO P
--	ON C.COD_CLIENTE = P.COD_CLIENTE
--JOIN ITEM_PEDIDO IP
--	ON P.COD_PEDIDO = IP.COD_PEDIDO
--WHERE C.COD_CLIENTE = 1 
----OU
--SELECT *
--FROM CLIENTE C 
--JOIN PEDIDO P
--	ON C.COD_CLIENTE = P.COD_CLIENTE
--		AND C.COD_CLIENTE = 1 
--JOIN ITEM_PEDIDO IP
--	ON P.COD_PEDIDO = IP.COD_PEDIDO

SELECT *
FROM CIDADE C, 
	ESTADO E
WHERE E.SIGLA_ESTADO = C.SIGLA_ESTADO

--SELECT *
--FROM CIDADE C, 
--	ESTADO E
--WHERE E.SIGLA_ESTADO *= C.SIGLA_ESTADO

--SELECT *
--FROM CIDADE C, 
--	ESTADO E
--WHERE E.SIGLA_ESTADO =* C.SIGLA_ESTADO

SELECT *
FROM CIDADE C
JOIN ESTADO E
	ON E.SIGLA_ESTADO = C.SIGLA_ESTADO

SELECT C.*
FROM CIDADE C
LEFT JOIN ESTADO E
	ON E.SIGLA_ESTADO = C.SIGLA_ESTADO
WHERE E.SIGLA_ESTADO IS NULL

SELECT E.*
FROM CIDADE C
RIGHT JOIN ESTADO E
	ON E.SIGLA_ESTADO = C.SIGLA_ESTADO
WHERE C.COD_CIDADE IS NULL

CREATE TABLE FUNCIONARIO
(
	COD_FUNCIONARIO INT IDENTITY,
	NOME_FUNCIONARIO VARCHAR(50), 
	COD_SUPERIOR INT 
)

INSERT FUNCIONARIO
VALUES ('DIRETOR', NULL), --1
('GERENTE', 1), --2
('ASSISTENTE A', 2), 
('ASSISTENTE B', 2), 
('PUXA-SACO', 1)

SELECT F.NOME_FUNCIONARIO, 
	S.NOME_FUNCIONARIO AS 'NOME_SUPERIOR'
FROM FUNCIONARIO F
LEFT JOIN FUNCIONARIO S
	ON S.COD_FUNCIONARIO = F.COD_SUPERIOR
ORDER BY NOME_SUPERIOR