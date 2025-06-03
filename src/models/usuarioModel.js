var database = require("../database/config")

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT idUsuario, nome, email, senha FROM usuario WHERE email = '${email}' AND senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
async function cadastrar(nome, sobrenome, email, senha, pergunta) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, sobrenome, email, senha, pergunta);

    var instrucaoSqlcadastro = `SELECT email FROM usuario WHERE email = '${email}';`;
    
    try {
        var verificar = await database.executar(instrucaoSqlcadastro);

        if (verificar.length > 0) {
            throw new Error("Email já cadastrado");
        } else {

            // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
            //  e na ordem de inserção dos dados.
            var instrucaoSql = `
                INSERT INTO usuario (nome, sobrenome, email, senha, pergunta) VALUES ('${nome}', '${sobrenome}', '${email}', '${senha}', '${pergunta}');
            `;
            console.log("Executando a instrução SQL: \n" + instrucaoSql);
            return database.executar(instrucaoSql);
        }

    } catch (erro) {
        throw erro;
    }

}

// INSERINDO NO QUIZ
function inserir(fkUsuario, fkQuiz, correta, errado) {
    console.log("ACESSEI O USUARIO MODEL \n\n function inserir():", fkUsuario, fkQuiz, correta, errado)

    var instrucaoSql = `
    INSERT INTO respostaUsuario (fkUsuario, fkQuiz, acertos, erros) VALUES
    ( ${fkUsuario}, ${fkQuiz}, ${correta}, ${errado})`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar,
    inserir
};