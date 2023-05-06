var url = require('url');
var options = require('./options.js');

var handler = (req, res) => {
	var params = new URLSearchParams(url.parse(req.url).query);
	var id = params.get('uid');
	sql = "SELECT * FROM students WHERE uid = '" + id + "'";
	options.connectDB(sql, (err, result) => {
		if (Object.keys(result).length == 0)
			options.reply(res, 404, "Not Found");
			
		else
			options.reply(res, 200, JSON.stringify(result));
	});
}; 

module.exports = (req, res) => {
	if (req.method == 'GET')
		handler(req, res);
	else
        options.reply(res, 404, "Not Found");
};
