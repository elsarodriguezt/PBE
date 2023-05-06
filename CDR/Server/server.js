var http = require('http');
var mysql = require('mysql');
var url = require('url');
var options = require('./options');
var parseQuery = require('./parseQuery');

const host = "localhost";
const port = 3000;

var tables = ['/students', '/timetables', '/tasks', '/marks'];

function requestListener (req, res) {
    	console.log("Starting request from client");
    	var table = url.parse(req.url).pathname;
    	if (!tables.includes(table)) {
		//parseQuery(req, res);
		options.reply(res, 404, "Not Found");
	}
    	else {
        	//options.reply(res, 404, "Not Found");
		parseQuery(req, res);
	}
};

var server = http.createServer(requestListener);
server.listen(port, host, () => {
	console.log(`Server is running on http://${host}:${port}`);
});
