var http = require('http');
var mysql = require('mysql');
var url = require('url');
var options = require('./options');
var studentHandler = require('./studentHandler');
var timetableHandler = require('./timetableHandler');
var taskHandler = require('./taskHandler');
var markHandler = require('./markHandler');

const host = "localhost";
const port = 3000;

var routes = {"/students": studentHandler, "/timetables": timetableHandler, "/tasks": taskHandler, "/marks": markHandler};

function requestListener (req, res) {
    console.log("Starting request from client");
    var route = routes[url.parse(req.url).pathname];
    if (route) {
        route(req, res);
    }
    else {
        options.reply(res, 404, "Not Found");
    }
};

var server = http.createServer(requestListener);
server.listen(port, host, () => {
    console.log(`Server is running on http://${host}:${port}`);
});
