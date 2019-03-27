SELECT * FROM cliente
WHERE estado = 'RS'

SELECT * FROM notaFiscal
WHERE valorNota >=500 AND valorNota <=2000

SELECT * FROM notaFiscal
WHERE dataEmissao BETWEEN '01/01/2009' AND '30/01/2009' --BETWEEN (para selecionar espa�o entre datas)

SELECT notaFiscal.valorNota, notaFiscal.dataEmissao
FROM notaFiscal
WHERE dataEmissao = '30/03/2009'

SELECT * FROM produto
WHERE precoUnitario <= 1.0

SELECT cliente.nomeCliente, cliente.cidade
FROM cliente
WHERE cidade = 'Novo Hamburgo' OR cidade = 'Porto Alegre'

SELECT fornecedor.idFornecedor, fornecedor.nomeFantasia, fornecedor.telefone
FROM fornecedor

SELECT itemNota.idProduto, itemNota.qtddeItem
FROM itemNota
WHERE numeroNota = 1501 AND qtddeItem >= 10

SELECT produto.nomeProduto, produto.precoUnitario
FROM produto
WHERE precoUnitario <= 10 OR precoUnitario >= 40

SELECT notaFiscal.numeroNota, notaFiscal.dataEmissao
FROM notaFiscal
WHERE valorNota BETWEEN 1000.0 AND 2000.0

--------------------------------------------------------------------------------------------------------------

SELECT cliente.nomeCliente, notaFiscal.dataEmissao
FROM cliente
INNER JOIN notaFiscal
ON cliente.idCliente = notaFiscal.idCliente

SELECT DISTINCT cliente.estado 
FROM cliente
INNER JOIN notaFiscal
ON cliente.idCliente = notaFiscal.idCliente
WHERE notaFiscal.valorNota >= 5000.0

SELECT DISTINCT cliente.nomeCliente, itemNota.qtddeItem
FROM cliente, notaFiscal, itemNota
WHERE cliente.idCliente = notaFiscal.idCliente AND notaFiscal.numeroNota = itemNota.numeroNota 
AND notaFiscal.numeroNota = 100

SELECT DISTINCT produto.idProduto, produto.nomeProduto
FROM produto, itemNota, notaFiscal, cliente
WHERE notaFiscal.numeroNota = itemNota.numeroNota AND itemNota.idProduto = produto.idProduto AND cliente.estado = 'RS'

SELECT DISTINCT produto.idProduto, produto.precoUnitario
FROM produto, cliente, notaFiscal
WHERE produto.idProduto = cliente.idCliente AND cliente.cidade = 'Novo Hamburgo' AND notaFiscal.valorNota < 500.0

SELECT DISTINCT cliente.cidade
FROM cliente, fornecedor, produto, itemNota, notaFiscal
WHERE fornecedor.idFornecedor = produto.idFornecedor AND produto.idProduto = itemNota.idProduto 
AND itemNota.numeroNota = notaFiscal.numeroNota AND notaFiscal.idCliente = cliente.idCliente

SELECT DISTINCT notaFiscal.valorNota
FROM fornecedor, produto, itemNota, notaFiscal
WHERE notaFiscal.numeroNota = itemNota.numeroNota AND itemNota.idProduto = produto.idProduto 
AND produto.idFornecedor = fornecedor.idFornecedor AND fornecedor.razaoSocial = 'G & C Engenharia'

--------------------------------------------------------------------------------------------------------------

SELECT MAX (notaFiscal.valorNota) AS maiorVenda
FROM notaFiscal

SELECT AVG (DISTINCT notaFiscal.valorNota) AS mediaVendas
FROM notaFiscal

SELECT MIN (notaFiscal.valorNota) AS menorVenda
FROM notaFiscal

SELECT SUM (notaFiscal.valorNota) AS somaVendas
FROM notaFiscal

SELECT AVG (DISTINCT produto.precoUnitario) AS mediaUnitario
FROM produto

SELECT AVG (DISTINCT notaFiscal.valorNota) AS mediaVendas_NOVO_HAMBURGO
FROM notaFiscal, cliente
WHERE cliente.cidade = 'Novo Hamburgo'

SELECT DISTINCT MIN (notaFiscal.valorNota) AS menorVenda_Cidade
FROM notaFiscal, cliente
GROUP BY cliente.cidade;

SELECT DISTINCT MIN (notaFiscal.valorNota) AS menorVenda_Estado
FROM notaFiscal, cliente
GROUP BY cliente.estado;

SELECT DISTINCT MIN (produto.precoUnitario) AS menorUnitario_idFornecedor
FROM produto, fornecedor
GROUP BY fornecedor.idFornecedor;

INSERT INTO dbo.fornecedor VALUES(100, 'IFBA Salvador', 'IFBA', '51 5555-2233')

UPDATE fornecedor 
SET nomeFantasia = 'IFBASSa'
WHERE fornecedor.idFornecedor = 100;

DELETE FROM fornecedor
WHERE fornecedor.idFornecedor = 100;