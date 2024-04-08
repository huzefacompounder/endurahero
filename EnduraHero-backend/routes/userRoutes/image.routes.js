const express = require("express");
const upload = require("../../middlewares/fileUpload");
const helper = require("../../utils/helpers");


const router = express.Router();


router.post('/uploadImage', upload.upload.single('image') , helper.uploadImage);

router.post('/DeleteImage',helper.DeleteImage);



module.exports = router;
