const express = require('express');
const controlAluno = require("../controle/controleAluno")
const MiddlewareAluno = require("../middleware/middlewareAluno")

module.exports = class RouterAluno {

    constructor () { 
        this._router = express.Router()
        this._controleAluno = new controlAluno()
        this._middleAluno = new MiddlewareAluno ()
    }
    criarRotasAlunos() {

        const multer = require('multer');
        const upload = multer({ dest: 'uploads/' }); // Configuração do multer

        this._router.post('/csv', upload.single('arquivo'), // Middleware do multer para upload do arquivo
          (req, res) => this._controleAluno.controle_csv_aluno(req, res) // Passa a referência corretamente
        );

        this._router.post('/login', 
          this._middleAluno.validarMatricula,
          this._middleAluno.verificarAlunoExistente,
          this._controleAluno.controle_aluno_login
        )
        
        return this._router

      }
    
}

