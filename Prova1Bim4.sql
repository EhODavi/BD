CREATE TABLE TbPaciente (
  CdPaciente INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  NmPaciente VARCHAR(50) NOT NULL,
  DtNasc DATE NULL,
  Sexo CHAR NULL,
  Telefone VARCHAR(9) NULL,
  PRIMARY KEY(CdPaciente)
);

INSERT INTO TbPaciente VALUES 
(NULL, 'David Silva', '1985/10/07', 'M', '3847-1023'), 
(NULL, 'André Souza', '1990/01/20', 'M', '3841-4598'),
(NULL, 'Diego Souza', '1988/02/20', 'M', '3845-1017'),
(NULL, 'Thaís Araujo', '1980/10/28', 'F', '3848-0954'), 
(NULL, 'Marília Mendonça', '1992/12/02', 'F', '3847-9158');

CREATE TABLE TbProcedimento (
  CdProcedimento INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  NmProcedimento VARCHAR(30) NOT NULL,
  PrecoAtual NUMERIC(10,2) NULL,
  PRIMARY KEY(CdProcedimento)
);

INSERT INTO TbProcedimento VALUES 
(NULL, 'Limpeza', 250), 
(NULL, 'Restauração', 300), 
(NULL, 'Tratamento de canal', 1200),
(NULL, 'Aparelho', 2000);

CREATE TABLE TbDentista (
  CdDentista INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  NmDentista VARCHAR(50) NOT NULL,
  Telefone VARCHAR(9) NULL,
  PRIMARY KEY(CdDentista)
);

INSERT INTO TbDentista VALUES
(NULL, 'Sonia Abreu', '3848-1034'),
(NULL, 'Katia Fonseca', '3841-1406'),
(NULL, 'Pedro Cardoso', '3845-0898');

CREATE TABLE TbTratamento (
  CdTratamento INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  DtInicio DATE NULL,
  DtFim DATE NULL,
  VlTotal NUMERIC(10,2) NULL,
  Situacao CHAR NULL,
  FormaPag CHAR NULL,
  CdPaciente INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(CdTratamento),
  INDEX TbTratamento_FKIndex1(CdPaciente),
  FOREIGN KEY(CdPaciente)
    REFERENCES TbPaciente(CdPaciente)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

INSERT INTO TbTratamento VALUES
(NULL, '2016/02/20', '2016/05/10', 700, 'O', '', 1),
(NULL, '2016/03/01', '2016/03/15', 1000, 'C', 'V', 2),
(NULL, '2016/03/11', '2016/07/25', 1800, 'C', 'P', 3),
(NULL, '2016/10/11', '2016/10/11', 250, 'C', 'V', 4),
(NULL, '2017/01/17', '2017/06/09', 1200, 'A', 'V', 5),
(NULL, '2017/02/17', '2017/05/22', 600, 'A', 'P', 1);

CREATE TABLE TbTratamento_Proc (
  CdTratamento INTEGER UNSIGNED NOT NULL,
  CdProcedimento INTEGER UNSIGNED NOT NULL,
  Qtd INTEGER UNSIGNED NULL,
  VlUnitario NUMERIC(10,2) NULL,
  PRIMARY KEY(CdTratamento, CdProcedimento),
  INDEX TbTratamento_has_TbProcedimento_FKIndex1(CdTratamento),
  INDEX TbTratamento_has_TbProcedimento_FKIndex2(CdProcedimento),
  FOREIGN KEY(CdTratamento)
    REFERENCES TbTratamento(CdTratamento)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(CdProcedimento)
    REFERENCES TbProcedimento(CdProcedimento)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

INSERT INTO TbTratamento_Proc VALUES 
(1, 1, 1, 200), (1, 2, 2, 250),
(2, 3, 1, 1000),
(3, 1, 1, 200), (3, 2, 2, 250), (3, 3, 1, 1100),
(4, 1, 1, 250), 
(5, 2, 4, 300),
(6, 2, 2, 300);

CREATE TABLE TbParcelaPag (
  CdParcelaPag INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  DtPagamento DATE NULL,
  VlParcela NUMERIC(10,2) NULL,
  Pago CHAR NULL,
  CdTratamento INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(CdParcelaPag),
  INDEX TbParcelaPag_FKIndex1(CdTratamento),
  FOREIGN KEY(CdTratamento)
    REFERENCES TbTratamento(CdTratamento)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

INSERT INTO TbParcelaPag VALUES
(NULL, '2016/04/11', 600, 'S', 3),
(NULL, '2016/05/11', 600, 'S', 3),
(NULL, '2016/06/11', 600, 'S', 3),
(NULL, '2017/05/22', 300, 'N', 6),
(NULL, '2017/06/22', 300, 'N', 6);

CREATE TABLE TbConsulta (
  CdConsulta INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  DtConsulta DATE NULL,
  Descricao VARCHAR(255) NULL,
  CdTratamento INTEGER UNSIGNED NOT NULL,
  CdDentista INTEGER UNSIGNED NOT NULL,
  VlComissao NUMERIC(10,2) NULL,
  PRIMARY KEY(CdConsulta),
  INDEX TbConsulta_FKIndex1(CdTratamento),
  INDEX TbConsulta_FKIndex2(CdDentista),
  FOREIGN KEY(CdTratamento)
    REFERENCES TbTratamento(CdTratamento)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(CdDentista)
    REFERENCES TbDentista(CdDentista)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

INSERT INTO TbConsulta VALUES 
(NULL, '2016/03/15', 'Tratamento de canal do dente 12', 2, 1, 400), 
(NULL, '2016/03/11', 'Restauração dos dentes 10 e 11', 3, 2, 250),
(NULL, '2016/05/11', 'Tratamento de canal do dente 18', 3, 1, 420),
(NULL, '2016/07/25', 'Realizou-se limpeza padrão', 3, 2, 80),
(NULL, '2016/10/11', 'Realizou-se limpeza padrão', 4, 3, 80),
(NULL, '2017/01/17', 'Restauração do dente 10 e 12', 5, 3, 250),
(NULL, '2017/06/09', 'Restauração do dente 02 e 13', 5, 3, 250),
(NULL, '2017/02/17', 'Restauração do dente 14', 6, 2, 120),
(NULL, '2017/05/22', 'Restauração do dente 17', 6, 2, 120);

SELECT DtInicio, DtFim, CdPaciente FROM TbTratamento WHERE (CdPaciente = 2) OR (CdPaciente = 3) OR (CdPaciente = 4);

SELECT DtInicio, DtFim, CdPaciente FROM TbTratamento WHERE CdPaciente IN (2,3,4);

SELECT DtInicio, DtFim, CdPaciente FROM TbTratamento WHERE CdPaciente NOT IN (2,3,4);

INSERT INTO TbPaciente VALUES  (NULL, 'José', '1985/10/16', 'M', '3847-1233');

select nmpaciente, dtnasc
from tbpaciente
where cdpaciente not in (select Cdpaciente from tbtratamento);

SELECT cdpaciente, NmPaciente 
from tbpaciente
where cdpaciente not in (select cdpaciente from tbTratamento T, tbParcelaPag PP where T.cdtratamento = PP.cdTratamento and pago ='N');