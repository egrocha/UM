var express = require('express');
var axios = require('axios')
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
	axios.get('http://clav-test.di.uminho.pt/api/classes/nivel/1')
		.then(funcoes => res.render('index', {funcoes: funcoes.data}))
		.catch(erro => {
			console.log('Erro na listagem de funções: ' + erro)
			res.render('error', {error: erro, message: 'Erro na listagem'})
		})
});

module.exports = router;
