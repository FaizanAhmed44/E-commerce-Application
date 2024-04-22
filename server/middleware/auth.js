const jwt = require("jsonwebtoken");

const auth = async (req,res,next) => {
   try{
     const token = req.header("x-auth-token");
     if(!token)
       return res.status(401).json({msg:"No auth token,access denied"});
     
       const verified = jwt.verify(token,"passwordKey");
       if(!verified)
         return res.status(401).json({msg:"Token Verification failed, access denied"});

       
       req.user = verified.id;   //we have add .user in req part which gives us verified id in everywhere of the app just by typing req.user
       req.token = token;  //we have add .token in req part which gives us verified token in everywhere of the app just by typing req.token

       next();   //basically it will run the next callback function when we call get req then auth run first if auth is verified and we alse call next then other part of the get api run and id we cant use next function so other part of the get api will not run and stick on auth

   }catch(err){
    res.status(500).json({error:err.message});
   }
}

module.exports = auth;