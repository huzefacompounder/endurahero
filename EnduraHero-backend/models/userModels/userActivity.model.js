const { default: mongoose } = require("mongoose");

const activitySchema = new mongoose.Schema(
  {
    timestamp: {
      type: String,
      default: '',
    },
    username: {
      type: String,
      default: '',
    },
    profileImage: {
      type: String,
      default: '',
    },
    userId: {
      type: String,
      default: '',
    },
    rewardId: {
      type: String,
      default: '',
    },
    activityType: {
      type: String,
      default: '',
    },
    joinedUsers: {
      type: Array,
      default: [],
    },
    likedByUsers: {
      type: Array,
      default: [],
    },
    commentByUsers: {
      type: Array,
      default: [],
    },
    distance: {
      type: Number,
      default: 0,
    },
    route: {
      type: Array,
      default: [],
    },
    duration: {
      type: Number,
      default: 0,
    },
    description: {
      type: String,
      default: '',
    },

    createdAt: {
      type: Date, default: Date.now()
    },

  },

);

const UserActivityModel = mongoose.model("userActivities", activitySchema);

module.exports = UserActivityModel;
