const express = require('express');
const Ocorrencia = require("../modelo/Ocorrencias");

module.exports = class ControlOcorrencia {
    async controle_post_ocorrencia (request, response) {
        try  {
            const AlunoMatricula = request.body.AlunoMatricula
            const tipoOcorrencia = request.body.AlunoMatricula
            const funcionarioOrientador = request.body.AlunoMatricula
            const funcionarioProfessor = request.body.AlunoMatricula
            const relatoFuncionario = request.body.AlunoMatricula
            const relatoAluno = request.body.AlunoMatricula
            const conduta = request.body.AlunoMatricula 
            const statusOcorrencia = request.body.AlunoMatricula 
            const momento = request.body.AlunoMatricula

            const objOcorrencia = new Ocorrencia ()
            objOcorrencia 

            const ocorrenciaFeita = await objOcorrencia.post_ocorrencia()

            const objResposta = {
                status : ocorrenciaFeita ,
                msg : ocorrenciaFeita ? "ocorrencia feita" : "falha ao fazer ocorrencia"
            }
            response.status(200).send(objResposta)

        }catch(Error)  { 
            const objResposta = {
                status : false ,
                msg : "erro ao relatar ocorrencia"

            }
            response.status(400).send(objResposta)
        }
    }
}