var mongoose = require('mongoose')
var Schema = mongoose.Schema 

var FilmeSchema = new Schema({
    title: {type: String, required: true},
    year: {type: Number, required: true},
    cast: {type: [String], required: true},
    genres: {type: [String], required: true}
})

module.exports = mongoose.model('Filme', FilmeSchema, 'filmes')