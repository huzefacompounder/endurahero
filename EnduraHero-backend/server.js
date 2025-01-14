require("dotenv").config();
require("./config/dbConfig");

const http = require("http");
const app = require("./app/app");
const PORT = process.env.PORT || 2020;


const server = http.createServer(app);
server.listen(PORT, console.log(`Server is Running on ${PORT}`));
