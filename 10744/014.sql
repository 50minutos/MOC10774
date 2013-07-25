USE DB

CREATE TABLE VENDA
(
	PRODUTO VARCHAR(50), 
	QTD INT, 
	ANO INT
)

INSERT VENDA
VALUES ('COCA-COLA', 10, 2012), 
	('SPRITE', 1, 2012), 
	('COCA-COLA', 12, 2013), 
	('FANTA', 6, 2013), 
	('COCA-COLA', 1, 2013), 
	('SPRITE', 6, 2011), 
	('KUAT', 2, 2010), 
	('COCA-COLA', 10, 2013)

SELECT *
FROM VENDA

SELECT PRODUTO, [2010], [2011], [2012], [2013]
--INTO #TMP
FROM (
	SELECT PRODUTO, 
		QTD, 
		ANO 
	FROM VENDA
) X
PIVOT(SUM(QTD) FOR ANO IN ([2010], [2011], [2012], [2013])) PIVOTADA

SELECT *
FROM #TMP

SELECT PRODUTO, 
	QTD, 
	ANO
FROM #TMP
UNPIVOT(QTD FOR ANO IN ([2010], [2011], [2012], [2013])) UNPIVOTADA

SELECT ANO, 
	SUM(QTD) AS 'TOTAL'
FROM VENDA
GROUP BY ANO

 --CLIENTE, UF, CIDADE, PEDIDO, ITEM_PEDIDO, PRODUTO
CREATE TABLE PEDIDO
(
	COD_CLIENTE INT, 
	NOME_CLIENTE VARCHAR(50), 
	CIDADE_CLIENTE VARCHAR(50), 
	ESTADO_CLIENTE CHAR(2), 
	VALOR_PEDIDO DEC(9,2)
)

INSERT PEDIDO 
VALUES (1, 'AD�O', 'SPO', 'SP', 1000), 
	(2, 'AD�O', 'LORENA', 'SP', 100), 
	(3, 'EVA', 'SPO', 'SP', 50), 
	(1, 'AD�O', 'SPO', 'SP', 1000), 
	(4, 'TI�O', 'PA', 'MG', 10), 
	(3, 'EVA', 'SPO', 'SP', 1000), 
	(5, 'CHICO', 'BHZ', 'MG', 10), 
	(2, 'AD�O', 'LORENA', 'SP', 1000)

SELECT SUM(VALOR_PEDIDO) AS 'TOTAL'
FROM PEDIDO

SELECT ESTADO_CLIENTE, 
	SUM(VALOR_PEDIDO) AS 'TOTAL'
FROM PEDIDO
GROUP BY ESTADO_CLIENTE

SELECT ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	SUM(VALOR_PEDIDO) AS 'TOTAL'
FROM PEDIDO
GROUP BY ESTADO_CLIENTE, 
	CIDADE_CLIENTE

SELECT ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE, 
	SUM(VALOR_PEDIDO) AS 'TOTAL'
FROM PEDIDO
GROUP BY ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE

SELECT ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE, 
	SUM(VALOR_PEDIDO) AS 'TOTAL'
FROM PEDIDO
GROUP BY ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE
WITH ROLLUP

SELECT ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE, 
	SUM(VALOR_PEDIDO) AS 'TOTAL'
FROM PEDIDO
GROUP BY ROLLUP
(
	ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE
)

SELECT ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE, 
	SUM(VALOR_PEDIDO) AS 'TOTAL'
FROM PEDIDO
GROUP BY ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE
WITH CUBE

SELECT ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE, 
	SUM(VALOR_PEDIDO) AS 'TOTAL'
FROM PEDIDO
GROUP BY CUBE
(	
	ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE
)

SELECT ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE, 
	SUM(VALOR_PEDIDO) AS 'TOTAL'
FROM PEDIDO
GROUP BY ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE
HAVING SUM(VALOR_PEDIDO) BETWEEN 1000 AND 2000
ORDER BY TOTAL

--<2012
--SELECT *
--FROM PEDIDO
--COMPUTE SUM(VALOR_PEDIDO), 
--	AVG(VALOR_PEDIDO), 
--	MIN(VALOR_PEDIDO), 
--	MAX(VALOR_PEDIDO), 
--	COUNT(VALOR_PEDIDO)

--SELECT *
--FROM PEDIDO
--ORDER BY COD_CLIENTE
--COMPUTE SUM(VALOR_PEDIDO) BY COD_CLIENTE
--COMPUTE SUM(VALOR_PEDIDO)

--SELECT *
--FROM PEDIDO
--ORDER BY ESTADO_CLIENTE, 
--	CIDADE_CLIENTE, 
--	COD_CLIENTE
--COMPUTE SUM(VALOR_PEDIDO) BY ESTADO_CLIENTE,
--	CIDADE_CLIENTE, 
--	COD_CLIENTE
--COMPUTE SUM(VALOR_PEDIDO) BY ESTADO_CLIENTE,
--	CIDADE_CLIENTE 
--COMPUTE SUM(VALOR_PEDIDO) BY ESTADO_CLIENTE
--COMPUTE SUM(VALOR_PEDIDO)

SELECT ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE, 
	SUM(VALOR_PEDIDO) AS 'TOTAL'
FROM PEDIDO
GROUP BY GROUPING SETS 
(
	NOME_CLIENTE,
	CIDADE_CLIENTE, 
	ESTADO_CLIENTE 
)

SELECT ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE, 
	SUM(VALOR_PEDIDO) AS 'TOTAL'
FROM PEDIDO
GROUP BY GROUPING SETS 
(
	(), 
	(ESTADO_CLIENTE), 
	(ESTADO_CLIENTE, CIDADE_CLIENTE), 
	(ESTADO_CLIENTE, CIDADE_CLIENTE, NOME_CLIENTE)
)

SELECT ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE, 
	SUM(VALOR_PEDIDO) AS 'TOTAL', 
	GROUPING_ID(ESTADO_CLIENTE) AS 'ESTADO_CLIENTE', 
	GROUPING_ID(CIDADE_CLIENTE) AS 'CIDADE_CLIENTE', 
	GROUPING_ID(NOME_CLIENTE) AS 'NOME_CLIENTE' 
FROM PEDIDO
GROUP BY ROLLUP
(
	ESTADO_CLIENTE, 
	CIDADE_CLIENTE, 
	NOME_CLIENTE
)
