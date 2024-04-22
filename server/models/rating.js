const mongoose = require("mongoose");

const ratingSchema = mongoose.Schema({
    userId:{
        type:String,
        required:true,
    },
    rating:{
        type:Number,
        required:true,
    }
});

//we dont create a model because with model it will create a new seperate model with version and id but we store this rating in usermodel id thats why we cant create a model

module.exports = ratingSchema;