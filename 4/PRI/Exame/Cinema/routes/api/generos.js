var express = require('express');
var router = express.Router();
var Filme = require('../../controllers/filme');

//GET para ver todos os géneros distintos
router.get('/', function(req, res){
    Filme.listarGenerosDistintos()
        .then(dados => res.jsonp(dados))
        .catch(erro => res.status(500).send('Erro: ' + erro))
})

module.exports = router;