const mongoose = require("mongoose");
const { productSchema } = require("./product");

const orderSchema = mongoose.Schema({
    products:[
        {
            product:productSchema,
            quantity:{
            type:Number,
            required:true,
            },
        },
    ],
    address:{
        type:String,
        required:true,
    },
    totalPrice:{
        type:Number,
        required:true,
    },
    userId:{
        type:String,
        required:true,
    },
    orderedAt:{
        type:Number,
        required:true,
    },
    status:{
        type:Number,
        default:0,  //now means now just order the product(pending),1 will mean completed,2 will mean received,3 will mean delivered
    }

        
});

const Order = mongoose.model("Order",orderSchema);
module.exports = Order;