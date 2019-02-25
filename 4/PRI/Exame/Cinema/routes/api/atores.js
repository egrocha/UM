var express = require('express');
var router = express.Router();
var Filme = require('../../controllers/filme');

//GET para enviar a lista de atores
router.get('/', function(req, res){
    Filme.listarAtores()
        .then(dados => {res.jsonp(dados[0].atores)})
        .catch(erro => res.status(500).send('Erro: ' + erro))
})

module.exports = router;