var express = require('express');
var router = express.Router();
var Registo = require('../../controllers/registo');

//URLs para filtro estão hardcoded em vez de opcionais

router.get('/', function(req, res){
    if(req.query.filtro === 'maislonga'){
        Registo.listarMaisLonga()
            .then(dados => res.jsonp(dados))
            .catch(erro => res.status(500).send('Erro: ' + erro))
    }
    else{
        Registo.listar()
            .then(dados => res.jsonp(dados))
            .catch(erro => res.status(500).send('Erro na listagem: ' + erro))
    }
})

router.get('/:tipo', function(req, res){
    if(req.query.filtro === 'maislonga'){
        Registo.listarMaisLongaTipo(req.params.tipo)
            .then(dados => res.jsonp(dados))
            .catch(erro => res.status(500).send('Erro: ' + erro))
    }
    else{
        Registo.consultar(req.params.tipo)
            .then(dados => res.jsonp(dados))
            .catch(erro => res.status(500).send('Erro na consulta: ' + erro))
    }
})

module.exports = router;