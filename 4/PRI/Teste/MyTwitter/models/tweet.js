var mongoose = require('mongoose')
var Schema = mongoose.Schema

var TweetSchema = new Schema({
    texto: String,
    autor: String,
    hash: String,
    likes: {type: Number, default: 0}
})

module.exports = mongoose.model('Tweet', TweetSchema, 'tweets')