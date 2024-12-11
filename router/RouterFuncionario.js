const express = require('express');
const ControlFuncionario = require('../controle/controleFuncionarios');
const MiddlewareFuncionario = require('../middleware/middlewareFuncionarios');

module.exports = class RouterFuncionario {
    constructor() {
        this._router = express.Router();
        this._controleFuncionario = new ControlFuncionario();
        this._middleFuncionario = new MiddlewareFuncionario();
    }

    criarRotasFuncionario() {
        this._router.post ('/csv' ,
            this._controleAluno.controle_csv_funcionarios()
        ) 

    }
};
