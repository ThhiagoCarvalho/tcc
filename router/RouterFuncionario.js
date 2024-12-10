const express = require('express');
const ControlFuncionario = require('../controle/controleFuncionario');
const MiddlewareFuncionario = require('../middleware/middlewareFuncionario');

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
