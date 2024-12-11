const express = require('express');
const Aluno = require("../modelo/Alunos");
const fs = require('fs');
const readline = require('readline');
const multer = require('multer');

// Configuração do multer para salvar arquivos temporariamente
const upload = multer({ dest: 'uploads/' }); // Diretório temporário para arquivos

// Classe de controle
module.exports = class controlAluno {
  async controle_csv_aluno(request, response) {
    try {
        const  file  = request; // Multer adiciona o arquivo na propriedade "file"
      if (!file || !file.path) {
        return response.status(400).json({ error: 'Arquivo CSV não encontrado!' });
      }

      const ponteiroArquivo = fs.createReadStream(file.path); // Abre o arquivo CSV
      const leitorLinha = readline.createInterface({
        input: ponteiroArquivo,
        crlfDelay: Infinity, // Processa as quebras de linha corretamente
      });

      let i = 0;
      const objAluno = [];
      let qtdAlunosDuplicados = 0;
      const alunosDuplicados = [];

      for await (const linhaArquivo of leitorLinha) {
        const campos = linhaArquivo.split(';'); // Divide a linha em colunas

        const aluno = new Aluno();
        aluno.matricula = campos[0];
        aluno.nome = campos[1];
        aluno.turma = campos[2];
        aluno.nascimento = campos[3];

        if (!aluno.verificarAluno()) {
          const Alunoscriados = await aluno.createFromCsv();
          if (Alunoscriados) {
            objAluno.push(aluno);
            i++;
          }
        } else {
          qtdAlunosDuplicados++;
          alunosDuplicados.push(campos[1]); // Adiciona o nome do aluno duplicado
        }
      }

      console.log('Alunos processados:', objAluno);
      console.log('Quantidade de Alunos duplicados:', qtdAlunosDuplicados);
      console.log('Alunos duplicados:', alunosDuplicados);

      // Retorna a resposta
      response.status(200).json({
        message: 'Arquivo processado com sucesso!',
        processados: objAluno.length,
        duplicados: qtdAlunosDuplicados,
      });
    } catch (error) {
      console.error("Error>>>>>" + error);
      response.status(500).json({ error: 'Erro interno do servidor!' });
    }
  }
};