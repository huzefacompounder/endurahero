const AsyncHandler = require("express-async-handler");
// const RewardModel = require('../../models/adminModels/rewards.model');
const User = require("../../models/userModels/user.model");

// exports.getAllRewards = AsyncHandler(async(req, res)=>{
// 		try {
// 			const RewardList = await RewardModel.find({});
// 			res.status(200).json({ Rewards:RewardList, error: false, errShow: '',  message: 'Data Get successfully' });
// 		} catch (error) {
// 			console.log('error::::::RewardDetail:::',error); 
// 			res.status(500).json({ Rewards:[], error: true, errShow: error,  message: 'Internal server error' });

// 		}
// })

exports.ClaimRewards = AsyncHandler(async(req, res) => {
	try {
			const userId = req.body.userId;
			const additionalPoints = parseInt(req.body.points); 
			
			if (isNaN(additionalPoints)) {
					return res.status(400).send({status:400, message: 'Invalid points value', data:{}, error: true });
			}
			
			const user = await User.findById(userId);
			
			if (!user) {
					return res.status(404).send({status:404, message: 'User not found', data:{}, error: true});
			}
			
			user.points =  additionalPoints; 
			
			await user.save();
			
			return res.status(200).send({status:200, message: 'Points updated successfully', data:{points: user.points}, error: false, errShow: ''});
	} catch (error) {
			console.log('error::::::RewardDetail:::', error); 
			return res.status(500).send({status:500, message: 'Internal server error', data:{}, error: true, errShow: error });
	}
})

exports.myRewards = AsyncHandler(async(req, res) => {
	try {
			const userId = req.body.userId;
			
			const user = await User.findById(userId);
			
			if (!user) {
					return res.status(404).send({status:404, message: 'User not found', data:{}, error: true});
			}
			
			
			await user.save();
			
			res.status(200).send({status:200, message: 'My Rewards Get successfully', data:{points: user.points}, error: false, errShow: ''});
	} catch (error) {
			console.log('error::::::RewardDetail:::', error); 
			res.status(500).send({status:500, message: 'Internal server error', data:{}, error: true, errShow: error });
	}
})
