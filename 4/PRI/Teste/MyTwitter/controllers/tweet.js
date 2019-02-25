var Tweet = require('../models/tweet')

module.exports.listar = () => {
    return Tweet
        .find()
        .exec()
}

module.exports.inserir = tweet => {
    return Tweet.create(tweet)
}

module.exports.like = id => {
    return Tweet
        .updateOne({_id: id},{$inc: {likes: 1}})
        .exec()
}