var express = require('express');
var router = express.Router();

var activityController = require('../../controllers/userControllers/activity.controller');

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads");
  },
  filename: (req, file, cb) => {
    cb(null, 'route' + + Date.now() + "." + file.originalname.split('.')[1]);
  },
});
const filefilter = (req, file, cb) => {
  if (
    file.mimetype === "image/png" ||
    file.mimetype === "image/jpg" ||
    file.mimetype === "image/jpeg"
  ) {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

const upload = multer({ storage: storage, fileFilter: filefilter});


router.post('/joinActivity', activityController.joinActivity);

router.post('/completeActivity', activityController.completeActivity);

router.post('/AddActivity', upload.array('route', 20), activityController.AddActivity);

router.post('/ActivityLikeByUser', activityController.ActivityLikeByUser);

router.post('/ActivityCommentByUser', activityController.ActivityCommentByUser);

router.get("/getAllActivities", activityController.getAllActivities);

module.exports = router;