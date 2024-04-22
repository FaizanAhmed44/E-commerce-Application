//import from packages
const express = require("express");
const mongoose = require("mongoose");

//import from other files
const authRouter = require("./routes/auth"); //for this we can run multiple get request just by running index.js otherwise only a single get req run if we use get req in index.js thats why we make seperate files for get request
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");


//Initialization
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://faizanahmed:faizan123@cluster0.tl392rg.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

//middle ware
app.use(express.json());
app.use(authRouter);  //client -> middle ware(manuplation of data) -> server -> client 
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);


//creating an API
// http://<youripadress>/hello-world      //whwere we reach to path(hello-world) of this ip address this will run
// with req we can acess any thing that user provide us like body
// app.get("/hello-world",(req,res)=>{
//     res.json({hi:"Hello world"});     
//     res.send("Hello world") //send is used for string 
// });


mongoose.connect(DB).then(()=>{
    console.log("Connection found");
}).catch((e)=>{
    console.log(e);
});

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`server start and running on ${PORT}`);    
});

