const express = require("express");
const manageUserController = require("../../controllers/adminControllers/manageUsers.controller");

const router = express.Router();

router.post("/UserStatus", manageUserController.UserStatus);

router.post('/DeleteUser', manageUserController.DeleteUser);

router.get('/getUserList', manageUserController.getUserList);

module.exports = router;
