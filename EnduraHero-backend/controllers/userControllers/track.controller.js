const AsyncHandler = require("express-async-handler");
TrackModel = require("../../models/userModels/track.model");


	exports.AddTrackActivity = AsyncHandler(async (req, res) => {
		try {
			const insertActivity= await TrackModel.insertMany(req.body);
			res.status(200).send({status:200, message: 'Activity Add successfully', data:insertActivity[0], error: false, errShow: ''});
		} catch (err) {
			res.status(500).send({status:500, message: 'Internal server error', data:{}, error: true, errShow: err});
		}
  }),

	
	exports.GetUserAllActivity = AsyncHandler(async (req, res) => {
		try {
			const Activity = await TrackModel.find({ userId: req.body.userId }).sort({ createdAt: -1 });
			res.status(200).send({status:200, message: 'Data Get successfully', data:{Activity:Activity}, error: false, errShow: ''});
		} catch (err) {
			res.status(500).send({status:500, message: 'Internal server error', data:{}, error: true, errShow: err});
		}
	}),

	exports.GetSingleActivity = AsyncHandler(async (req, res) => {
		try {
			const Activity = await TrackModel.findOne({ _id: req.body.activityId });
			if(Activity){
				res.status(200).send({status:200, message: 'Data Get successfully', data:{Activity:Activity}, error: false, errShow: ''});
			}else{
				res.status(404).send({status:404, message: 'Activity Not Found', data:{}, error: false, errShow: ''});
			}
			
		} catch (err) {
			res.status(500).send({status:500, message: 'Internal server error', data:{}, error: true, errShow: err});
		}
	}),
	
	exports.DeleteActivity = AsyncHandler(async (req, res) => {
		try {
			const query = await TrackModel.deleteOne({ _id: req.body.activityId });
			if(Activity){
				res.status(200).send({status:200, message: 'Activity delete successfully', data:{}, error: false, errShow: ''});
			}else{
				res.status(404).send({status:404, message: 'Activity Not Found', data:{}, error: false, errShow: ''});
			}
			
		} catch (err) {
			res.status(500).send({status:500, message: 'Internal server error', data:{}, error: true, errShow: err});
		}
	})
  