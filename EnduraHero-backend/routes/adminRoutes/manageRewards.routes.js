const express = require("express");
const manageController = require("../../controllers/adminControllers/manageRewards.controller");

const router = express.Router();

router.get("/getAllRewards", manageController.getAllRewards);

router.post('/AddRewardDetail', manageController.AddRewardDetail);

router.post('/UpdateReward', manageController.UpdateReward);

router.post('/DeleteReward', manageController.DeleteReward); 


module.exports = router;
