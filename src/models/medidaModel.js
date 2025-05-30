var database = require("../database/config");

function buscarUltimasMedidas() {
    // SELECT KPIS
    var instrucaoSql = `SELECT
    ROUND((avg(case when pergunta = 'sim' then 1 else 0 end)*100), 2)as media_sim, 
    ROUND((avg(case when pergunta = 'nao' then 1 else 0 end)* 100), 2)as media_nao
    from usuario `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function ultimaKpi() {
    // SELECT KPIS
    var instrucaoSql = `SELECT`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idUsuario) {
    // SELECT GRÁFICO

    var instrucaoSql = `SELECT
    SUM(acertos)AS 'ACERTOS',
    SUM(erros) AS 'ERROS'
    FROM respostaUsuario
    WHERE fkUsuario = ${idUsuario}
    GROUP BY fkQuis;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    ultimaKpi
}
