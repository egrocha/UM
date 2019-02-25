var Compositores = require('../models/compositores')

module.exports.listar = () => {
    return Compositores
        .find({dataNasc: {$exists: true}}, {_id: 0, id: 1, nome: 1, dataNasc: 1})
        .exec()
}

module.exports.listarPeriodo = p => {
    return Compositores
        .find({periodo: p}, {_id: 0, id: 1, nome: 1, periodo: 1})
        .exec()
}

module.exports.listarDataPeriodo = (d, p) => {
    console.log(d+' '+p)
    return Compositores
        .find({data: {$gt:d}, periodo: p})
        .exec()
}

module.exports.getID = i => {
    return Compositores
        .findOne({id: i},{id: 1, nome: 1})
}