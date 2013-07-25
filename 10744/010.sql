USE DB

EXEC sp_MSforeachtable 'DROP TABLE ?'

CREATE TABLE CATEGORIA_PRODUTO
(
	COD_CATEGORIA_PRODUTO INT IDENTITY, 
	NOME_CATEGORIA_PRODUTO VARCHAR(50)
)

CREATE TABLE PRODUTO
(
	COD_PRODUTO INT IDENTITY, 
	NOME_PRODUTO VARCHAR(50), 
	PRECO_PRODUTO DEC(9,2), 
	COD_CATEGORIA_PRODUTO INT
)

CREATE TABLE PEDIDO
(
	COD_PEDIDO INT IDENTITY, 
	DATA_PEDIDO DATE
)

CREATE TABLE ITEM_PEDIDO
(
	COD_ITEM_PEDIDO INT IDENTITY, 
	COD_PEDIDO INT, 
	COD_PRODUTO INT, 
	QTD_ITEM_PEDIDO INT, 
	PRECO_ITEM_PEDIDO DEC(9,2)
)

INSERT CATEGORIA_PRODUTO
VALUES ('FERRAMENTA'), 
	('MATERIAL DE ESCRIT�RIO')
	
INSERT PRODUTO
VALUES ('MARTELO UN', 10, 1), 
	('MARRETA UN', 10, 1), 
	('SERROTE UN', 29, 1), 
	('CHAVE TORKS UN', 12, 1), 
	('CHAVE DE FENDA UN', 12, 1), 
	('CHAVE PHILIPS UN', 12, 1), 
	('CEGUETA UN', 15, 1), 
	('SARGENTO UN', 12, 1), 
	('TIJOLO MILHEIRO', 300, 1), 
	('CIMENTO 50KG', 20, 1), 
	('PEDRA M�', 13, 1), 
	('AREIA FINA M�', 13, 1), 
	('AREIA GROSSA M�', 13, 1)

INSERT PEDIDO
VALUES ('20121201'), 
	('20130101'), 
	('20130201'), 
	('20130205'), 
	('20130219'), 
	('20130302') 

INSERT ITEM_PEDIDO
VALUES (1, 1, 1, NULL), 
	(1, 2, 1, NULL), 
	(2, 1, 10, NULL), 
	(2, 2, 10, NULL), 
	(2, 12, 10, NULL), 
	(3, 4, 2, NULL), 
	(4, 5, 1, NULL), 
	(4, 7, 1, NULL), 
	(4, 12, 1, NULL), 
	(5, 7, 3, NULL), 
	(5, 12, 3, NULL), 
	(6, 1, 100, NULL)

UPDATE IP
SET IP.PRECO_ITEM_PEDIDO = P.PRECO_PRODUTO
FROM ITEM_PEDIDO IP	
JOIN PRODUTO P
	ON P.COD_PRODUTO = IP.COD_PRODUTO

SELECT *
FROM ITEM_PEDIDO

UPDATE ITEM_PEDIDO
SET PRECO_ITEM_PEDIDO = PRECO_ITEM_PEDIDO * 0.9
WHERE QTD_ITEM_PEDIDO >= 20

UPDATE ITEM_PEDIDO
SET PRECO_ITEM_PEDIDO = PRECO_ITEM_PEDIDO * 1.2
WHERE QTD_ITEM_PEDIDO = 1

SELECT *
FROM ITEM_PEDIDO

SELECT *
FROM PRODUTO
WHERE COD_PRODUTO NOT IN 
(
	SELECT COD_PRODUTO
	FROM ITEM_PEDIDO
)
--OU
SELECT P.*
FROM PRODUTO P
LEFT JOIN ITEM_PEDIDO IP
	ON P.COD_PRODUTO = IP.COD_PRODUTO
WHERE IP.COD_ITEM_PEDIDO IS NULL

