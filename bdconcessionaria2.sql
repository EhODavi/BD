SELECT * FROM bdconcessionaria.comissao;

CREATE TABLE TbVendedor (
  CdVendedor INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  NmVendedor VARCHAR(10) NULL,
  PRIMARY KEY(CdVendedor)
);

INSERT INTO TbVendedor VALUES (NULL, 'Henrique'), (NULL, 'Pedro Yuri'), (NULL, 'Rafael Lessa');

SELECT V.CdVendedor, V.NmVendedor, C.* FROM bdconcessionaria.comissao C, TbVendedor V WHERE C.CdVendedor = V.CdVendedor;