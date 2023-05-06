var url = require('url');
var options = require('./options.js');
 
var handler = (req, res) => { 
    var params = new URLSearchParams(url.parse(req.url).query);
    var id = params.get('uid');
    sql = "SELECT * FROM timetables WHERE uid = '" + id + "'";
    params.delete('uid'); 
    
    var limit = null;
    if (params.has('limit')) {
		limit = params.get('limit');
		params.delete('limit');
	}
	
    let now = Date.now();
    let date = new Date(now);
    var day = null, hour = null;
    
    if (params.has('day') == false)
    	day = date.getDay();
    if (params.has('hour') == false)
		hour = date.getUTCHours()+1+":00:00";
    if (params[0] == '[lt]')
		params[0] = params[0].replace('[lt]', '<');
    else if (params[0] == '[gt]')
        params[0] = params[0].replace('[gt]', '>');
    else if (params[0] = '[gte]')
        params[0] = params[0].replace('[gte]','>');
    if (params[0] == 'day')
		params[1] = options.dayNumb(params[1]);
 
    sql = sql + " AND " + params[0] + "='" + params[1] + "'";
	if (day)
		sql = sql + " AND " + params[0] + "='" + params[1] + "'";
	sql = sql + " ORDER BY 'day' , 'hour'";
	
    options.connectDB(sql, (err,result) => {
        if (res != null) {
            var i = 0;
            while (i < result.length){
                if (options.compareTime(result[i].hour) && day!=null && date.getDay()==result[i].day)
                    result.splice(i, 1);
                else 
		    i++;
            }
            i = 0;
            while (i < result.length){
                result[i].day = options.dayName(result[i].day);
                i++;
            }
            if (limit != null) {
				while (result.length > limit)
					result.pop();
			}
        }
        options.connectDB(sql, (err, result) => {
            if (Object.keys(result).length == 0) 
                options.reply(res, 404, "Not Found");
			else
                options.reply(res, 200, JSON.stringify(result));
        });
    });
};
 
module.exports = (req, res) => {
	if (req.method == 'GET')
		handler(req, res);
	else
        options.reply(res, 404, "Not Found");
};
