const bcrypt = require("bcryptjs");
const fs = require("fs");
const jwt = require("jsonwebtoken");
//hash password

exports.generateToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SEC, { expiresIn: "5d" });
};

exports.verifyToken = (token) => {
  return jwt.verify(token, process.env.JWT_SEC, (err, decoded) => {
    if (err) {
      return false;
    } else {
      return decoded;
    }
  });
};

exports.hashPassword = async (password) => {
  const salt = await bcrypt.genSalt(10);
  const hash = await bcrypt.hash(password, salt);
  return hash;
};

exports.isPasswordMatched = async (password, hashPassword) => {
  return bcrypt.compare(password, hashPassword);
};

exports.fileSizeFormatter = (bytes, decimal) => {
  if (bytes === 0) {
    return "0 Bytes";
  }
  const dm = decimal || 2;
  const sizes = ["Bytes", "KB", "MB", "GB", "TB", "PB", "EB", "YB", "ZB"];
  const index = Math.floor(Math.log(bytes) / Math.log(1000));
  return (
    parseFloat((bytes / Math.pow(1000, index)).toFixed(dm)) + " " + sizes[index]
  );
};

exports.deleteUploadedImage = (path) => {
  fs.unlink(path, (err) => {
    if (err) {
      const err = new Error("File cannot deleted");
      err.statusCode = 200;
      throw err;
    } 
  });
};

exports.DeleteImage = (req, res) =>{
	const filename = req.body.deleteImageName;
	const uploadFolder = 'uploads';
	const filePath = path.join(uploadFolder, filename);

	// Check if the file exists
	if (fs.existsSync(filePath)) {
		// Delete the file
		fs.unlinkSync(filePath);
		return res.status(200).send({error:false, message: 'Image deleted successfully' });
	} else {
		return res.status(404).send({error:true, message: 'Image not found' });
	}
};  
exports.uploadImage = (req, res) => {
  
  if(typeof req.file != 'undefined'){
    const fileUrl = Url + '/' + req.file.filename;
    return res.status(200).send({ error: false, urls: fileUrl });
  }else{
    return res.status(404).send({error:true, message: "Image Not found"});
  }

};