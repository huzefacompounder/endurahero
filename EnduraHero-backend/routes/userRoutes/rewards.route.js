var express = require('express');
var router = express.Router();

var rewardController = require('../../controllers/userControllers/reward.controller');

// router.get('/getAllRewards', rewardController.getAllRewards);

router.post('/ClaimReward', rewardController.ClaimRewards);

router.post('/myRewards', rewardController.myRewards);

module.exports = router;