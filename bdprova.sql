CREATE TABLE tbfornecedor (
  CdFornecedor INTEGER(11) NOT NULL AUTO_INCREMENT,
  NmFornecedor VARCHAR(100) NOT NULL,
  CNPJ VARCHAR(20) NOT NULL,
  PRIMARY KEY(CdFornecedor)
);

CREATE TABLE tbproduto (
  CdProduto INTEGER(11) NOT NULL AUTO_INCREMENT,
  NmProduto VARCHAR(100) NOT NULL,
  PrecoAtual NUMERIC(10,2),
  PRIMARY KEY(CdProduto)
);

CREATE TABLE TbTipoDespesa (
  CdTipoDespesa INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  NmTipoDespesa VARCHAR(50) NULL,
  PRIMARY KEY(CdTipoDespesa)
);

CREATE TABLE tbcidade (
  CdCidade INTEGER(11) NOT NULL AUTO_INCREMENT,
  NmCidade VARCHAR(100) NOT NULL,
  PRIMARY KEY(CdCidade)
);

CREATE TABLE tbvendedor (
  CdVendedor INTEGER(11) NOT NULL AUTO_INCREMENT,
  NmVendedor VARCHAR(100) NOT NULL,
  CdCidade INTEGER(11) NOT NULL,
  PRIMARY KEY(CdVendedor),
  INDEX CdCidade(CdCidade),
  FOREIGN KEY(CdCidade)
    REFERENCES tbcidade(CdCidade)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE TbDespesa (
  CdDespesa INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  DtDespesa DATE NULL,
  VlDespesa NUMERIC(10,2) NULL,
  CdTipoDespesa INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(CdDespesa),
  FOREIGN KEY(CdTipoDespesa)
    REFERENCES TbTipoDespesa(CdTipoDespesa)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE tbcliente (
  CdCliente INTEGER(11) NOT NULL AUTO_INCREMENT,
  NmCliente VARCHAR(100) NOT NULL,
  CdCidadeReside INTEGER(11) NOT NULL,
  CdCidadeNasc INTEGER(11) NOT NULL,
  PRIMARY KEY(CdCliente),
  INDEX CdCidadeNasc(CdCidadeNasc),
  FOREIGN KEY(CdCidadeReside)
    REFERENCES tbcidade(CdCidade)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(CdCidadeNasc)
    REFERENCES tbcidade(CdCidade)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE TbProduto_Fornecedor (
  CdProduto INTEGER(11) NOT NULL,
  CdFornecedor INTEGER(11) NOT NULL,
  PrecoCusto NUMERIC(10,2) NULL,
  PRIMARY KEY(CdProduto, CdFornecedor),
  FOREIGN KEY(CdProduto)
    REFERENCES tbproduto(CdProduto)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(CdFornecedor)
    REFERENCES tbfornecedor(CdFornecedor)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE tbvenda (
  CdVenda INTEGER(11) NOT NULL AUTO_INCREMENT,
  CdCliente INTEGER(11) NOT NULL,
  CdProduto INTEGER(11) NOT NULL,
  CdVendedor INTEGER(11) NOT NULL,
  DataVenda DATE NOT NULL,
  PrecoVenda NUMERIC(10,2) NOT NULL,
  FormaPag CHAR NULL,
  PRIMARY KEY(CdVenda),
  INDEX CdCliente(CdCliente),
  INDEX CdVendedor(CdVendedor),
  FOREIGN KEY(CdCliente)
    REFERENCES tbcliente(CdCliente)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(CdVendedor)
    REFERENCES tbvendedor(CdVendedor)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(CdProduto)
    REFERENCES tbproduto(CdProduto)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE TbContaReceber (
  CdContaReceber INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  NumParcela INTEGER UNSIGNED NULL,
  VlParcela NUMERIC(10,2) NULL,
  DtPrevistaPag DATE NULL,
  Situacao CHAR NULL,
  CdVenda INTEGER(11) NOT NULL,
  PRIMARY KEY(CdContaReceber),
  FOREIGN KEY(CdVenda)
    REFERENCES tbvenda(CdVenda)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

INSERT INTO TbCidade VALUES 
(NULL, 'Ipatinga'),
(NULL, 'Cel Fabriciano'),
(NULL, 'Timóteo');

INSERT INTO TbCliente VALUES 
(NULL, 'João Batista', 1, 1),
(NULL, 'Ana da Silva Borges', 2, 2),
(NULL, 'Paulo Cesar', 3, 1),
(NULL, 'Joana Amaral', 2, 1),
(NULL, 'Pedro da Silva', 1, 2),
(NULL, 'Antônio de Lima', 1, 3);

INSERT INTO TbVendedor VALUES 
(NULL, 'Clodoaldo', 3),
(NULL, 'Priscila Carvalho', 2),
(NULL, 'Priscila Amaral', 3),
(NULL, 'Joaquim', 2);

INSERT INTO TbFornecedor VALUES
(NULL, 'Silva Cia. Ltda.', '12345-6'),
(NULL, 'Aguiar Fornecimentos Ltda.', '78910-1'),
(NULL, 'SMP&B', '12131-5'),
(NULL, 'Grupo Magalhães', '20987-0');

INSERT INTO TbProduto VALUES
(NULL, 'Telha', 20),
(NULL, 'Conexões', 15),
(NULL, 'Tinta', 80),
(NULL, 'Cimento', 120),
(NULL, 'Lajotas', 35);

INSERT INTO TbProduto_Fornecedor (`CdFornecedor`, `CdProduto`, `PrecoCusto`) VALUES

(1, 1, 12),

(1, 3, 35),

(2, 1, 15),

(2, 4, 30),

(2, 5, 120),

(3, 5, 115);


INSERT INTO `tbvenda` (`CdVenda`, `CdCliente`, `CdProduto`, `CdVendedor`, `DataVenda`, `PrecoVenda`, `FormaPag`) VALUES
(NULL, 5, 3, 1, '2013-12-27', '40.00', 'V'),
(NULL, 3, 1, 1, '2013-12-28', '18.00', 'V'),
(NULL, 6, 5, 1, '2013-12-28', '122.00', 'P'),
(NULL, 1, 1, 2, '2014-01-01', '18.00', 'V'),
(NULL, 6, 3, 2, '2014-01-01', '40.00', 'V'),
(NULL, 2, 1, 1, '2014-01-15', '18.00', 'V'),
(NULL, 2, 4, 3, '2014-01-16', '30.00', 'V'),
(NULL, 6, 5, 1, '2014-01-17', '122.00', 'P'),
(NULL, 3, 5, 1, '2014-01-17', '125.00', 'P'),
(NULL, 1, 1, 2, '2014-01-08', '20.00', 'V');

INSERT INTO TbContaReceber VALUES 
(NULL, 1, 	61, '2013/12/27', 'P', 3),
(NULL, 2, 	61, '2014/01/27', 'P', 3),
(NULL, 1, 	40, '2014/02/17', 'P', 8),
(NULL, 2, 	41, '2014/03/17', 'N', 8),
(NULL, 3, 	41, '2014/04/17', 'N', 8),
(NULL, 1, 	45, '2014/02/17', 'P', 9),
(NULL, 2, 	40, '2014/03/17', 'P', 9),
(NULL, 3, 	40, '2014/04/17', 'N', 9);

INSERT INTO TbTipoDespesa VALUES (NULL, 'Pagto Funcionarios'), 
(NULL, 'Telefone'), 
(NULL, 'Aluguel Loja'), 
(NULL, 'Limpeza Loja');

INSERT INTO TbDespesa VALUES
(NULL, '2014/01/01', 3000,	1),
(NULL, '2014/01/02', 450,	2),
(NULL, '2014/01/03', 1500,	3),
(NULL, '2014/02/01', 3200,	1),
(NULL, '2014/02/01', 1500,	3),
(NULL, '2014/03/05', 3200,	1);

INSERT INTO TbCidade VALUES (null, 'Viçosa');
INSERT INTO TbCliente VALUES (null, 'Marcelo Balbino', 3, 4);

SELECT 'Venda' as TipoTransacao, DataVenda as DataTransacao, PrecoVenda as Preco FROM TbVenda WHERE DataVenda BETWEEN '2014/01/01' and '2014/01/31'
UNION
SELECT NmTipoDespesa as TipoTransacao, DtDespesa as DataTransacao, VlDespesa as Preco FROM TbTipoDespesa T, TbDespesa D WHERE T.CdTipoDespesa = D.CdTipoDespesa and DtDespesa BETWEEN '2014/01/01' AND '2014/01/31' ORDER BY DataTransacao;

SELECT NmCliente, SUM(PrecoVenda) as TotalVenda FROM TbCliente C LEFT JOIN TbVenda V ON C.CdCliente = V.CdCliente GROUP BY NmCliente ORDER BY NmCliente;

CREATE VIEW Dividas as (SELECT C.CdCliente, NmCliente, SUM(VlParcela) as TotalDivida FROM TbCliente C, TbVenda V, TbContaReceber CR WHERE C.CdCliente = V.CdCliente and V.CdVenda = CR.CdVenda and Situacao = 'N' GROUP BY NmCliente);

SELECT C.CdCliente, NmCliente, SUM(VlParcela) as TotalDivida FROM TbCliente C LEFT JOIN TbVenda V ON C.CdCliente = V.CdCliente INNER JOIN TbContaReceber CR ON V.CdVenda = CR.CdVenda WHERE Situacao = 'N' GROUP BY NmCliente;

SELECT * FROM TbProduto WHERE PrecoAtual = ( SELECT MAX(PrecoAtual) FROM TbProduto); /* OBS */

SELECT MAX(TotalVenda) FROM (
SELECT NmCliente, SUM(PrecoVenda) as TotalVenda FROM TbCliente C LEFT JOIN TbVenda V ON C.CdCliente = V.CdCliente GROUP BY NmCliente ORDER BY NmCliente) AS T;
