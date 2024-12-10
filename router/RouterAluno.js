const express = require('express');
const controlAluno = require("../controle/controleAluno")
const MiddlewareAluno = require("../middleware/middlewareAluno")

module.exports = class RouterAluno {

    constructor () { 
        this._router = express.Router()
        this._controleAluno = new controlAluno()
        this._middleAluno = new MiddlewareAluno ()
    }

    criarRotasAlunos () {
    this._router.post ('/csv' ,
        this._controleAluno.controle_csv_alunos()
    )  

    }


}

