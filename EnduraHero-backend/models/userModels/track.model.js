const { default: mongoose } = require("mongoose");

const trackSchema = new mongoose.Schema(
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
		activityType: {
      type: String,
      default:'',
    },
    distance: {
      type: String,
      default:'',
    },
		route : {
      type: String,
      default:'',
    },
    duration: {
      type: String,
      default:'',
    },
    createdAt:{
      type:Date,default: Date.now()
    },
  
  },
 
);

const TrackModel = mongoose.model("TrackActivities", trackSchema);

module.exports = TrackModel;
