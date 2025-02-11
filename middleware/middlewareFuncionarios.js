const Funcionario = require("../modelo/Funcionarios");
const express = require('express');


module.exports = class MiddlewareFuncionario {

    async verificarFuncionarioExistente(req, res, next) {
        try {
          const  cpf = req.body.cpf;
          const  senha = req.body.senha;

          const objFuncionario = new Funcionario()
          objFuncionario.cpf = cpf
          objFuncionario.senha = senha

          const funcionarioExistente = await objFuncionario.getFuncionario();
    
          if (!funcionarioExistente) {
            return res.status(404).json({ error: 'Funcionario não encontrado.' });
          }else {
            req.funcionario = objFuncionario
            next()
          }
    
        } catch (error) {
          console.error('Erro ao verificar aluno:', error);
          res.status(500).json({ error: 'Erro interno do servidor.' });
        }
      }


    validarDadosFuncionario(req, res, next) {
        const { cargo,usuario,senha } = req.body;
    
        if (!cargo || !usuario || senha ) {
          return res.status(400).json({ error: 'Preencha todos os campos!'});
        } 
        next();
    }
}