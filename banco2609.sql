CREATE TABLE IF NOT EXISTS `tbaluno` (
  `CdAluno` int(11) NOT NULL,
  `NmAluno` varchar(45) NOT NULL,
  PRIMARY KEY (`CdAluno`)
);

--
-- Extraindo dados da tabela `tbaluno`
--

INSERT INTO `tbaluno` (`CdAluno`, `NmAluno`) VALUES
(1, 'Roberto Chaves'),
(2, 'Paulo da Silva'),
(3, 'Maria Silva'),
(4, 'Pedro Castro');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbautor`
--

CREATE TABLE IF NOT EXISTS `tbautor` (
  `CdAutor` int(11) NOT NULL,
  `NmAutor` varchar(45) NOT NULL,
  PRIMARY KEY (`CdAutor`)
);

--
-- Extraindo dados da tabela `tbautor`
--

INSERT INTO `tbautor` (`CdAutor`, `NmAutor`) VALUES
(1, 'PRESSMAN, Roger S'),
(2, 'ZIVIANI, Nivio'),
(3, 'FORBELLONE, André Luiz Villar'),
(4, 'EBERSPACHER, Henri Frederico'),
(5, 'THOMAS, George B');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbautorlivro`
--

CREATE TABLE IF NOT EXISTS `tbautorlivro` (
  `CdAutor` int(11) NOT NULL,
  `CdLivro` int(11) NOT NULL,
  PRIMARY KEY (`CdAutor`,`CdLivro`),
  KEY `fk_TbAutor_has_TbLivro_TbLivro1` (`CdLivro`),
  KEY `fk_TbAutor_has_TbLivro_TbAutor` (`CdAutor`)
);

--
-- Extraindo dados da tabela `tbautorlivro`
--

INSERT INTO `tbautorlivro` (`CdAutor`, `CdLivro`) VALUES
(3, 1),
(1, 2),
(2, 3),
(4, 3),
(5, 4);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbemprestimo`
--

CREATE TABLE IF NOT EXISTS `tbemprestimo` (
  `CdEmprestimo` int(11) NOT NULL,
  `DtEmprestimo` date NOT NULL,
  `DtPrevistaDev` date NOT NULL,
  `CdAluno` int(11) NOT NULL,
  PRIMARY KEY (`CdEmprestimo`),
  KEY `fk_TbEmprestimo_TbAluno1` (`CdAluno`)
);

--
-- Extraindo dados da tabela `tbemprestimo`
--

INSERT INTO `tbemprestimo` (`CdEmprestimo`, `DtEmprestimo`, `DtPrevistaDev`, `CdAluno`) VALUES
(1, '2014-01-01', '2014-01-08', 1),
(2, '2014-01-01', '2014-01-08', 2),
(3, '2014-01-10', '2014-01-17', 1),
(4, '2014-01-11', '2014-01-18', 4),
(5, '2014-01-24', '2014-01-31', 4),
(6, '2014-01-24', '2014-01-31', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbemprestimoexemplar`
--

CREATE TABLE IF NOT EXISTS `tbemprestimoexemplar` (
  `CdEmprestimo` int(11) NOT NULL,
  `CdExemplar` int(11) NOT NULL,
  `DtDevolucao` date DEFAULT NULL,
  PRIMARY KEY (`CdEmprestimo`,`CdExemplar`),
  KEY `fk_TbEmprestimo_has_TbExemplar_TbExemplar1` (`CdExemplar`),
  KEY `fk_TbEmprestimo_has_TbExemplar_TbEmprestimo1` (`CdEmprestimo`)
);

--
-- Extraindo dados da tabela `tbemprestimoexemplar`
--

