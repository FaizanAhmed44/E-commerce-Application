const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const {Product} = require("../models/product");
const Order = require("../models/order");

// creating an middleware just for verifying if a conected person is basically a user or admin if its admin then it will do further work

adminRouter.post('/admin/add-product',admin,async (req,res)=>{
    try{
         const {name,description,images,quantity,price,category} = req.body; 

         let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
         });

         product = await product.save();
         res.json(product);

    }catch(e){
        res.status(500).json({error:e.message});
    }

});


//get all the products
adminRouter.get("/admin/get-products",admin,async (req,res)=>{
    try{
        const products = await Product.find({});  //if we dont specify anything under find it will get all the files than are available in database
        res.json(products);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});

//delete products
adminRouter.post("/admin/delete-products",admin,async (req,res)=>{
    try{
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);        
        res.json(product);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});

//get all the orders
adminRouter.get("/admin/get-orders",admin,async (req,res)=>{
    try{
      const orders = await Order.find({});
      res.json(orders);
    }catch(e){
     res.status(500).json({error:e.message});
    }
 });

//change order status
adminRouter.post("/admin/change-order-status",admin,async (req,res)=>{
    try{
        const {id,status} = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        res.json(order);
    }catch(e){
        res.status(500).json({error:e.message});
    }
}); 


//get total earning and category wise total earning
adminRouter.get("/admin/analytics",admin,async (req,res)=>{
   try{
       const order =await Order.find({});
       let totalEarnings = 0;

       for(let i=0;i<order.length;i++){
          for(let j=0;j<order[i].products.length;j++){
            totalEarnings += order[i].products[j].quantity * order[i].products[j].product.price;
          }
       }
      
       // CATEGORY WISE ORDER FETCHING
       let MobilesEarnings = await fetchCategoryWiseProduct("Mobiles");
       let EssentialsEarnings = await fetchCategoryWiseProduct("Essentials");
       let AppliancesEarnings = await fetchCategoryWiseProduct("Appliances");
       let BooksEarnings = await fetchCategoryWiseProduct("Books");
       let FashionEarnings = await fetchCategoryWiseProduct("Fashion");

       let earnings ={
        totalEarnings,
        MobilesEarnings,
        EssentialsEarnings,
        AppliancesEarnings,
        BooksEarnings,
        FashionEarnings,
       };

       res.json(earnings);

   }catch(e){
        res.status(500).json({error:e.message});
   }
});

async function fetchCategoryWiseProduct(category){
    let categoryOrder =await Order.find({
        'products.product.category':category,
    });
    let earnings = 0;

    for(let i=0;i<categoryOrder.length;i++){
       for(let j=0;j<categoryOrder[i].products.length;j++){
         earnings += categoryOrder[i].products[j].quantity * categoryOrder[i].products[j].product.price;
       }
    }
    return earnings;
}

module.exports = adminRouter;