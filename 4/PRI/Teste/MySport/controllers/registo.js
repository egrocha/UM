var Registo = require('../models/registo')

//lista registos
module.exports.listar = () => {
    return Registo
        .find({}, {_id: 0, start_date: 1, type: 1, distance: 1, elapsed_time:1})
        .sort({start_date: -1})
        .exec()
}

//lista mais longa de todos os registos
module.exports.listarMaisLonga = () => {
    return Registo
        .find()
        .sort({elapsed_time: -1})
        .limit(1)
        .exec()
}

//lista registos de um tipo especifico
module.exports.consultar = tipo => {
    return Registo
        .find({type: tipo}, {_id: 0, start_date: 1})
        .sort({start_date: -1})
        .exec()
}

//lista mais longa de um tipo
module.exports.listarMaisLongaTipo = tipo => {
    return Registo
        .find({type: tipo})
        .sort({elapsed_time: -1})
        .limit(1)
        .exec()
}