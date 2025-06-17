CREATE DATABASE bdrums;
USE bdrums;

CREATE TABLE IF NOT EXISTS usuario(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
sobrenome VARCHAR(45) NOT NULL,
email VARCHAR(200) NOT NULL,
senha CHAR(8) NOT NULL,
isBaterista TINYINT NOT NULL
	CONSTRAINT chkResposta
	CHECK (isBaterista IN (0, 1))
);

CREATE TABLE IF NOT EXISTS quiz(
idQuiz INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
descricao VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS respostaUsuario(
id INT AUTO_INCREMENT,
fkUsuario INT,
fkQuiz INT ,
acertos INT NOT NULL,
erros INT NOT NULL,
dtRealizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT respostaUsuario
	FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
CONSTRAINT respostaQuiz
	FOREIGN KEY (fkQuiz) REFERENCES quiz(idQuiz),
CONSTRAINT pkComposta
	PRIMARY KEY (id, fkUsuario, fkQuiz)
);

-- INSERINDO USUARIOS PARA EXPERIMENTO
INSERT INTO usuario (nome, sobrenome, email, senha, isBaterista) VALUES
('Ana', 'Silva', 'ana.silva@email.com', '1234abcd', 1),
('Bruno', 'Costa', 'bruno.costa@email.com', 'abcd1234', 0),
('Carla', 'Santos', 'carla.santos@email.com', 'senha123', 1),
('Diego', 'Souza', 'diego.souza@email.com', 'qwerty12', 0),
('Elaine', 'Oliveira', 'elaine.oli@email.com', 'teste456', 1),
('Felipe', 'Lima', 'felipe.lima@email.com', 'abc12345', 0),
('Giovana', 'Ferreira', 'gi.ferreira@email.com', 'giov2024', 1),
('Henrique', 'Almeida', 'henrique.al@email.com', 'pass9876', 0),
('Isabela', 'Moura', 'isa.moura@email.com', 'moura999', 1),
('João', 'Pereira', 'joao.pereira@email.com', 'joao2025', 0);

-- INSERINDO OS QUIZ
INSERT INTO quiz VALUES
(1, '1°Quiz', 'Perguntas do primeiro quiz para o usuário.'),
(2, '2°Quiz', 'Perguntas do primeiro quiz para o usuário.');

-- SELECT PARA SABER A MÉDIA DE PESSOAS QUE ACESSAM O SITE E SÃO E NÃO SÃO BATERISTAS e
-- PARA SABER DE TODOS OS USUARIOS QUANTOS FIZERAM PELO MENOS 1 QUIZ.
SELECT 
  ROUND((AVG(CASE WHEN isBaterista = 0 THEN 1 ELSE 0 END) * 100), 2) AS media_nao,
  ROUND((AVG(CASE WHEN isBaterista = 1 THEN 1 ELSE 0 END) * 100), 2) AS media_sim,
  ROUND((
    (SELECT COUNT(DISTINCT fkUsuario) FROM respostaUsuario) /
    (SELECT COUNT(*) FROM usuario)
  ) * 100, 2) AS taxa_participacao_quiz
FROM usuario;

-- SELECT FEEDBACK DE EFETUAÇÃO DO QUIZ
SELECT
u.idUsuario,
u.nome,
r.acertos AS Acertos,
r.erros AS Erros,
q.idQuiz,
q.nome AS 'Nome Quiz'
FROM usuario u JOIN respostaUsuario r
ON u.idUsuario = r.fkUsuario
JOIN quiz q
ON q.idQuiz = fkQuiz;