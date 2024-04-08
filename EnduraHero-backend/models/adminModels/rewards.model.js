const {default: mongoose} = require("mongoose");

const rewardSchema = new mongoose.Schema(
    {
			rewardName:{
				type:String,
				required:true
			},
			description:{
				type:String,	
				required:true
			},
			points:{
				type:Number,	
				required:true
			}
		}
);

const RewardModel = mongoose.model("rewards", rewardSchema);

module.exports = RewardModel;