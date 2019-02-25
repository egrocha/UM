var mongoose = require('mongoose')
var Schema = mongoose.Schema

var CompositoresSchema = new Schema({
    id: String,
    nome: String,
    bio: String,
    dataNasc: String,
    dataObito: String,
    periodo: String
})

module.exports = mongoose.model('Compositores', CompositoresSchema, 'comps')