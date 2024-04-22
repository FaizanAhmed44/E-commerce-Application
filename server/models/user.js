const mongoose = require("mongoose");
const { productSchema } = require("./product");

const userSchema = mongoose.Schema({   //schema is lika a structure of our application or user model that we going to have
      name:{
        required: true,
        type: String,
        trim: true, // remove before and after spaces of a string " aba " => "aba"
      },
      email:{
        required:true,
        type:String,
        trim:true,
        validate:{
            validator:(value)=>{
                const re = 
                  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
               return value.match(re);
            },
            message:"Please enter a valid email",   //this property when there is a error in validator
        },
      },
      password:{
        required:true,
        type:String,
      },
      address:{
        type:String,
        default:"", //it is null because we dont have any field for address
      },
      type:{
        type:String,
        default:"User",
      },
      cart:[
        {
          product:productSchema,
          quantity:{
            type:Number,
            required:true,
          },
        },
      ],
      wishlist:[
        {
          product:productSchema,
        }
      ],
});

const User = mongoose.model("User",userSchema);
module.exports = User;