CREATE TABLE fornecedor(
idFornecedor INT PRIMARY KEY NOT NULL,
razaoSocial VARCHAR(20) NOT NULL,
nomeFantasia VARCHAR(20) NOT NULL,
telefone VARCHAR(20) NOT NULL
)

CREATE TABLE produto(
idProduto INT PRIMARY KEY NOT NULL,
nomeProduto VARCHAR(20) NOT NULL,
precoUnitario NUMERIC(12,2) NOT NULL,
idFornecedor INT NOT NULL,
FOREIGN KEY (idFornecedor) REFERENCES fornecedor(idFornecedor)
)

CREATE TABLE cliente(
idCliente INT PRIMARY KEY NOT NULL,
nomeCliente VARCHAR(20) NOT NULL,
rua VARCHAR(20) NOT NULL,
numero INT NOT NULL,
fone VARCHAR(20) NOT NULL,
bairro VARCHAR(20) NOT NULL,
cidade VARCHAR(20) NOT NULL,
estado CHAR(2)
)

CREATE TABLE notaFiscal(
numeroNota INT PRIMARY KEY NOT NULL,
valorNota NUMERIC(12,2) NOT NULL,
dataEmissao DATE NOT NULL,
idCliente INT NOT NULL,
FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
)

CREATE TABLE itemNota(
numeroNota INT NOT NULL,
idProduto INT NOT NULL,
qtddeItem INT NOT NULL,
valorItem NUMERIC(12,2) NOT NULL,
FOREIGN KEY (numeroNota) REFERENCES notaFiscal(numeroNota),
FOREIGN KEY (idProduto) REFERENCES produto(idProduto)
)

--------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.fornecedor VALUES(1, 'G & C Engenharia', 'G & C Engenharia', '51 1111-2233'),
(2, 'Uni10 Tecnologia', 'Uni10', '51 2222-2233'),
(3, 'HighLength Infra', 'HighLength', '51 3333-2233'),
(4, 'FullPower Tecno', 'FullPower', '51 4444-2233')

INSERT INTO dbo.cliente VALUES(1, 'João da Silva', 'Rua Pernambuco', 150, '51 5555-3344', 'Hamburgo Velho', 'Novo Hamburgo', 'RS'),
(2, 'Paulo Bocão', 'Rua Alagoas', 160, '51 6666-3344', 'Humaitá', 'Porto Alegre', 'RS'),
(3, 'Juca Chewbacca', 'Rua João Pedro', 170, '51 7777-3344', 'Menino Deus', 'Porto Alegre', 'RS'),
(4, 'Pedro Maçaneta', 'Rua Arábia', 180, '51 8888-3344', 'Santo Afonso', 'Novo Hamburgo', 'RS'),
(5, 'Pedro Pedreira', 'Rua Líbia', 190, '51 9999-3344', 'Centro', 'Novo Paraíso', 'SP')


ALTER TABLE dbo.produto ALTER COLUMN nomeProduto varchar(40)

INSERT INTO dbo.produto VALUES(1, 'Mouse', 15.5, 1),
(2, 'Teclado', 23.8, 1),
(3, 'HD', 155.0, 2),
(4, 'Windows Vista Student', 199.0, 4),
(5, 'Pen-drive', 35.9, 2),
(6, 'iPod', 1200.0, 1),
(7, 'iPhone', 1500.0, 3),
(8, 'Macbook air', 5500.0, 3),
(9, 'iMac', 3333.3, 4),
(10, 'Placa de Vídeo', 420.5, 4),
(11, 'Adesivo', 0.95, 1)

INSERT INTO dbo.notaFiscal VALUES(100, 250.0, convert(datetime,'08/01/2009',103), 4),
(1501, 500.0, convert(datetime,'15/01/2009',103), 1),
(1502, 1500.0, convert(datetime,'25/01/2009',103), 2),
(1503, 1200.0, convert(datetime,'30/03/2009',103), 1),
(1504, 5600.0, convert(datetime,'30/03/2009',103), 3),
(1505, 8600.0, convert(datetime,'01/04/2009',103), 2),
(1506, 85.0, convert(datetime,'01/04/2009',103), 3),
(1507, 120.0, convert(datetime,'02/04/2009',103), 1)

INSERT INTO dbo.itemNota VALUES(100, 1, 10, 150.0),
(100, 2, 2, 48.0),
(100, 5, 2, 52.0),
(1501, 4, 1, 199.0),
(1501, 2, 13, 301.0),
(1502, 7, 1, 1500.0),
(1503, 6, 1, 1200.0),
(1504, 8, 1, 5500.0),
(1505, 8, 1, 5500.0),
(1505, 9, 1, 3100.0),
(1506, 1, 2, 31.0),
(1506, 2, 2, 54.0),
(1507, 3, 1, 120.0)

--------------------------------------------------------------------------------------------------------------

SELECT * FROM cliente
WHERE estado = 'RS'

SELECT * FROM notaFiscal
WHERE valorNota >=500 AND valorNota <=2000

SELECT * FROM notaFiscal
WHERE dataEmissao BETWEEN '01/01/2009' AND '30/01/2009' --BETWEEN (para selecionar espaço entre datas)

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
