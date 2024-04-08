const { default: mongoose } = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    username: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
    },
    password: {
      type: String,
      required: true,
    },
    profileImage: {
      type: String,
      default:''
    },
    points: {
      type: Number,
      default:0
    },
    role: {
      type: String,
      default: "user",
    },
    joinedActivities:{
      type: Array,
      default:[]
    },
    claimRewards:{
      type: Array,
      default:[]
    },
    isVerified:{
      type:Boolean,
      default:false
    },
    isDeactivated:{
      type:Boolean,
      default:false
    },
    otp:{
      type:String,
      default:''  
    },
    createdAt:{
      type:Date,default: Date.now()
    },
    loggedAt:{
        type:Date,default: Date.now()
    }
  },
  {
    timestamps: true,
  }
);

const User = mongoose.model("User", userSchema);

module.exports = User;
