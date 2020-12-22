CREATE TABLE TbCidade 
(CdCidade INTEGER NOT NULL,
NmCidade VARCHAR (50) NOT NULL,
PRIMARY KEY (CdCidade)
)ENGINE = InnoDB;

CREATE TABLE TbCurso 
(CdCurso INTEGER NOT NULL,
NmCurso VARCHAR (50) NOT NULL,
PRIMARY KEY (CdCurso)
)ENGINE = InnoDB;

CREATE TABLE TbProfessor(
CdProfessor INTEGER NOT NULL,
NmProfessor VARCHAR (100) NOT NULL,
Sexo CHAR,
CdCidade INTEGER NOT NULL,
CdCurso INTEGER NOT NULL,
PRIMARY KEY (CdProfessor),
FOREIGN KEY (CdCidade) REFERENCES TbCidade(CdCidade),
FOREIGN KEY (CdCurso) REFERENCES TbCurso(CdCurso)
) ENGINE = InnoDB;

CREATE TABLE TbDisciplina (
CdDisciplina INTEGER NOT NULL,
NmDisciplina VARCHAR (100) NOT NULL,
CargaHoraria INTEGER,
CdProfessor INTEGER NOT NULL,
CdCurso INTEGER NOT NULL,
PRIMARY KEY (CdDisciplina),
FOREIGN KEY (CdProfessor) REFERENCES TbProfessor(CdProfessor), 
FOREIGN KEY (CdCurso) REFERENCES TbCurso(CdCurso)
) ENGINE = InnoDB;

CREATE TABLE TbAluno(
CdAluno INTEGER NOT NULL,
NmAluno VARCHAR (100) NOT NULL,
Sexo CHAR,
CdCidade INTEGER NOT NULL,
CdCurso INTEGER NOT NULL,
PRIMARY KEY (CdAluno),
FOREIGN KEY (CdCidade) REFERENCES TbCidade(CdCidade),
FOREIGN KEY (CdCurso) REFERENCES TbCurso(CdCurso)
) ENGINE = InnoDB;

CREATE TABLE TbNota (
CdAluno INTEGER NOT NULL,
CdDisciplina INTEGER NOT NULL,
Nota NUMERIC (10,2),
PRIMARY KEY (CdAluno, CdDisciplina),
FOREIGN KEY (CdAluno) REFERENCES TbAluno(CdAluno),
FOREIGN KEY (CdDisciplina) REFERENCES TbDisciplina(CdDisciplina)
) ENGINE = InnoDB;

CREATE TABLE TbAula (
CdAula INTEGER NOT NULL,
Assunto VARCHAR(255) NOT NULL,
DtAula DATE  NOT NULL,
QtdAulas INTEGER  NOT NULL,
CdDisciplina INTEGER NOT NULL,
PRIMARY KEY (CdAula),
FOREIGN KEY (CdDisciplina) REFERENCES TbDisciplina(CdDisciplina)
) ENGINE = InnoDB;

CREATE TABLE TbFrequencia (
CdFrequencia INTEGER NOT NULL,
CdAula INTEGER NOT NULL,
CdAluno INTEGER NOT NULL,
QtdFaltas INTEGER  NOT NULL,
PRIMARY KEY (CdFrequencia),
FOREIGN KEY (CdAluno) REFERENCES TbAluno(CdAluno),
FOREIGN KEY (CdAula) REFERENCES TbAula(CdAula)
) ENGINE = InnoDB;

INSERT INTO TbCidade (CdCidade, NmCidade) VALUES (1, 'Ipatinga');
INSERT INTO TbCidade (CdCidade, NmCidade) VALUES (2, 'Cel. Fabriciano'), (3, 'Timóteo');
INSERT INTO TbCidade VALUES (4, 'Santana do Paraíso');

INSERT INTO TbCurso (CdCurso, NmCurso) VALUES (1, 'Informática'), (2, 'Edificações'), (3, 'Metalurgia');

INSERT INTO TbProfessor VALUES (1, 'João Batista', 'M', 3, 1), (2, 'Marcelo Balbino', 'M', 3, 1), (3, 'Guilherme', 'M', 3, 1), (4, 'Claudio Portes', 'M', 1, 1), (5, 'Alisson', 'M', 3, 2), (6, 'Evandro', 'M', 3, 2), (7, 'Valmir', 'M', 1, 3), (8, 'Fábio', 'M', 1, 2);

INSERT INTO TbDisciplina VALUES (1, 'Projeto de Software', 40, 2, 1), (2, 'Empreendedorismo', 40, 1, 1), (3, 'Linguagem de Programação', 100, 4, 1), (4, 'Banco de Dados', 60, 2, 1), (5, 'Eletricidade e Eletrônica', 80, 3, 1), (6, 'Infra-estrutura Urbana', 80, 5, 2), (7, 'Saneamento Básico', 60, 6, 2), (8, 'Controle de qualidade', 80, 7, 3);

INSERT INTO TbAluno VALUES (1, 'José', 'M', 2, 1), (2, 'Maria', 'F', 1, 1), (3, 'Ricardo', 'M', 1, 1), (4, 'Pedro', 'M', 2, 2), (5, 'Carlos', 'M', 1, 2), (6, 'Teresa', 'F', 3, 3);

