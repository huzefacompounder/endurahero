const { default: mongoose } = require("mongoose");

const activitySchema = new mongoose.Schema(
  {
		timestamp: {
      type: String,
      default:'',
    },
    username: {
      type: String,
      default:'',
    },
		userId: {
      type: String,
      default:'',
    },
    rewardId:{
      type: String,
      default:'',
    },
		activityType: {
      type: String,
      default:'',
    },
    joinedUsers:{
      type: Array,
      default:[],
    },
    distance: {
      type: Number,
      default:0,
    },
		route : {
      type: String,
      default:'',
    },
    duration: {
      type: Number,
      default:0,
    },
    createdAt:{
      type:Date,default: Date.now()
    },
  
  },
 
);

const ActivityModel = mongoose.model("Activities", activitySchema);

module.exports = ActivityModel;
