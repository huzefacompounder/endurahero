const AsyncHandler = require("express-async-handler");
const User = require("../../models/userModels/user.model");
const {
  hashPassword,
  isPasswordMatched,
  generateToken,
} = require("../../utils/helpers");
const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
      user: 'endurahero@gmail.com', // Your email address
      pass: 'pphq typu vmqe cvvc'
  }
});

const sendOTPEmail = (email, OTP) => {
  console.log("email::::::::::::::::::OTP<>>>>>:::::::::::::",email, OTP);
  transporter.sendMail({
    from: 'endurahero@gmail.com',
    to: email,
    subject: 'OTP Verification',
    text: `Your OTP is: ${OTP}`,
  });
};

const userController = {  
  
  registerUser: AsyncHandler(async (req, res) => {
    const { username, email, password} = req.body;

    const UnverifiedData = await User.deleteMany({ isVerified: false });
    const userFound = await User.findOne({ email });
    if (userFound) {
      return res.status(401).send({status: 401, message: "User Alredy Exists", data:{} });
    }
    

    const OTP = Math.floor(1000 + Math.random() * 9000);
    const jwtSecret = process.env.JWT_SEC;

    if (!jwtSecret) {
      return res.status(401).send({status: 401, message: "JWT secret key is not defined", data:{} });
    }

    const token = jwt.sign({ email, OTP }, jwtSecret, { expiresIn: '1h' });

    sendOTPEmail(email, OTP);

    const userCreated = await User.create({
      username,
      email,
      password: await hashPassword(password),
      createdAt: new Date()
    });

    
    const query = await User.updateOne({ _id: userCreated._id }, { $set: { otp: OTP } });

    res.status(200).send({
      status: 200,
      message: "OTP sent to email. Please verify.",
      data: {
        token: token,
        userId:userCreated._id,
        username: userCreated.username,
        email: userCreated.email,
      },
    });
  }),

  verifyOTP: AsyncHandler(async (req, res) => {
    try {
      const { email, otp } = req.body;

      const userFound = await User.findOne({ email });

      if(otp != undefined && otp != '' && otp != null){

        const isRightCode = await User.findOne({ email: email, otp: otp });
        if(isRightCode){

          const query = await User.updateOne( { _id: userFound._id },{$set: { isVerified: true },$unset: { otp: 1 }});
          const jwtSecret = process.env.JWT_SEC;
      
          if (!jwtSecret) {
            return res.status(401).send({status: 401, message: "JWT secret key is not defined", data:{}});
          }

          const token = jwt.sign({ userId: userFound._id }, jwtSecret);
          return res.status(200).send({
            status: 200,
            message: "User Registerd Successfully",
            data: {
              token: token,
              username: userFound.username,
              email: userFound.email,
            },
          });
        }else{
          return res.status(401).send({status: 401, message: "Invalid OTP and Email", data:{}});
        }

      }else{
        return res.status(401).send({status: 401, message: "Please Enter OTP", data:{}});
      }

    } catch (error) {
      res.status(500).send({
        status: 500,
        message: error.message,
      });
    }
  }),
  
  loginUser: AsyncHandler(async (req, res) => {
    const { emailOrUsername, password } = req.body;

    const userFound = await User.findOne({
      $or: [{ email: emailOrUsername }, { username: emailOrUsername }],
    });
    
    const userExists = await User.findOne({ emailOrUsername });

    if (!userFound) {
      return res.status(401).send({status: 401, message: "Invalid email or username and password", data:{}});
    }

    if (userFound.isDeactivated) {
      return res.status(401).send({ status: 401, message: "User account is deactivated", data: {} });
    }

    if (!(await isPasswordMatched(password, userFound.password))) {
      return res.status(401).send({status: 401, message: "Invalid email or username and password", data:{}});
    }
    userFound.loggedAt = new Date();
    await userFound.save();
    
    return res.status(200).send({
      status: 200,
      message: "User Logged in Successfully",
      data: {
        token: generateToken(userFound._id),
        username: userFound.username,
        userId: userFound._id,
        email: userFound.email,
      },
    });
  }),

  // getAllUsers: AsyncHandler(async (req, res) => {
	// 	console.log('req.params:::::::::::::',req.params);
	// 	try {
	// 		const userProfileData = await User.find({});
	// 		res.status(200).send({status:200, message: 'Data Get successfully', data:{userProfileData:userProfileData}, error: false, errShow: ''});
	// 	} catch (err) {
	// 		res.status(500).json({ error: err,  message: 'Internal server error' });
	// 	}
	// }),

  getUserProfile: AsyncHandler(async (req, res) => {
		try {
			// const userProfileData = await User.find({ _id: req.params.id });
      const userProfileData = await User.findOne({ _id: req.body.userId });
      if(userProfileData){
        res.status(200).send({ status:200, message: 'Profile Get successfully', data:userProfileData, error:false });
      }else{
        res.status(404).send({ status:404, message: 'User Not Found', data:{}, error:false });
      }
			
		} catch (err) {
			res.status(500).send({ status:500, message: 'Internal server error', data:{}, error:true, errorShow: err});
		}
	}),

  userProfileUpdate: AsyncHandler(async (req, res) => {
    const update = req.body;
    // const userId = req.params.id;
    const userId = req.body.userId;
    update.updatedAt = new Date();

    if (req.file) {
      update.profileImage = req.file.filename;
    }
    try {
      const updatedProfileData = await User.findOneAndUpdate({ _id: userId }, update, { new: true });
      res.status(200).send({ status:200, message: 'Profile Update successfully', data:{}, error:false });
    } catch (err) {
      res.status(500).send({ status:500, message: 'Internal server error', data:{}, error:true, errorShow: err});
    }
  }),
};

module.exports = userController;
