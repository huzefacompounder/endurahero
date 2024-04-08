const express = require("express");
const trackController = require("../../controllers/userControllers/track.controller");


const router = express.Router();

// router.get("/TrackLocation", trackController.TrackLocation);

router.post('/AddTrackActivity', trackController.AddTrackActivity); 

// router.get('/GetAllActivities', trackController.GetAllActivities); 

router.post('/GetUserAllActivity', trackController.GetUserAllActivity); 

router.post('/GetSingleActivity', trackController.GetSingleActivity); 

router.post('/DeleteActivity', trackController.DeleteActivity); 




module.exports = router;
