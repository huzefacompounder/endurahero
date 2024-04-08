const express = require("express");
const adminController = require("../../controllers/adminControllers/admin.controller");

const adminRoutes = express.Router();

adminRoutes.post("/register", adminController.registerAdmin);
adminRoutes.post("/login", adminController.login);

module.exports = adminRoutes;
