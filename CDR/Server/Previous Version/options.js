var mysql = require('mysql');

function connectDB (sql, callback) {
	var database = mysql.createConnection({
		host: "localhost",
		user: "pbe",
		password: "password",
		database: "db"
	});
	database.query(sql, function(err, result) {
		if (err)
			return callback(err, null);
		else 
			return callback(null, result);
	});
	database.end();
};

function reply (res, stat, data) {
	res.writeHead(stat, {"Content-Type": "text/plain"});
    res.write(data);
    res.end();
}

function compareTime (h) {
	let naw = Date.now();
    let dateNow = new Date(now);
    var date = new Date(dateNow.toDateString() + " " + h);
    if(date.getTime() < dateNow.getTime())
		return true;
	return false;
}

function dayName (d) {
	var week = {1: "Mon", 2: "Tue", 3: "Wed", 4: "Thu", 5: "Fri"};
	return week[d];
}

function dayNumb (d) {
	var week = {"Mon": 1, "Tue": 2, "Wed": 3, "Thu": 4, "Fri": 5};
	return week[d];
}

exports.connectDB = connectDB;
exports.reply = reply;
exports.compareTime = compareTime;
exports.dayName = dayName;
exports.dayNumb = dayNumb;
