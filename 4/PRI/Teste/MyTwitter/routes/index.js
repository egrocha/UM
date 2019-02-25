var express = require('express');
var router = express.Router();
var axios = require('axios')

/* GET home page. */
router.get('/', function(req, res) {
  axios.get('http://localhost:3000/api/tweets')
      .then(tweets => res.render('index', {tweets: tweets.data}))
      .catch(erro => {
          console.log('Erro na listagem de eventos: ' + erro)
          res.render('error', {error: erro, message: "na listagem..."})
      })
});

router.post('/', function(req, res) {
    console.log('pog?')
  axios.post('http://localhost:3000/api/tweets', req.body)
      .then(()=> res.redirect('http://localhost:3000/'))
      .catch(erro => {
          console.log('Erro na inserção do evento: ' + erro)
          res.render('error', {error: erro, message: "Meu erro ins..."})
      })
})

router.get('/like:id', function(req, res){
    console.log(req.params.id)
    axios.put('http://localhost:3000/api/tweets', {params:{id:req.params.id}})
        .then(() => res.redirect('http://localhost:3000/'))
        .catch(erro => {
            console.log('Erro na inserção do evento: ' + erro)
            res.render('error', {error: erro, message: 'Meu erro ins'})
        })
})

module.exports = router;
