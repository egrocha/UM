var express = require('express');
var router = express.Router();
var Compositores = require('../../controllers/compositores');

router.get('/', function(req, res){
    if(req.query.data && req.query.periodo){
        console.log('teste')
        Compositores.listarDataPeriodo(req.query.data, req.query.periodo)
            .then(dados => res.jsonp(dados))
            .catch(erro => res.send('Erro: ' + erro))
    }
    else if(req.query.periodo){
        Compositores.listarPeriodo(req.query.periodo)
            .then(dados => res.jsonp(dados))
            .catch(erro => res.send('Erro: ' + erro))
    }
    else{
        Compositores.listar()
            .then(dados => res.jsonp(dados))
            .catch(erro => res.status(500).send('Erro: ' + erro))
    }
})

router.get('/:id', function(req, res){
    Compositores.getID(req.params.id)
        .then(dados => res.jsonp(dados))
        .catch(erro => res.status(500).send('Erro: ' + erro))
})

module.exports = router;