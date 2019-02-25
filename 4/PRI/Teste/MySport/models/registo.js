var mongoose = require('mongoose')
var Schema = mongoose.Schema

//foi usado o dataset do professor
//o ficheiro .json foi importado para mongo e tratado por ai

var AthleteSchema = new Schema({
    id: String,
    resource_state: String
})

var RegistoSchema = new Schema({
    resource_state: String,
    athlete: AthleteSchema,
    name: String,
    distance: String,
    moving_time: String,
    elapsed_time: String,
    total_elevation_gain: String,
    type: String,
    workout_type: String,
    id: String,
    external_id: String,
    upload_id: String,
    start_date: String,
    start_date_local: String,
    timezone: String,
})

module.exports = mongoose.model('Registo', RegistoSchema, 'regs')