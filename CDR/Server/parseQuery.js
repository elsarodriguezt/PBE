var url = require('url');
var options = require('./options.js');

var parseQuery = (req, res) => {
	var route = url.parse(req.url);
	var table = route.pathname.replace('/','');
	var pairs = new URLSearchParams(route.query);
	var uid = pairs.get('uid');
	var sql = "SELECT * FROM " + table + " WHERE uid = '" + uid + "'";
	pairs.delete('uid');

	const date = new Date(Date.now());
    	const now = date.getFullYear()+ '-' + (date.getMonth()+1) + '-' + date.getDate();

	var limit = null;
    	if (pairs.has('limit')) {
		limit = pairs.get('limit');
		pairs.delete('limit');
	}

	var order = null;
	if (table == 'marks') order = 'subject';
	else if (table == 'tasks') order = 'date';
	else if (table == 'timetables') order = 'hour';

	for (var pair of pairs) {
		pair[0] = pair[0].replace('[gt]','>');
            	pair[0] = pair[0].replace('[lt]','<');
           	pair[0] = pair[0].replace('[gte]','>=');
		pair[0] = pair[0].replace('[lte]','<='); 
            	pair[1] = pair[1].replace('now', '=' + now);
		if (pair[0] == 'day') pair[1] = options.dayNumb(pair[1]);
		if (typeof pair[0] =='string') pair[0] = pair[0] + " = ";

        	sql = sql + " AND " + pair[0] + " '" + pair[1] + "'";
	}

	if (order) sql = sql + " ORDER BY " + order;
	if (limit) sql = sql + " LIMIT " + limit;
	
	options.connectDB(sql, (err, result) => {
		if (Object.keys(result).length == 0 || result==null)
			options.reply(err, 404, "Not Found");
		else
			options.reply(res, 200, JSON.stringify(result));
	});
};

module.exports = (req, res) => {
	if (req.method == 'GET')
		parseQuery(req, res);
	else
        options.reply(res, 404, "Not Found");
};
