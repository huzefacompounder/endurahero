const express = require("express");
const multer = require("multer");
const userController = require("../../controllers/userControllers/user.controller");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads");
  },
  filename: (req, file, cb) => {
    cb(null, 'image' + + Date.now() + "." + file.originalname.split('.')[1]);
  },
});
const filefilter = (req, file, cb) => {
  if (
    file.mimetype === "image/png" ||
    file.mimetype === "image/jpg" ||
    file.mimetype === "image/jpeg"
  ) {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

const upload = multer({ storage: storage, fileFilter: filefilter});

const userRoutes = express.Router();

userRoutes.post("/register", userController.registerUser);
userRoutes.post("/login", userController.loginUser);
userRoutes.post('/verify-otp', userController.verifyOTP);
// userRoutes.get('/getAllUsers', userController.getAllUsers);

userRoutes.post('/getUserProfile', userController.getUserProfile);
userRoutes.post('/userProfileUpdate',upload.single('profileImage'), userController.userProfileUpdate);


module.exports = userRoutes;
