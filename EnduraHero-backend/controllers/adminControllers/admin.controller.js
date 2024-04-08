const AsyncHandler = require("express-async-handler");
const Admin = require("../../models/adminModels/admin.model");
const {
  hashPassword,
  isPasswordMatched,
  generateToken,
} = require("../../utils/helpers");

const adminController = {
 
  registerAdmin: AsyncHandler(async (req, res) => {
    const { username, email, password } = req.body;
    const adminFound = await Admin.findOne({ email });

    if (adminFound) {
      return res.status(401).send({status: 401, message: "Admin already exists", data:{} });
    }

    const adminCreated = await Admin.create({
      username,
      email,
      password: await hashPassword(password),
      createdAt: new Date()
    });

    return res.status(200).send({
      status: 200,
      message: "Admin registered",
      data: {
        token: generateToken(adminCreated._id),
        userId:adminCreated._id,
        username: adminCreated.username,
        email: adminCreated.email,
      },
    });
  }),
  /* 
        Desc: Admin Login
        Api: POST api/v1/admin/login
        Params: Email,Password
  */
  login: AsyncHandler(async (req, res) => {
    const { emailOrUsername, password } = req.body;
    const adminFound = await Admin.findOne({
      $or: [{ email: emailOrUsername }, { username: emailOrUsername }],
    });

    if (!adminFound) {
      return res.status(404).send({status: 404, message: "Admin Not Found", data:{} });
    }
    adminFound.loggedAt = new Date();
    await adminFound.save();

    if (!(await isPasswordMatched(password, adminFound.password))) {
      return res.status(401).send({
        status: 401,
        message: "Invalid Password",
      });
    }
    return res.status(200).send({
      status: 200,
      message: "Logged in successfully",
      data: {
        token: generateToken(adminFound._id),
        username: adminFound.username,
        userId: adminFound._id,
        email: adminFound.email,

      },
    });
  }),
};

module.exports = adminController;
