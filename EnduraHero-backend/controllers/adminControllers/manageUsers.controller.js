const AsyncHandler = require("express-async-handler");
const User = require("../../models/userModels/user.model");


exports.getUserList = AsyncHandler(async (req, res) => {
	try {
		const Users = await User.find({isVerified: true}).sort({ createdAt: -1 });
		console.log('users::::::::::::::::::::::::::::::::',Users);
		res.status(200).send({status:200, message: 'Data Get successfully',  data:Users, error: false, errShow: ''});
	} catch (err) {
		res.status(500).send({status:500, message: 'Internal server error', data:[], error: true, errShow: err});
	}
})

exports.UserStatus = AsyncHandler(async (req, res) => {
	console.log('req.body:::::',req.body);
	req.body.updatedAt = new Date();
	try {
		const Status = await User.updateOne( { _id: req.body.userId },{$set: { isDeactivated: JSON.parse(req.body.status) }});
		res.status(200).send({ status:200, message:'User Status Updated successfully', data:{status: JSON.parse(req.body.status)}, error: false, errShow: ''});
	} catch (err) {
		res.status(500).send({ status:500, message: 'Internal server error', data:{}, error: true, errShow: err});
	}
})

exports.DeleteUser = AsyncHandler(async (req, res) => {
	try {
		const query = await User.deleteOne({ _id: req.body.userId });
		res.status(200).send({ status:200, message: 'Data Delete successfully', data:{}, error: false, errShow: ''});
	} catch (err) {
		res.status(500).send({ status:500, message: 'Internal server error', data:{}, error: true, errShow: err});
	}
})
  

