var Filme = require('../models/filme')

//Lista todos os filmes
module.exports.listar = () => {
    return Filme
        .find({}, {_id: 0, title: 1, year: 1})
        .exec()
}

//Lista filmes com um dados género
module.exports.listarGenero = genro => {
    return Filme
        .find({genres: {$in: [genro]}}, {title: 1, year: 1, genres: 1})
        .exec()
}

//Lista os filmes com um dado género e data maior à dada
module.exports.listarGeneroData = (categoria, data) => {
    return Filme
        .find({genres: {$in: [categoria]}, year: {$gt:data}}, {title: 1, year: 1, genres: 1})
        .exec()
}

//Lista filme com um ID
module.exports.listarID = id => {
    return Filme
        .find({id: id},{_id: 0, id: 1, title: 1})
        .exec()
}

//Lista todos os géneros diferentes
module.exports.listarGenerosDistintos = () => {
    return Filme
        .distinct('genres')
        .exec()
}

//Lista os atores existentes, ordenados alfabeticamente
module.exports.listarAtores = () => {
    return Filme
        .aggregate([{$unwind: '$cast'},
                    {$project: {'_id': 0, 'cast': 1}},
                    {$sort: {'cast': 1}},
                    {$group:{_id: 'Atores', atores: {$push: '$cast'}}}
                  ])
        .exec()
}