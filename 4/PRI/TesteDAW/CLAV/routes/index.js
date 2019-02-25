var express = require('express');
var router = express.Router();
var axios = require('axios')

/* GET home page. */
router.get('/', function(req, res, next) {
  axios.get('http://clav-test.di.uminho.pt/api/classes/nivel/1')
    .then(classes => res.render('index', {classes: classes.data}))
    .catch(erro => {
      console.log('Erro na listagem de classes: ' + erro)
      res.render('error', {error: erro, message: 'erro na listagem'})
    })
});

module.exports = router;
