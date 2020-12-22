CREATE TABLE TbModelo (
  CdModelo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, -- A chave auto-incrementa
  NmModelo VARCHAR(45) NULL,
  Preco NUMERIC(10,2) NULL,
  PRIMARY KEY(CdModelo)
);

INSERT INTO TBModelo VALUES (NULL, 'Prisma', 49000), (NULL, 'Onix', 39000), (NULL, 'Cruze', 90000), (NULL, 'Cobalt', 56000), (NULL, 'Captiva', 110000);

CREATE TABLE TbVendedor (
  CdVendedor INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  NmVendedor VARCHAR(10) NULL,
  PRIMARY KEY(CdVendedor)
);

INSERT INTO TbVendedor VALUES (NULL, 'Henrique'), (NULL, 'Pedro Yuri'), (NULL, 'Rafael Lessa');

CREATE TABLE TbCidade (
  CdCidade INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  NmCidade VARCHAR(45) NULL,
  PRIMARY KEY(CdCidade)
);

INSERT INTO TbCidade VALUES (NULL, 'Timoteo'), (NULL, 'Ipatinga'), (NULL, 'Fabriciano');

CREATE TABLE TbVeiculo (
  CdVeiculo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Chassi VARCHAR(17) NULL,
  Cor VARCHAR(20) NULL,
  CdModelo INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(CdVeiculo),
  INDEX TbVeiculo_FKIndex1(CdModelo),
  FOREIGN KEY(CdModelo)
    REFERENCES TbModelo(CdModelo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

INSERT INTO TbVeiculo VALUES (NULL, '568237tHTE98F3W1', 'Preto', 1), (NULL, 'TT537Tg#90J632b7', 'Branco', 1), (NULL, '876YT52323VD313', 'Preto', 2), (NULL, '34324324324FSFD342', 'Prata', 2), (NULL, 'KJHFSY653H086HBE3', 'Azul', 3), (NULL, 'HGDDFSD765SH542E', 'Preto', 4), (NULL, 'SKJHD7656ASH545H0', 'Branco', 5);

CREATE TABLE TbCliente (
  CdCliente INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  NmCliente VARCHAR(45) NULL,
  Sexo CHAR NULL,
  CdCidade INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(CdCliente),
  INDEX TbCliente_FKIndex1(CdCidade),
  FOREIGN KEY(CdCidade)
    REFERENCES TbCidade(CdCidade)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

INSERT INTO TbCliente VALUES (NULL, 'Raphaela Santos', 'F', 1), (NULL, 'Miguel Santiago', 'M', 1), (NULL, 'Raphael Andrade', 'M', 2);

CREATE TABLE TbVenda (
  CdVenda INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  DtVenda DATE NULL,
  VlVenda NUMERIC(10,2) NULL,
  CdVeiculo INTEGER UNSIGNED NOT NULL,
  CdCliente INTEGER UNSIGNED NOT NULL,
  CdVendedor INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(CdVenda),
  INDEX TbVenda_FKIndex1(CdVeiculo),
  INDEX TbVenda_FKIndex2(CdCliente),
  INDEX TbVenda_FKIndex3(CdVendedor),
  FOREIGN KEY(CdVeiculo)
    REFERENCES TbVeiculo(CdVeiculo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(CdCliente)
    REFERENCES TbCliente(CdCliente)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(CdVendedor)
    REFERENCES TbVendedor(CdVendedor)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

INSERT INTO TbVenda VALUES (NULL, '2017/02/20', 47500, 1, 2, 1), (NULL, '2017/02/24', 49000, 2, 1, 1), (NULL, '2017/04/10', 38000, 5, 2, 2), (NULL, '2017/04/20', 56000, 7, 3, 2);

CREATE VIEW ModeloVeiculo AS (SELECT NmModelo, Chassi FROM TbModelo M, TbVeiculo V WHERE M.CdModelo = V.CdModelo);

CREATE VIEW VeiculosVendidos AS(SELECT C.CdCliente, NmCliente, CdCidade, Chassi, NmModelo, DtVenda FROM TbModelo M, TbVeiculo V, TbVenda VE, TbCliente C WHERE C.CdCliente = VE.CdCliente and VE.CdVeiculo = V.CdVeiculo and M.CdModelo = V.CdModelo);

SELECT * FROM VeiculosVendidos WHERE CdCliente = 2;

SELECT NmCliente, Chassi, NmCidade FROM VeiculosVendidos VV, TbCidade C WHERE VV.CdCidade = C.CdCidade;

/* Calcula o valor da comissao de cada vendedor considerando que este recebe 1% do valor dos veiculos */

CREATE VIEW Comissao AS (SELECT V.CdVendedor, NmVendedor, SUM(0.01 * VlVenda) FROM TbVendedor V, TbVenda Ve WHERE V.CdVendedor = Ve.CdVendedor GROUP BY V.CdVendedor);

INSERT INTO TbModelo VALUES (null, 'Camaro', 220000); -- O null é pq é auto incremento]

INSERT INTO TbModelo (NmModelo, Preco) VALUES ('Astra', 60000);