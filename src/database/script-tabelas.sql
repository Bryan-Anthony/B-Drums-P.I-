-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

CREATE DATABASE bdrums;
USE bdrums;

CREATE TABLE IF NOT EXISTS usuario(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
sobrenome VARCHAR(45) NOT NULL,
email VARCHAR(200) NOT NULL,
senha CHAR(8) NOT NULL,
pergunta CHAR(3) NOT NULL
	CONSTRAINT chkResposta
		CHECK (pergunta IN ( 'sim', 'não'))
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
INSERT INTO usuario (nome, sobrenome, email, senha, pergunta) VALUES
('Ana', 'Silva', 'ana.silva@email.com', '1234abcd', 'sim'),
('Bruno', 'Costa', 'bruno.costa@email.com', 'abcd1234', 'não'),
('Carla', 'Santos', 'carla.santos@email.com', 'senha123', 'sim'),
('Diego', 'Souza', 'diego.souza@email.com', 'qwerty12', 'não'),
('Elaine', 'Oliveira', 'elaine.oli@email.com', 'teste456', 'sim'),
('Felipe', 'Lima', 'felipe.lima@email.com', 'abc12345', 'não'),
('Giovana', 'Ferreira', 'gi.ferreira@email.com', 'giov2024', 'sim'),
('Henrique', 'Almeida', 'henrique.al@email.com', 'pass9876', 'não'),
('Isabela', 'Moura', 'isa.moura@email.com', 'moura999', 'sim'),
('João', 'Pereira', 'joao.pereira@email.com', 'joao2025', 'não');

-- INSERINDO OS QUIZ
INSERT INTO quiz VALUES
(1, '1°Quis', 'Perguntas do primeiro quis para o usuário.'),
(2, '2°Quis', 'Perguntas do primeiro quis para o usuário.');

-- SELECT PARA SABER A MÉDIA DE PESSOAS QUE ACESSAM O SITE E SÃO E NÃO SÃO BATERISTAS e
-- PARA SABER DE TODOS OS USUARIOS QUANTOS FIZERAM PELO MENOS 1 QUIZ.
SELECT 
  ROUND((AVG(CASE WHEN pergunta = 'sim' THEN 1 ELSE 0 END) * 100), 2) AS media_sim,
  ROUND((AVG(CASE WHEN pergunta = 'não' THEN 1 ELSE 0 END) * 100), 2) AS media_nao,
  ROUND((
    (SELECT COUNT(DISTINCT fkUsuario) FROM respostaUsuario) /
    (SELECT COUNT(*) FROM usuario)
  ) * 100, 2) AS taxa_participacao_quiz
FROM usuario;


-- SELECT DE FEEDBACK DE EFETUAÇÃO DO QUIZ
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
