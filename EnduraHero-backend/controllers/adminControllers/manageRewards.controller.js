const AsyncHandler = require("express-async-handler");
const RewardModel = require('../../models/adminModels/rewards.model');


exports.getAllRewards = AsyncHandler(async (req, res) => {
    try {
        const rewardList = await RewardModel.find({});
        res.status(200).send({status:200, message: 'Data Get successfully',  data:{rewardList:rewardList}, error: false, errShow: '' });
    } catch (err) {
        res.status(500).send({status:500, message: 'Internal server error',  data:{}, error: true, errShow: err });
    }
})

exports.AddRewardDetail = AsyncHandler(async(req, res)=>{
		try {
			const insertReward = await RewardModel.insertMany(req.body);
			console.log('insertReward::::::',insertReward);
			res.status(200).send({status:200, message: 'Data Add successfully', data:insertReward[0], error: false, errShow: '' });
		} catch (error) {
			console.log('error::::::RewardDetail:::',error); 
			res.status(500).send({status:500, message: 'Internal server error', data:{}, error: true, errShow: error });
		}
})


exports.UpdateReward = AsyncHandler(async (req, res) => {
	const update = req.body;
	update.updatedAt = new Date();
	try {
		const updatedRewardData = await RewardModel.findOneAndUpdate({ _id: req.body.rewardId }, update, { new: true });
		res.status(200).send({status:200, message: 'Data Update successfully', data:updatedRewardData, error: false, errShow: '' });
	} catch (err) {
		res.status(500).send({status:500, message: 'Internal server error', data:{}, error: true, errShow: err });
	}
})

exports.DeleteReward = AsyncHandler(async (req, res) => {
	try {
		const query = await RewardModel.deleteOne({ _id: req.body.rewardId });
		res.status(200).send({status:200, message: 'Data Delete successfully', data:{}, error: false, errShow: '' });
	} catch (err) {
		res.status(500).send({status:500, message: 'Internal server error', data:{}, error: true, errShow: err });
	}
})