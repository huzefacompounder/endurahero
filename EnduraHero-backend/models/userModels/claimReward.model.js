const {default: mongoose} = require("mongoose");

const rewardSchema = new mongoose.Schema(
    {
			userId:{
				type:String,
				default:'',
			},
			rewardName:{
				type:String,
				default:'',
			},
			description:{
				type:String,	
				default:'',
			},
			points:{
				type:Number,	
				default:0,
			}
		}
);

const ClaimRewardModel = mongoose.model("claimRewards", rewardSchema);

module.exports = ClaimRewardModel;