var express = require('express')
var router = express.Router();
var Tweet = require('../../controllers/tweet')

router.get('/', function(req, res){
    Tweet.listar()
        .then(dados => res.jsonp(dados))
        .catch(erro => res.status(500).send('Erro na listagem: ' + erro))
});

router.post('/', function(req, res){
    Tweet.inserir(req.body)
        .then(dados => res.jsonp(dados))
        .catch(erro => res.status(500).send('Erro na listagem ' + erro))
})

router.put('/', function(req, res){
    Tweet.like(req.body.params.id)
        .then(dados => res.jsonp(dados))
        .catch(erro => res.status(500).send('Erro na listagem: ' + erro))
})

module.exports = router;