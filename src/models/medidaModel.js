var database = require("../database/config");

function buscarUltimasMedidas() {
    // SELECT KPIS
    var instrucaoSql = `SELECT 
    ROUND((AVG(CASE WHEN pergunta = 'sim' THEN 1 ELSE 0 END) * 100), 2) AS media_sim,
    ROUND((AVG(CASE WHEN pergunta = 'não' THEN 1 ELSE 0 END) * 100), 2) AS media_nao,
    ROUND((
    (SELECT COUNT(DISTINCT fkUsuario) FROM respostaUsuario) /
    (SELECT COUNT(*) FROM usuario)
    ) * 100, 2) AS taxa_participacao_quis
    FROM usuario;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


function buscarMedidasEmTempoReal(idUsuario) {
    // SELECT GRÁFICO

    var instrucaoSql = `SELECT
    fkQuis,
    SUM(acertos) AS ACERTOS,
    SUM(erros) AS ERROS
    FROM respostaUsuario
    WHERE fkUsuario = ${idUsuario}
    GROUP BY fkQuis;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
}
