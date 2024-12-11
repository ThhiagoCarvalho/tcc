const Alunos = require("../modelo/Alunos");
const express = require('express');

module.exports = class MiddlewareAluno {

  async verificarAlunoExistente(req, res, next) {
    try {
      const { matricula } = req.body;

      if (!matricula) {
        return res.status(400).json({ error: 'Matrícula do aluno não fornecida.' });
      }

      const alunoExistente = await Alunos.getAluno(matricula);

      if (!alunoExistente) {
        return res.status(404).json({ error: 'Aluno não encontrado.' });
      }

      // Adiciona o aluno encontrado na requisição para uso posterior
      req.aluno = alunoExistente;

      next();
    } catch (error) {
      console.error('Erro ao verificar aluno:', error);
      res.status(500).json({ error: 'Erro interno do servidor.' });
    }
  }

  /**
   * Middleware para validar os dados do aluno no corpo da requisição.
   * @param {*} req
   * @param {*} res
   * @param {*} next
   */
  validarDadosAluno(req, res, next) {
    const { matricula, nome, turma, nascimento } = req.body;

    if (!matricula || !nome || !turma || !nascimento) {
      return res.status(400).json({
        error: 'Os campos matrícula, nome, turma e nascimento são obrigatórios.',
      });
    }

    // Validação simples de formato de dados (pode ser expandida conforme necessário)
    if (typeof matricula !== 'string' || typeof nome !== 'string' || typeof turma !== 'string') {
      return res.status(400).json({ error: 'Matrícula, nome e turma devem ser strings.' });
    }

    next();
  }

  /**
   * Middleware para verificar duplicidade de alunos por matrícula.
   * @param {*} req
   * @param {*} res
   * @param {*} next
   */
  async verificarDuplicidadeAluno(req, res, next) {
    try {
      const { matricula } = req.body;

      const alunoExistente = await Alunos.getAluno(matricula);

      if (alunoExistente) {
        return res.status(409).json({ error: 'Aluno já cadastrado com esta matrícula.' });
      }

      next();
    } catch (error) {
      console.error('Erro ao verificar duplicidade:', error);
      res.status(500).json({ error: 'Erro interno do servidor.' });
    }
  }
};
