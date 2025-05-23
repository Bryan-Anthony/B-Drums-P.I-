-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

CREATE DATABASE drum;
USE drum;

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
nota DECIMAL (4,2) NOT NULL,
dtRealizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT respostaUsuario
	FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
CONSTRAINT respostaQuiz
	FOREIGN KEY (fkQuiz) REFERENCES quiz(idQuiz),
CONSTRAINT pkComposta
	PRIMARY KEY (id, fkUsuario, fkQuiz)
);