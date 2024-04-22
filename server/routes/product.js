const express = require("express");
const auth = require("../middleware/auth");
const {Product} = require("../models/product");
const ratingSchema = require("../models/rating");

const productRouter = express.Router();

//get all the products
productRouter.get("/api/products",auth,async (req,res)=>{
    try{

    //api/products?category=Essentials  // it means that we access value of category(Essentials) by using req.query.category
    //api/products:category=Essentials  // it means that we access value of category(Essentials) by using req.params.category
        console.log(req.query.category);
        const products = await Product.find({category:req.query.category});  //if we dont specify anything under find it will get all the files than are available in database        
        res.json(products);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});


//create a get request to search and get them
productRouter.get("/api/products/search/:name",auth,async (req,res)=>{
    try{

    //api/products?category=Essentials  // it means that we access value of category(Essentials) by using req.query.category
    //api/products:category=Essentials  // it means that we access value of category(Essentials) by using req.params.category
        console.log(req.query.category);
        const products = await Product.find({
            name:{ $regex :req.params.name , $options:"i"},
        });  //if we dont specify anything under find it will get all the files than are available in database        
        res.json(products);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});




//post req route to rate the product
productRouter.post("/api/rate-product",auth,async (req,res)=>{
    try{
        const {id,rating} = req.body;
        let product = await Product.findById(id);

        //this below loop for rating if previous rate 4 then user update it to 5 it will update it
        //{
        //     "id":"1112",
        //     "rating":2.5
        // }//it means that product.ratings is list of array which all the users that rate the product
        //{
        //     "id":"1112234234",
        //     "rating":4
        // }
        
        for(let i=0;i<product.ratings.length;i++){
              if(product.ratings[i].userId == req.user){
                product.ratings.splice(i,1);   //delete the previous rating of the same user
                break;
              }
        }

        const ratingSchema = {
            userId:req.user,
            rating,
        }

        product.ratings.push(ratingSchema);  //add the new rating of the same user
        product = await product.save();
        res.json(product);

    }catch(e){
        res.status(500).json({error:e.message});
    }
});

productRouter.get("/api/deal-of-day",auth,async (req,res) =>{
   try{
      let products = await Product.find({}); //it will give us list of all the product

      //now we sort the product and which product rating is high it will become the deal of the day
      products = products.sort((a,b)=>{
        let asum=0;
        let bsum=0;

        for(let i=0;i<a.ratings.length;i++){
            asum += a.ratings[i].rating;
        }
        for(let i=0;i<b.ratings.length;i++){
            bsum += b.ratings[i].rating;
        }

        return asum<bsum ? 1 : -1;

      });
     console.log('length of java is',products.length);
    //   res.json(products[0]);
      res.json(products);
   }catch(e){
    res.status(500).json({error:e.message});
   }
});

module.exports = productRouter;