INSERT INTO TbNota VALUES (1, 1, 50), (1, 2, 75), (1, 3, 80), (1, 4, 55), (2, 1, 90), (2, 2, 95), (2, 3, 82), (2, 4, 88), (3, 1, 40), (3, 2, 35), (3, 3, 70), (3, 4, 70);

INSERT INTO TbAula VALUES (1, 'Levantamento de Requisitos', '2016/03/10', 2, 1), (2, 'Modelagem de BD', '2016/03/11', 2, 4), (3, 'SQL – GROUP BY', '2016/08/20', 1, 4), (4, 'Polimorfismo', '2016/08/30', 2, 3),  (5, 'SQL - UNION', '2016/09/01', 2, 4);

INSERT INTO TbFrequencia VALUES (1, 2, 1, 2), (2, 2, 2, 2), (3, 3, 1, 1), (4, 5, 1, 2),(5, 5, 2, 2);

SELECT DtAula, Assunto FROM TbAula A INNER JOIN TbDisciplina D ON D.CdDisciplina = A.CdDisciplina INNER JOIN TbProfessor P ON P.CdProfessor = D.CdProfessor WHERE NmProfessor = 'Marcelo Balbino';

SELECT NmAluno, SUM(QtdFaltas) AS Total FROM TbAluno A LEFT JOIN TbFrequencia F ON F.CdAluno = A.CdAluno GROUP BY NmAluno ORDER BY NmAluno;

SELECT AVG(Nota) FROM TbNota N, TbAluno A, TbCurso C WHERE N.CdAluno = A.CdAluno and A.CdCurso = C.CdCurso and NmCurso = 'Informática';

SELECT NmAluno, AVG(Nota) as Media FROM TbNota N, TbAluno A WHERE N.CdAluno = A.CdAluno GROUP BY NmAluno HAVING Media > 60 ORDER BY NmAluno;

SELECt 'Número de Alunas' AS Tipo, COUNT(*) as Qtd FROM TbAluno A WHERE Sexo = 'F'
UNION
SELECT 'Número de Professores' AS Tipo, Count(*) as Qtd FROM TbProfessor P WHERE Sexo = 'F';

CREATE VIEW Disciplina AS (SELECT NmDisciplina, SUM(QtdAulas) as Total FROM TbDisciplina D LEFT JOIN TbAula A ON A.CdDisciplina = D.CdDisciplina GROUP BY NmDisciplina);

SELECT NmDisciplina, NmProfessor FROM TbProfessor P, TbDisciplina D WHERE D.CdProfessor = P.CdProfessor and NmDisciplina LIKE '%Software%' ORDER BY NmDisciplina;

ALTER TABLE TbAluno ADD DtNasc DATE NOT NULL;

UPDATE TbAluno SET DtNasc = '2017/10/31' WHERE CdAluno = 1;
UPDATE TbAluno SET DtNasc = '2017/10/30' WHERE CdAluno = 2;
UPDATE TbAluno SET DtNasc = '2017/10/29' WHERE CdAluno = 3;
UPDATE TbAluno SET DtNasc = '2017/10/27' WHERE CdAluno = 4;
UPDATE TbAluno SET DtNasc = '2017/10/28' WHERE CdAluno = 5;
UPDATE TbAluno SET DtNasc = '2017/10/16' WHERE CdAluno = 6;

SELECT CdAluno AS Codigo, NmAluno as Nome, DtNasc, 'Aluno' AS Tipo FROM TbAluno
UNION
SELECT CdProfessor AS Codigo, NmProfessor as Nome, '' AS DtNasc, 'Professor' AS Tipo FROM TbProfessor ORDER BY Nome;

SELECT MAX(Media) as MaiorMedia FROM (SELECT AVG(Nota) as Media FROM TbNota N, TbAluno A WHERE N.CdAluno = A.CdAluno GROUP BY NmAluno) as T;

SELECT NmAluno, Nota FROM TbNota N, TbAluno A, TbDisciplina D WHERE N.CdAluno = A.CdAluno and D.CdDisciplina = N.CdDisciplina and NmDisciplina = 'Projeto de Software';

SELECT NmAluno, Nota FROM TbNota N, TbAluno A, TbDisciplina D, (SELECT AVG(Nota) as Media FROM TbNota N, TbDisciplina D WHERE D.CdDisciplina = N.CdDisciplina and NmDisciplina = 'Projeto de Software') as Tabela WHERE N.CdAluno = A.CdAluno and D.CdDisciplina = N.CdDisciplina and Nota > Tabela.Media and NmDisciplina = 'Projeto de Software';

SELECT * FROM (SELECT A.CdAluno, NmAluno, AVG(Nota) as Media FROM TbAluno A, TbNota N WHERE N.CdAluno = A.CdAluno GROUP BY A.CdAluno) as Tabela WHERE Media = (SELECT MAX(Media) FROM (SELECT A.CdAluno, NmAluno, AVG(Nota) as Media FROM TbAluno A, TbNota N WHERE N.CdAluno = A.CdAluno GROUP BY A.CdAluno) as T);