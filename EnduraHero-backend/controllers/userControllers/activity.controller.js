const AsyncHandler = require("express-async-handler");
const ActivityModel = require("../../models/adminModels/manageActivity.model");
const User = require("../../models/userModels/user.model");
const RewardModel = require("../../models/adminModels/rewards.model");
const ClaimRewardModel = require("../../models/userModels/claimReward.model");
const UserActivityModel = require("../../models/userModels/userActivity.model");


exports.joinActivity = AsyncHandler(async (req, res) => {
  try {
    const activity = await ActivityModel.findOne({ _id: req.body.activityId });
    const user = await User.findOne({ _id: req.body.userId });

    if (!activity) {
      return res.status(404).send({ status: 404, message: 'Activity not found', data: {}, error: true });
    }

    if (!activity.joinedUsers.includes(req.body.userId)) {
      activity.joinedUsers.push(req.body.userId);

      await activity.save();
    }

    if (!user) {
      return res.status(404).send({ status: 404, message: 'User not found', data: {}, error: true });
    }

    // Check if activityId already exists in joinedActivities array
    if (!user.joinedActivities.includes(req.body.activityId)) {
      // If not, push activityId into joinedActivities array
      user.joinedActivities.push(req.body.activityId);

      // Save the updated User back to the database
      await user.save();
    }

    res.status(200).send({ status: 200, message: 'Data Get successfully', data: activity, error: false });
  } catch (err) {
    res.status(500).send({ status: 500, message: 'Internal server error', data: {}, error: true, errShow: err });
  }
});

exports.completeActivity = AsyncHandler(async (req, res) => {
  try {
    const activity = await ActivityModel.findOne({ _id: req.body.activityId });
    const user = await User.findOne({ _id: req.body.userId });

    if (user) {
      if (activity) {
        if (activity.joinedUsers.includes(req.body.userId)) {
          // activity.JoinedUsers.push(req.body.userId);

          await activity.save();

          if (user.joinedActivities.includes(req.body.activityId)) {
            const reward = await RewardModel.findOne({ _id: activity.rewardId });
            console.log('reward:::::::::::', reward);
            if (reward) {
              if (!user.claimRewards.includes(activity.rewardId)) {
                user.claimRewards.push(activity.rewardId);

                await user.save();
                reward.userId = req.body.userId;
                const insertReward = await ClaimRewardModel.insertMany(reward);

                return res.status(200).send({ status: 200, message: 'Complete Activity successfully', data: { CompleteActivity: activity, points: reward.points }, error: false });
              } else {
                return res.status(404).send({ status: 404, message: 'Reward Already Claimed', data: {}, error: true });
              }


            } else {
              return res.status(404).send({ status: 404, message: 'Reward not found', data: {}, error: true });
            }
          } else {
            return res.status(404).send({ status: 404, message: 'User Not Joined Activity', data: {}, error: true });
          }
        } else {
          return res.status(404).send({ status: 404, message: 'User Not Joined Activity', data: {}, error: true });
        }
      } else {
        return res.status(404).send({ status: 404, message: 'Activity not found', data: {}, error: true });
      }
    } else {
      return res.status(404).send({ status: 404, message: 'User not found', data: {}, error: true });
    }

  } catch (err) {
    res.status(500).send({ status: 500, message: 'Internal server error', data: {}, error: true, errShow: err, });
  }
});


exports.AddActivity = AsyncHandler(async (req, res) => {

  try {
    if (req.files) {
      req.body.route = req.files.map((file) => file.filename);
    }

    const duration = parseInt(req.body.duration);
    const distance = parseInt(req.body.distance);

    if (isNaN(duration)) {
      return res.status(400).send({ status: 400, message: 'Invalid Duration value', error: true });
    }

    if (isNaN(distance)) {
      return res.status(400).send({ status: 400, message: 'Invalid Distance value', error: true });
    }

    req.body.duration = duration;
    req.body.distance = distance;

    const user = await User.findOne({ _id: req.body.userId });

    if (!user) {
      return res.status(404).send({ status: 404, message: 'User not found', data: {}, error: true });
    }

    req.body.profileImage = user.profileImage;
    req.body.username = user.username;


    console.log('body::;activity:::', req.body);

    const insertReward = await UserActivityModel.insertMany(req.body);
    res.status(200).send({ status: 200, message: 'Data Add successfully', error: false, errShow: '' });
  } catch (error) {
    console.log('error::::::RewardDetail:::', error);
    res.status(500).send({ status: 500, message: 'Internal server error', error: true, errShow: error });
  }
})



exports.ActivityLikeByUser = AsyncHandler(async (req, res) => {

  try {
    const user = await User.findOne({ _id: req.body.userId });

    if (!user) {
      return res.status(404).send({ status: 404, message: 'User Not Found', error: false, errShow: '' });
    }

    const activity = await UserActivityModel.findOne({ _id: req.body.activityId });
    if (!activity) {
      return res.status(404).send({ status: 404, message: 'Activity Not Found', error: false, errShow: '' });
    }

    var isLiked = JSON.parse(req.body.isLiked);
    var responseMsg = '';

    if (isLiked) {
      activity.likedByUsers.push(req.body.userId);
      responseMsg = 'Activity Liked By User';
    } else {
      const index = activity.likedByUsers.indexOf(req.body.userId);

      if (index !== -1) {
        activity.likedByUsers.splice(index, 1);
        responseMsg = 'Activity DisLiked By User';
      }
    }

    const updatedActivity = await UserActivityModel.findOneAndUpdate({ _id: req.body.activityId }, activity, { new: true });
    var likes = updatedActivity.likedByUsers.length > 0 ? updatedActivity.likedByUsers.length : 0;

    return res.status(200).send({ status: 200, message: responseMsg, data: { likes: likes }, error: false, errShow: '' });
  } catch (error) {
    console.log('error::::::RewardDetail:::', error);
    res.status(500).send({ status: 500, message: 'Internal server error', error: true, errShow: error });
  }
})


exports.ActivityCommentByUser = AsyncHandler(async (req, res) => {

  try {

    const user = await User.findOne({ _id: req.body.userId });

    if (!user) {
      return res.status(404).send({ status: 404, message: 'User Not Found', error: false, errShow: '' });
    }


    const activity = await UserActivityModel.findOne({ _id: req.body.activityId });
    if (!activity) {
      return res.status(404).send({ status: 404, message: 'Activity Not Found', error: false, errShow: '' });
    }

    var commentObject = {
      userId: req.body.userId,
      message: req.body.message
    }

    activity.commentByUsers.push(commentObject);

    const updatedActivity = await UserActivityModel.findOneAndUpdate({ _id: req.body.activityId }, activity, { new: true });
    var comments = updatedActivity.commentByUsers;

    return res.status(200).send({ status: 200, message: 'Comment Add Successfully By User', data: { comments: comments }, error: false, errShow: '' });
  } catch (error) {
    console.log('error::::::RewardDetail:::', error);
    res.status(500).send({ status: 500, message: 'Internal server error', error: true, errShow: error });
  }
})


exports.getAllActivities = AsyncHandler(async (req, res) => {
  try {
    const ActivityList = await UserActivityModel.find({}).sort({ createdAt: -1 });
    res.status(200).send({ status: 200, message: 'Data Get successfully', data: { ActivityList: ActivityList }, error: false, errShow: '' });
  } catch (err) {
    res.status(500).send({ status: 500, message: 'Internal server error', data: {}, error: true, errShow: err });
  }
})

