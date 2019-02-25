var express = require('express');
var router = express.Router();
var axios = require('axios')

//Get a uma classe
router.get('/:id', function(req, res){
    console.log(req.url)
    axios.get('http://clav-test.di.uminho.pt/api/classes/c'+req.params.id)
        .then(function(classe){
            axios.get('http://clav-test.di.uminho.pt/api/classes/c'+req.params.id+'/descendencia')
                .then(function(desc){
                    if(req.params.id.split('.').length === 3){
                        axios.get('http://clav-test.di.uminho.pt/api/classes/c'+req.params.id+'/dono')
                            .then(function(donos){
                                var arr = req.url.split('.')
                                arr.pop()
                                var str = arr[0]
                                for(i = 1; i < arr.length; i++){
                                    str = str + "." + arr[i]  
                                }
                                res.render('classe', {classe: classe.data, descendentes: desc.data, donos: donos.data, url: str})
                            })
                            //.then(donos => res.render('classe', {classe: classe.data, descendentes: desc.data, donos: donos.data, url: req.url}))
                            .catch(erro => {
                                console.log('Erro na listagem de uma classe: ' + erro)
                                res.render('error', {error: erro, message: 'Erro na listagem de uma classe'})
                            })
                    }
                    else{
                        if(req.url.split('.').length === 1){
                            res.render('classe', {classe: classe.data, descendentes: desc.data})
                        }
                        else{
                            var arr = req.url.split('.')
                            arr.pop()
                            var str = arr[0]
                            for(i = 1; i < arr.length; i++){
                                str = str + "." + arr[i]  
                            }
                            res.render('classe', {classe: classe.data, descendentes: desc.data, url: str})
                        }
                    }
                })
                .catch(erro => {
                    console.log('Erro na listagem de uma classe: ' + erro)
                    res.render('error', {error: erro, message: 'Erro na listagem de uma classe'})
                })
                //then(desc => res.render('classe', {classe: classe.data, descendentes: desc.data}))
        })
        //.then(classe => res.render('classe', {classe: classe.data}))
        .catch(erro => {
            console.log('Erro na listagem de uma classe: ' + erro)
            res.render('error', {error: erro, message: 'Erro na listagem de uma classe'})
        })
})

module.exports = router;