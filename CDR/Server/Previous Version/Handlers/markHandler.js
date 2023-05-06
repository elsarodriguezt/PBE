var url = require('url');
var options = require('./options.js');
 
var handler = (req, res) => {
	var params = new URLSearchParams(url.parse(req.url).query);
	var id = params.get('uid');
//comprovar uid
	sql = "SELECT * FROM marks WHERE uid = '" + id + "'";
	params.delete('uid');
	if (params[0] == '[lt]')
		params[0] = params[0].replace('[lt]', '<');
	else if (params[0] == '[gt]')
		params[0] = params[0].replace('[gt]', '>');
	sql = sql + " AND " + params[0] + "='" + params[1] + "' ORDER BY 'subject'";
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
