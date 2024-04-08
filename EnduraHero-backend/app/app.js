const bodyParser = require("body-parser");
express = require("express");
const morgan = require("morgan");
const cors = require("cors");
jwt = require('jsonwebtoken');
path = require('path');
multer = require("multer");
const {
  globalErrorHandler,
  notFoundError,
} = require("../middlewares/globalErrorHandler");

helper = require("../utils/helpers");

const adminRoutes = require("../routes/adminRoutes/admin.routes");
const userRoutes = require("../routes/userRoutes/user.routes");
const trackRoutes = require("../routes/userRoutes/track.routes");
const imageRoutes = require("../routes/userRoutes/image.routes");
const rewardRoutes = require("../routes/userRoutes/rewards.route");
const manageRewardRoutes = require("../routes/adminRoutes/manageRewards.routes");
const manageUserRoutes = require("../routes/adminRoutes/manageUser.route");
const manageActivityRoutes = require("../routes/adminRoutes/manageActivity.routes");
const activityRoutes = require("../routes/userRoutes/activity.routes");

Url = 'http://192.168.0.108:3500';

const app = express();
const corsOption = {
  origin: "*",
};

app.use(morgan("dev"));
app.use(cors(corsOption));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use("/api/v1/uploads", express.static("uploads"));


// app.use(express.static(__dirname + '../uploads'));

app.use("/api/v1/admin/", adminRoutes);
app.use("/api/v1/user/", userRoutes);
app.use("/api/v1/track/", trackRoutes);
app.use("/api/v1/upload/", imageRoutes);
app.use("/api/v1/reward/", rewardRoutes);
app.use("/api/v1/manageReward/", manageRewardRoutes);
app.use("/api/v1/manageUser/", manageUserRoutes);
app.use("/api/v1/manageActivity/", manageActivityRoutes);
app.use("/api/v1/activity/", activityRoutes);

//Not Found Error
app.use(notFoundError);
//Global Error Handler
app.use(globalErrorHandler);
module.exports = app;
