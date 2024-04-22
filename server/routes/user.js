const express = require("express");
const auth = require("../middleware/auth");
const userRouter = express.Router();
const {Product} = require("../models/product");
const User = require("../models/user");
const Order = require("../models/order");


userRouter.post('/api/add-to-cart',auth,async (req,res)=>{
    try{
         const {id} = req.body; 
         const product = await Product.findById(id);
         let user = await User.findById(req.user);

         if(user.cart.length == 0){
            user.cart.push({product,quantity:1});
         }else{
            let flag = false;
            for(let i=0;i<user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){
                    flag=true;  //means if this product already exist in cart
                }
            }

            if(flag){
                let pro = user.cart.find((e)=> e.product._id.equals(product._id));  //get the existing user
                pro.quantity+=1;
            }else{
                user.cart.push({product,quantity:1});
            }  
         }

         user=await user.save();
         res.json(user);

    }catch(e){
        res.status(500).json({error:e.message});
    }

});


userRouter.delete('/api/remove-from-cart/:id',auth,async (req,res)=>{
    try{
         const {id} = req.params; 
         const product = await Product.findById(id);
         let user = await User.findById(req.user);


            for(let i=0;i<user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){
                    if(user.cart[i].quantity==1){
                        user.cart.splice(i,1);
                    }else{
                        user.cart[i].quantity -= 1;
                    }

                }
            }
         user=await user.save();
         res.json(user);

    }catch(e){
        res.status(500).json({error:e.message});
    }

});

userRouter.post("/api/save-user-address",auth,async (req,res)=>{
    try{
        const {address}  = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
    }catch(e){
        res.status(500).json({error:e.message});
    }

});

//order product
userRouter.post("/api/order",auth,async (req,res)=>{
    try{
        const {cart,totalPrice,address}  = req.body;
        
        let products = [];

        for(let i=0;i<cart.length;i++){
            let product = await Product.findById(cart[i].product._id);
            if(product.quantity >= cart[i].quantity){  // check we have stock available for this order
                product.quantity -= cart[i].quantity;
                products.push({product,quantity:cart[i].quantity});
                await product.save();
            }else{
                return res.status(400).json({msg:`${product.name} is out stock!`});
            }
        }

        let user =await User.findById(req.user);
        user.cart =[];  // make the cart empty because order is placed and now no item left in cart
        user = await user.save();

        let order = new Order({
            products,
            totalPrice,
            address,
            userId:req.user,
            orderedAt:new Date().getTime(),
        });
        order = await order.save();
        res.json(order);
    }catch(e){
        res.status(500).json({error:e.message});
    }

});


//get order
userRouter.get("/api/order/me",auth,async (req,res)=>{
   try{
     const order = await Order.find({userId:req.user});
     res.json(order);
   }catch(e){
    res.status(500).json({error:e.message});
   }
});

userRouter.post('/api/add-to-wishlist',auth,async (req,res)=>{
    try{
         const {id} = req.body; 
         const product = await Product.findById(id);
         let user = await User.findById(req.user);

         user.wishlist.push({product});

         user=await user.save();
         res.json(user);

    }catch(e){
        res.status(500).json({error:e.message});
    }

});

userRouter.delete('/api/remove-from-wishlist/:id',auth,async (req,res)=>{
    try{
         const {id} = req.params; 
         const product = await Product.findById(id);
         let user = await User.findById(req.user);

        for(let i=0;i<user.wishlist.length;i++){
            if(user.wishlist[i].product._id.equals(product._id)){
                user.wishlist.splice(i,1);
            }
        }

         user=await user.save();
         res.json(user);

    }catch(e){
        res.status(500).json({error:e.message});
    }

});


module.exports = userRouter;