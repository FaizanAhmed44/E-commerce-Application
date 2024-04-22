const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

const authRouter = express.Router();

//sign up routes
authRouter.post("/api/signup",async (req,res)=>{
    try{
        //get the data from client       thats 3 are the purpose of post request
    const {name,email,password} = req.body;  //map gives data in map format
    // {
    //     "name":name,"email":email,"password":password
    // } // map
    
    const existingUser = await User.findOne({email}); //is is basically a promise or future in dart its going to mongodb and find if user already exist then it will return error
    if(existingUser){
        return res.status(400).json({msg:"User with this email already exist try again"});  //status(400) means there is a error or status(200) means no error or everything is ok.
    }
    
    const hashedPassword = await bcryptjs.hash(password,8); // for making encrypted password

    //post the data from database 
    let user = new User({  //if no error found then we will create a new user
        email,   //email:email
        password:hashedPassword,
        name
    });
    user = await user.save();

    //return the data to the user
    
    res.json(user);

    } catch(e){
        res.status(500).json({error:e.message});
    }
});


//sign in routes
authRouter.post("/api/signin",async (req,res)=>{
    try{
        //get the data from client       thats 3 are the purpose of post request
    const {email,password} = req.body;  //map gives data in map format
    
    const user = await User.findOne({email}); //is is basically a promise or future in dart its going to mongodb and find if user already exist then it will return error
    if(!user){
        return res.status(400).json({msg:"User with this email does not exist"});  //status(400) means there is a error or status(200) means no error or everything is ok.
    }
    
    //now compare the password with hash password one thing which is imp to note no two same password have same hashed password i.e first time pass is faizan and hash is 1232 and second time when other person choose password faizan this time hash in change for faizan like 34567
    const isMatch = await bcryptjs.compare(password,user.password); // it gives us boolean value
     if(!isMatch){
        return res.status(400).json({msg:"Incorrect password"});  
     }

    //  JSON Web Token (JWT) is an open standard (RFC 7519) that defines a compact and self-contained way for securely transmitting information between parties as a JSON object. This information can be verified and trusted because it is digitally signed. JWTs can be signed using a secret (with the HMAC algorithm) or a public/private key pair using RSA or ECDSA.
     const token = await jwt.sign({id:user._id},"passwordKey");
     res.json({token, ...user._doc});     
    } catch(e){
        res.status(500).json({error:e.message});
    }
});

//verify token or token is exist or not
authRouter.post("/tokenIsValid",async (req,res)=>{
    try{
        const token = req.header('x-auth-token');
        if(!token) return res.json(false);

        const verified = jwt.verify(token,"passwordKey");
        if(!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if(!user) return res.json(false);

        res.json(true);


    } catch(e){
        res.status(500).json({error:e.message});
    }
});

//it will get all the data of the user
authRouter.get("/",auth,async (req,res)=>{
    const user = await User.findById(req.user);
    res.json({...user._doc,token:req.token});
});

module.exports = authRouter;  //it means that auth router is not a private member it can acess from everywhere in the application
