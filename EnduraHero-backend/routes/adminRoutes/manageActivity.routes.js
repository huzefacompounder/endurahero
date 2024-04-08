const express = require("express");
const activityController = require("../../controllers/adminControllers/manageActivity.controller");
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

const router = express.Router();

router.get("/getAllActivities", activityController.getAllActivities);

router.post('/AddActivity', upload.single('route'), activityController.AddActivity);

router.post('/UpdateActivity', activityController.UpdateActivity);

router.post('/DeleteActivity', activityController.DeleteActivity); 

// router.post("/login", activityController.login);

module.exports = router;
