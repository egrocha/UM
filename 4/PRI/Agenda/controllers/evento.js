var Evento = require('../models/evento')

module.exports.listar = () => {
    return Evento
        .find()
        .sort({data: -1})
        .exec()
}

module.exports.listarTipo = tipo => {
    return Evento
        .find({tipo: tipo})
        .sort({data: -1})
        .exec()
}

module.exports.listarData = data => {
    return Evento
        .find({data: {$gte: data}})
        .sort({data: -1})
        .exec()
}

module.exports.listarDataExact = data => {
    return Evento
        .find({data: data})
        .sort({data: -1})
        .exec()
}

module.exports.consultar = eid => {
    return Evento
        .findOne({_id: eid})
        .exec()
}

module.exports.inserir = evento => {
    return Evento.create(evento)
}