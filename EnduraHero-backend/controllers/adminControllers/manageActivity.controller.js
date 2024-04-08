const AsyncHandler = require("express-async-handler");
const ActivityModel = require("../../models/adminModels/manageActivity.model");

 
exports.getAllActivities = AsyncHandler(async (req, res) => {
  try {
      const ActivityList = await ActivityModel.find({}).sort({ createdAt: -1 });
      res.status(200).send({status:200, message: 'Data Get successfully',  data:{ActivityList:ActivityList}, error: false, errShow: '' });
  } catch (err) {
      res.status(500).send({status:500, message: 'Internal server error',  data:{}, error: true, errShow: err});
  }
})

exports.AddActivity = AsyncHandler(async(req, res)=>{
  try {
    
    if (req.file) {
      req.body.route = req.file.filename;
    }
    const duration = parseInt(req.body.duration);
    const distance = parseInt(req.body.distance); 
			
    if (isNaN(duration)) {
        return res.status(400).send({status:400, message: 'Invalid Duration value', error: true });
    }

    if (isNaN(distance)) {
        return res.status(400).send({status:400, message: 'Invalid Distance value', error: true });
    }
    
    req.body.duration = duration;
    req.body.distance = distance;

    const insertReward = await ActivityModel.insertMany(req.body);
    res.status(200).send({status:200, message: 'Data Add successfully',  error: false, errShow: ''});
  } catch (error) {
    console.log('error::::::RewardDetail:::',error); 
    res.status(500).send({status:500, message: 'Internal server error',  error: true, errShow: error});
  } 
})


exports.UpdateActivity = AsyncHandler(async (req, res) => {
  const update = req.body;
  update.updatedAt = new Date();

  const duration = parseInt(update.duration); 
  const distance = parseInt(update.distance); 
			
  if (isNaN(duration)) {
      return res.status(400).send({status:400, message: 'Invalid Duration value', error: true });
  }

  if (isNaN(distance)) {
    return res.status(400).send({status:400, message: 'Invalid Distance value', error: true });
  }
  update.duration =  duration;
  update.distance =  distance;

  try {
    const updatedData = await ActivityModel.findOneAndUpdate({ _id: req.body.activityId }, update, { new: true });
    res.status(200).send({status:200, message: 'Data Update successfully',  data: updatedData, error: false, errShow: ''});
  } catch (err) {
    res.status(500).send({status:500, message: 'Internal server error', data:{}, error: true, errShow: err});
  }
});

exports.DeleteActivity = AsyncHandler(async (req, res) => {
  try {
    const query = await ActivityModel.deleteOne({ _id: req.body.activityId });
    res.status(200).send({status:200, message: 'Data Delete successfully', error: false, errShow: '',   });
  } catch (err) {
    res.status(500).send({status:500, message: 'Internal server error', error: true, errShow: err,   });
  }
})