SELECT *
FROM PRODUTO
WHERE COD_PRODUTO IN 
(
	SELECT COD_PRODUTO
	FROM ITEM_PEDIDO
)
--OU
SELECT DISTINCT P.*
FROM PRODUTO P
JOIN ITEM_PEDIDO IP
	ON P.COD_PRODUTO = IP.COD_PRODUTO
--OU
SELECT P.*
FROM PRODUTO P
JOIN ITEM_PEDIDO IP
	ON P.COD_PRODUTO = IP.COD_PRODUTO
GROUP BY P.COD_PRODUTO, 
	P.NOME_PRODUTO, 
	P.PRECO_PRODUTO, 
	P.COD_CATEGORIA_PRODUTO

--CTRL+SHIFT+R - REFRESH NO INTELLISENSE

SELECT *
FROM ITEM_PEDIDO
WHERE PRECO_ITEM_PEDIDO < 
	(
		SELECT PRECO_PRODUTO
		FROM PRODUTO
		WHERE PRODUTO.COD_PRODUTO = ITEM_PEDIDO.COD_PRODUTO
	)
--OU
SELECT IP.*, 
	PRECO_PRODUTO
FROM ITEM_PEDIDO IP
JOIN PRODUTO P
	ON P.COD_PRODUTO = IP.COD_PRODUTO
WHERE P.PRECO_PRODUTO > IP.PRECO_ITEM_PEDIDO

SELECT *
FROM CATEGORIA_PRODUTO
WHERE COD_CATEGORIA_PRODUTO IN
(
	SELECT COD_CATEGORIA_PRODUTO
	FROM PRODUTO 
	WHERE COD_PRODUTO IN
	(
		SELECT COD_PRODUTO 
		FROM ITEM_PEDIDO
	)
)
--OU
SELECT DISTINCT CP.*
FROM CATEGORIA_PRODUTO CP
JOIN PRODUTO P 
	ON CP.COD_CATEGORIA_PRODUTO = P.COD_CATEGORIA_PRODUTO
JOIN ITEM_PEDIDO IP
	ON P.COD_PRODUTO = IP.COD_PRODUTO

SELECT *
FROM CATEGORIA_PRODUTO
WHERE COD_CATEGORIA_PRODUTO NOT IN
(
	SELECT COD_CATEGORIA_PRODUTO
	FROM PRODUTO 
	WHERE COD_PRODUTO NOT IN
	(
		SELECT COD_PRODUTO 
		FROM ITEM_PEDIDO
	)
)

SELECT DISTINCT CP.*
FROM CATEGORIA_PRODUTO CP
LEFT JOIN PRODUTO P 
	ON CP.COD_CATEGORIA_PRODUTO = P.COD_CATEGORIA_PRODUTO
LEFT JOIN ITEM_PEDIDO IP
	ON P.COD_PRODUTO = IP.COD_PRODUTO
WHERE COD_ITEM_PEDIDO IS NULL
EXCEPT
SELECT DISTINCT CP.*
FROM CATEGORIA_PRODUTO CP
JOIN PRODUTO P 
	ON CP.COD_CATEGORIA_PRODUTO = P.COD_CATEGORIA_PRODUTO
JOIN ITEM_PEDIDO IP
	ON P.COD_PRODUTO = IP.COD_PRODUTO

SELECT COD_CATEGORIA_PRODUTO, 
	MIN(PRECO_PRODUTO) AS 'MIN', 
	MAX(PRECO_PRODUTO) AS 'MAX', 
	AVG(PRECO_PRODUTO) AS 'AVG'
FROM PRODUTO
GROUP BY COD_CATEGORIA_PRODUTO

