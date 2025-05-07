CREATE DATABASE drum;
USE drum;

CREATE TABLE usuario(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
sobrenome VARCHAR(45),
email VARCHAR(200),
senha CHAR(8),
pergunta CHAR(3)
	CONSTRAINT chkResposta
		CHECK (pergunta IN ( 'sim', 'não'))
);

CREATE TABLE quiz(
idQuiz INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
descricao VARCHAR(45)
);

CREATE TABLE respostaUsuario(
id INT AUTO_INCREMENT,
fkUsuario INT ,
fkQuiz INT ,
acertos INT,
erros INT,
nota DECIMAL (4,2),
dtRealizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT respostaUsuario
	FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
CONSTRAINT respostaQuiz
	FOREIGN KEY (fkQuiz) REFERENCES quiz(idQuiz),
CONSTRAINT pkComposta
	PRIMARY KEY (id, fkUsuario, fkQuiz)
);

