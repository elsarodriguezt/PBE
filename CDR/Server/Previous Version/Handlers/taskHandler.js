var url = require('url');
var options = require('./options.js');

var handler = (req, res) => {
	var params = new URLSearchParams(url.parse(req.url).query);
	var id = params.get('uid');
	sql = "SELECT * FROM tasks WHERE uid = '" + id + "'";
	params.delete('uid');
    var limit = null;
    if (params.has('limit')) {
		limit = params.get('limit');
		params.delete('limit');
	} 
    let now = Date.now();
    let date = new Date(now);
    var dateNow = date.getFullYear()+ '-' + (date.getMonth()+1) + '-' + date.getDate();
   
    if (params[0] == '[lt]')
		params[0] = params[0].replace('[lt]', '<');
	else if (params[0] == '[gt]')
		params[0] = params[0].replace('[gt]', '>');
	else if (params[0] == '[gte]')
		params[0] = params[0].replace('[gte]', '>');
	if (params[1] == 'now')
		params[1] = params[1].replace('now', dateNow);	
  
	sql = sql + " AND " + params[0] + "='" + params[1] + "'" + " ORDER BY 'date'";
	if  (limit)
		sql = sql + " LIMIT " + limit;
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
