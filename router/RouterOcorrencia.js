const express = require('express');
const ControlOcorrencia = require('../controle/controleOcorrencias');
const MiddlewareOcorrencia = require('../middleware/middlewareOcorrencia');

module.exports = class RouterOcorrencia {
    constructor() {
        this._router = express.Router();
        this._controleOcorrencia = new ControlOcorrencia();
        this._middleOcorrencia = new MiddlewareOcorrencia();
    }

    criarRotasOcorrencia() {
        this._router.post ('/' ,
            this._controleOcorrencia.controle_post_ocorrencias()
        ) 
    }
};
