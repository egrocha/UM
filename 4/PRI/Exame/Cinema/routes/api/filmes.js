var express = require('express');
var router = express.Router();
var Filme = require('../../controllers/filme');

//GET para ver filmes, com condições para género e data
router.get('/', function(req, res){
    if(req.query.categoria === 'Action' && req.query.data){
        Filme.listarGeneroData(req.query.categoria, req.query.data)
            .then(dados => res.jsonp(dados))
            .catch(erro => res.status(500).send('Erro: ' + erro))
    }
    else if(req.query.genro === 'Action'){
        Filme.listarGenero(req.query.genro)
            .then(dados => res.jsonp(dados))
            .catch(erro => res.status(500).send('Erro: ' + erro))
    }
    else{
        Filme.listar()
            .then(dados => res.jsonp(dados))
            .catch(erro => res.status(500).send('Erro na listagem: ' + erro))
    }
})

/*GET para ver um filme, com o id fornecido
O ficheiro importado para a base de dados foi o moviesID.json
Este ficheiro tem um novo ID criado pelo script moviesAddID.js (F1, F2, F3, etc.)
O ID que esta função usa é esse ID novo e não o _id do mongo
*/
router.get('/:id', function(req, res){
    Filme.listarID(req.params.id)
        .then(dados => res.jsonp(dados))
        .catch(erro => res.status(500).send('Erro: ' + erro))
})

module.exports = router;