SELECT COD_CATEGORIA_PRODUTO, 
	NOME_CATEGORIA_PRODUTO, 
	(SELECT MIN(PRECO_PRODUTO) FROM PRODUTO P WHERE CP.COD_CATEGORIA_PRODUTO = P.COD_CATEGORIA_PRODUTO) AS 'MIN', 
	(SELECT MAX(PRECO_PRODUTO) FROM PRODUTO P WHERE CP.COD_CATEGORIA_PRODUTO = P.COD_CATEGORIA_PRODUTO) AS 'MAX', 
	(SELECT AVG(PRECO_PRODUTO) FROM PRODUTO P WHERE CP.COD_CATEGORIA_PRODUTO = P.COD_CATEGORIA_PRODUTO) AS 'AVG'
FROM CATEGORIA_PRODUTO CP
--OU	
SELECT CP.COD_CATEGORIA_PRODUTO, 
	CP.NOME_CATEGORIA_PRODUTO, 
	MIN(P.PRECO_PRODUTO) AS 'MIN', 
	MAX(P.PRECO_PRODUTO) AS 'MAX', 
	AVG(P.PRECO_PRODUTO) AS 'AVG'
FROM PRODUTO P
RIGHT JOIN CATEGORIA_PRODUTO CP
	ON CP.COD_CATEGORIA_PRODUTO = P.COD_CATEGORIA_PRODUTO
GROUP BY CP.COD_CATEGORIA_PRODUTO, 
	CP.NOME_CATEGORIA_PRODUTO

SELECT * 
FROM ITEM_PEDIDO
WHERE PRECO_ITEM_PEDIDO < ANY --ALGUM MENOR
(
	SELECT PRECO_PRODUTO
	FROM PRODUTO 
	WHERE PRODUTO.COD_PRODUTO = ITEM_PEDIDO.COD_PRODUTO
)
--6

SELECT * 
FROM ITEM_PEDIDO 
WHERE COD_ITEM_PEDIDO = 6

SELECT * 
FROM ITEM_PEDIDO
WHERE PRECO_ITEM_PEDIDO = ALL --TODOS IGUAIS
(
	SELECT PRECO_PRODUTO
	FROM PRODUTO 
	WHERE PRODUTO.COD_PRODUTO = ITEM_PEDIDO.COD_PRODUTO
)
--2, 3, 5 

UPDATE ITEM_PEDIDO
SET PRECO_ITEM_PEDIDO = 10
WHERE COD_ITEM_PEDIDO = 9

SELECT * 
FROM ITEM_PEDIDO
WHERE PRECO_ITEM_PEDIDO > ANY --ALGUM MAIOR
(
	SELECT PRECO_PRODUTO
	FROM PRODUTO 
	WHERE PRODUTO.COD_PRODUTO = ITEM_PEDIDO.COD_PRODUTO
)
--1, 4

SELECT *
FROM ITEM_PEDIDO IP
JOIN PRODUTO P 
ON P.COD_PRODUTO = IP.COD_PRODUTO
WHERE COD_PEDIDO IN (1 , 4)

SELECT * 
FROM PRODUTO 
WHERE COD_CATEGORIA_PRODUTO IN 
(
	SELECT TOP 1 P.COD_CATEGORIA_PRODUTO
	FROM ITEM_PEDIDO IP
	JOIN PRODUTO P 
		ON P.COD_PRODUTO = IP.COD_PRODUTO
	GROUP BY P.COD_CATEGORIA_PRODUTO
	ORDER BY SUM(IP.QTD_ITEM_PEDIDO * IP.PRECO_ITEM_PEDIDO) DESC
)

SELECT * 
FROM CATEGORIA_PRODUTO CP
WHERE EXISTS
(
	SELECT *
	FROM PRODUTO P
	WHERE CP.COD_CATEGORIA_PRODUTO = P.COD_CATEGORIA_PRODUTO
)

SELECT * 
FROM CATEGORIA_PRODUTO CP
WHERE NOT EXISTS
(
	SELECT *
	FROM PRODUTO P
	WHERE CP.COD_CATEGORIA_PRODUTO = P.COD_CATEGORIA_PRODUTO
)