INSERT INTO `tbemprestimoexemplar` (`CdEmprestimo`, `CdExemplar`, `DtDevolucao`) VALUES
(1, 3, '2014-01-08'),
(2, 4, '2014-01-08'),
(3, 5, '2014-01-18'),
(3, 7, '2014-01-18'),
(4, 6, '2014-01-17'),
(5, 5, NULL),
(5, 9, NULL),
(6, 6, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbexemplar`
--

CREATE TABLE IF NOT EXISTS `tbexemplar` (
  `CdExemplar` int(11) NOT NULL,
  `NumPat` varchar(45) NOT NULL,
  `Situacao` char(1) NOT NULL,
  `CdLivro` int(11) NOT NULL,
  PRIMARY KEY (`CdExemplar`),
  KEY `fk_TbExemplar_TbLivro1` (`CdLivro`)
);

--
-- Extraindo dados da tabela `tbexemplar`
--

INSERT INTO `tbexemplar` (`CdExemplar`, `NumPat`, `Situacao`, `CdLivro`) VALUES
(3, '789', 'D', 2),
(4, '134', 'D', 3),
(5, '563', 'E', 3),
(6, '684', 'E', 3),
(7, '978', 'D', 4),
(8, '469', 'D', 4),
(9, '987', 'E', 4),
(10, '766', 'D', 4);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbarea`
--

CREATE TABLE IF NOT EXISTS `tbarea` (
  `CdArea` int(11) NOT NULL,
  `NmArea` varchar(45) NOT NULL,
  PRIMARY KEY (`CdArea`)
);

--
-- Extraindo dados da tabela `tbarea`
--

INSERT INTO `tbarea` (`CdArea`, `NmArea`) VALUES
(1, 'Matemática'),
(2, 'Programação'),
(3, 'Engenharia de Software'),
(4, 'Física');

--
-- Estrutura da tabela `tblivro`
--

CREATE TABLE IF NOT EXISTS `tblivro` (
  `CdLivro` int(11) NOT NULL,
  `NmLivro` varchar(45) NOT NULL,
  `Editora` varchar(45) DEFAULT NULL,
  CdArea INTEGER NOT NULL,
  PRIMARY KEY (`CdLivro`),
  FOREIGN KEY(CdArea) REFERENCES TbArea(CdArea)
);

--
-- Extraindo dados da tabela `tblivro`
--

INSERT INTO `tblivro` (`CdLivro`, `NmLivro`, `Editora`, `CdArea`) VALUES
(1, 'Lógica de programação', 'Pearson Prentice Hall', 2),
(2, 'Engenharia de software', 'AMGH', 3),
(3, 'Projeto de algoritmos', 'Cengage Learning', 2),
(4, 'Calculo', 'Pearson', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbreserva`
--

CREATE TABLE IF NOT EXISTS `tbreserva` (
  `CdReserva` int(11) NOT NULL,
  `DtReserva` date DEFAULT NULL,
  `CdAluno` int(11) NOT NULL,
  PRIMARY KEY (`CdReserva`),
  KEY `fk_TbReserva_TbAluno1` (`CdAluno`)
);

--
-- Extraindo dados da tabela `tbreserva`
--

INSERT INTO `tbreserva` (`CdReserva`, `DtReserva`, `CdAluno`) VALUES
(1, '2013-12-30', 1),
(2, '2014-01-28', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbreservalivro`
--

CREATE TABLE IF NOT EXISTS `tbreservalivro` (
  `CdReserva` int(11) NOT NULL,
  `CdLivro` int(11) NOT NULL,
  PRIMARY KEY (`CdReserva`,`CdLivro`),
  KEY `fk_TbReserva_has_TbLivro_TbLivro1` (`CdLivro`),
  KEY `fk_TbReserva_has_TbLivro_TbReserva1` (`CdReserva`)
);

--
-- Extraindo dados da tabela `tbreservalivro`
--

INSERT INTO `tbreservalivro` (`CdReserva`, `CdLivro`) VALUES
(1, 2),
(2, 3),
(2, 4);

--
-- Restrições para as tabelas dumpadas
--

--
-- Restrições para a tabela `tbautorlivro`
--
ALTER TABLE `tbautorlivro`
  ADD CONSTRAINT `fk_TbAutor_has_TbLivro_TbAutor` FOREIGN KEY (`CdAutor`) REFERENCES `tbautor` (`CdAutor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TbAutor_has_TbLivro_TbLivro1` FOREIGN KEY (`CdLivro`) REFERENCES `tblivro` (`CdLivro`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para a tabela `tbemprestimo`
--
ALTER TABLE `tbemprestimo`
  ADD CONSTRAINT `fk_TbEmprestimo_TbAluno1` FOREIGN KEY (`CdAluno`) REFERENCES `tbaluno` (`CdAluno`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para a tabela `tbemprestimoexemplar`
--
ALTER TABLE `tbemprestimoexemplar`
  ADD CONSTRAINT `fk_TbEmprestimo_has_TbExemplar_TbEmprestimo1` FOREIGN KEY (`CdEmprestimo`) REFERENCES `tbemprestimo` (`CdEmprestimo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TbEmprestimo_has_TbExemplar_TbExemplar1` FOREIGN KEY (`CdExemplar`) REFERENCES `tbexemplar` (`CdExemplar`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para a tabela `tbexemplar`
--
ALTER TABLE `tbexemplar`
  ADD CONSTRAINT `fk_TbExemplar_TbLivro1` FOREIGN KEY (`CdLivro`) REFERENCES `tblivro` (`CdLivro`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para a tabela `tbreserva`
--
ALTER TABLE `tbreserva`
  ADD CONSTRAINT `fk_TbReserva_TbAluno1` FOREIGN KEY (`CdAluno`) REFERENCES `tbaluno` (`CdAluno`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para a tabela `tbreservalivro`
--
ALTER TABLE `tbreservalivro`
  ADD CONSTRAINT `fk_TbReserva_has_TbLivro_TbReserva1` FOREIGN KEY (`CdReserva`) REFERENCES `tbreserva` (`CdReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TbReserva_has_TbLivro_TbLivro1` FOREIGN KEY (`CdLivro`) REFERENCES `tblivro` (`CdLivro`) ON DELETE NO ACTION ON UPDATE NO ACTION;
  
INSERT INTO TbReserva (CdReserva, DtReserva, CdAluno) VALUES (3, '2015/10/22', 1);

INSERT INTO TbReservaLivro (CdReserva, CdLivro) VALUES (3, 2);

SELECT NmAluno FROM TbAluno A, TbEmprestimo E WHERE E.CdAluno = A.CdAluno and DtEmprestimo = '2014-01-01';

SELECT Distinct L.CdLivro, NmLivro FROM TbLivro L, TbReservaLivro RL, TbReserva R WHERE L.CdLivro = RL.CdLivro and RL.CdReserva = R.CdReserva and CdAluno = 1;

SELECT Distinct NmLivro FROM TbLivro L, TbAluno A, TbEmprestimo E, TbEmprestimoExemplar EE, TbExemplar Ex WHERE A.CdAluno = E.CdAluno and E.CdEmprestimo = EE.CdEmprestimo and EE.CdExemplar = Ex.CdExemplar and Ex.CdLivro = L.CdLivro and A.CdAluno = 1;

SELECT Distinct NmLivro FROM TbLivro L, TbExemplar E WHERE L.CdLivro = E.CdLivro;

ALTER TABLE TbLivro ADD Preco DOUBLE NOT NULL;

UPDATE TbLivro SET Preco = 1000 WHERE CdLivro = 1;
UPDATE TbLivro SET Preco = 500 WHERE CdLivro = 2;
UPDATE TbLivro SET Preco = 200 WHERE CdLivro = 3;
UPDATE TbLivro SET Preco = 500 WHERE CdLivro = 4;

SELECT NmArea, AVG(Preco) as Média FROM TbArea A INNER JOIN TbLivro L ON A.CdArea = L.CdArea GROUP BY NmArea ORDER BY NmArea;

SELECT Count(*) as Qtd FROM TbAluno A, TbEmprestimo E WHERE E.CdAluno = A.CdAluno and NmAluno = 'Roberto Chaves';

CREATE VIEW Listagem as (
SELECT NmLivro, Count(*) as Qtd FROM TbLivro L, TbExemplar E WHERE E.CdLivro = L.CdLivro GROUP BY NmLivro);

CREATE VIEW Emprestimos as (
SELECT A.CdAluno, NmAluno, COUNT(*) AS Qtd FROM TbAluno A, TbEmprestimo E, TbEmprestimoExemplar EE WHERE E.CdAluno = A.CdAluno and EE.CdEmprestimo = E.CdEmprestimo GROUP BY NmAluno);

SELECT A.CdAluno, NmAluno, COUNT(*) AS Qtd FROM TbAluno A, TbEmprestimo E, TbEmprestimoExemplar EE WHERE E.CdAluno = A.CdAluno and EE.CdEmprestimo = E.CdEmprestimo  GROUP BY NmAluno HAVING Qtd > 2 ORDER BY CdAluno;

SELECT L.CdLivro, NmLivro FROM TbLivro L, TbAluno A, TbExemplar E, TbEmprestimoExemplar EE, TbEmprestimo Em WHERE E.CdLivro = L.CdLivro and E.CdExemplar = EE.CdExemplar and EE.CdEmprestimo = Em.CdEmprestimo and Em.CdAluno = A.CdAluno and NmAluno = 'Roberto Chaves'
UNION
SELECT L.CdLivro, NmLivro FROM TbLivro L, TbReservaLivro RL, TbReserva R, TbAluno A WHERE A.CdAluno = R.CdAluno AND R.CdReserva = RL.CdReserva and RL.CdLivro = L.CdLivro and NmAluno = 'Roberto Chaves';