component accessors=true singleton=true {

	property name="formatterService" inject="formatterService";

	function getCurrentBrowserLocation () {

		var link = 'http://';
		if (cgi.server_port == "443") {
			link = 'https://';
		}
		link &= cgi.http_host & cgi.path_info;

		if (len(cgi.query_string)) {
			link &= '?' & cgi.query_string;
		}

		return link;
	}

	function getRemoteIP () {
		var x = cgi["X-Forwarded-For"];
		if (x.len()) return x;
		return cgi.remote_addr;
	}

	function formatter () {
		return formatterService;
	}

	function randomizeArray (required array input) {
		CreateObject("java","java.util.Collections").Shuffle(input);
		return input;
	}

	function getTopN (required array input, required numeric length) {
		if (input.len() == 0) return input;
		return input.slice(1, min(length, input.len()));
	}


	string function toJSON (required array data) {
		var output = data.reduce(function(sb, obj, index) {
			if (index > 1) sb.append(",");
			if (isJSON(obj)) {
				return sb.append(obj);
			} else if (isStruct(obj) && structKeyExists(obj, "toJSON")) {
				return sb.append(obj.toJSON());
			} else {
				return sb.append(serializeJSON(obj));
			}
		}, createObject("java", "java.lang.StringBuffer").init("["));

		return output.append("]").toString();
	}

	string function toJSONSimple (required array data) {
		var output = data.reduce(function(sb, obj, index) {
			if (index > 1) sb.append(",");
			return sb.append(obj.toJSONSimple());
		}, createObject("java", "java.lang.StringBuffer").init("["));

		return output.append("]").toString();
	}

	string function toJSONBasic (required array data) {
		var output = data.reduce(function(sb, obj, index) {
			if (index > 1) sb.append(",");
			if (isJSON(obj)) {
				return sb.append(obj);
			} else if (isStruct(obj) && structKeyExists(obj, "toJSONBasic")) {
				return sb.append(obj.toJSONBasic());
			} else if (isStruct(obj) && structKeyExists(obj, "toJSONSimple")) {
				return sb.append(obj.toJSONSimple());
			} else if (isStruct(obj) && structKeyExists(obj, "toJSON")) {
				return sb.append(obj.toJSON());
			} else {
				return sb.append(serializeJSON(obj));
			}
		}, createObject("java", "java.lang.StringBuffer").init("["));

		return output.append("]").toString();
	}

	function toStruct(required array collection) {
		return map(function(o) {
			return o.toStruct();
		}, collection);
	}

	function map (required any f, array data) {
		if (isNull(data)) {
			return function (data) {
				return arrayMap(data, f);
			};
		}
		return arrayMap(data, f);
	}

	function pickGet (required string methodName, required array data) {
		var f = function(item) {
			return item["get" & methodName]();
		};
		return map(f, data);
	}

	function hexToRGB (required string hexColor) {
		if (len(trim(hexColor)) != 6) {
			hexColor = "FFFFFF";
		}

		return {
			red: inputBaseN(mid(hexColor, 1, 2), 16),
			green: inputBaseN(mid(hexColor, 3, 2), 16),
			blue: inputBaseN(mid(hexColor, 5, 2), 16)
		};
	}

	function getTextColorForBackgroundColor (required struct rgbBackgroundColor) {
		//Y = 0.2126 * (R/255)^2.2  +  0.7151 * (G/255)^2.2  +  0.0721 * (B/255)^2.2
		var y = 0.2126 * (rgbBackgroundColor.red/255)^2.2  +  0.7151 * (rgbBackgroundColor.green/255)^2.2  +  0.0721 * (rgbBackgroundColor.blue/255)^2.2
		if (y <= 0.18) {
			return "##ffffff";
		}
		return "##000000";
	}

	public date function gmt () {
		return dateConvert("local2UTC", now());
	}

	public date function utc () {
		return gmt();
	}

	public date function unixTimeMS () {
		return createObject("java", "java.lang.System").currentTimeMillis();
	}

	public date function unixTime () {
		return int(createObject("java", "java.lang.System").currentTimeMillis() / 1000);
	}

	public numeric function toUnixTime (required date input) {
		return dateDiff("s", never, input);
	}

	public date function fromUnixTime (required numeric input) {
		return dateAdd("s", input, never);
	}

	public string function getFwreinitLink (required struct conf) {

		var output = cgi.path_info & "?";
		if (cgi.query_string.len()) {
			var qp = listToArray(cgi.query_string, "&").reduce(function (params, value) {
				params[listFirst(value, "=")] = listLast(value, "=");
				return params;
			}, {});
			if (!structKeyExists(qp, conf.reload)) {
				qp[conf.reload] = conf.password;
			}
			qp = qp.reduce(function(str, key, value) {
				if (str.len()) {
					str &= "&";
				}
				return str &= key & "=" & value;
			}, "");

			output &= qp;
		} else {
			output &= conf.reload & "=" & conf.password;
		}

		return output;
	}

	date function today () {
		return midnight();
	}

	date function midnight (date dt = utc()) {
		return createDateTime(year(dt), month(dt), day(dt), 0, 0, 0);
	}

	date function nextWeekday (date dt = today()) {
		var dow = dayOfWeek(dt);
		if (dow == 1) {
			return dateAdd("d", 1, dt);
		} else if (dow == 7) {
			return dateAdd("d", 2, dt);
		}
		return dt;
	}

	array function nextTwoWeeksWeekdays (date startDate = nextWeekday(today())) {
		var nextTwoWeeks = [];
		var currentWeek = [];
		var today = startDate;
		//pad the first week based on the day of the week
		for (var i = dayOfWeek(today)-2; i > 0; i--) {
			currentWeek.append(dateAdd("d", -1 * i, today));
		}
		for (var i = 1; i <= 14; i++) {
			var dow = dayOfWeek(today)
			if (!arrayContains([1,7], dow)) {
				currentWeek.append(today);
			}
			if (dow == 7) {
				nextTwoWeeks.append(currentWeek);
				currentWeek = [];
			}
			today = dateAdd("d", 1, today);
		}
		if (currentWeek.len()) {
			for (var i = 5 - currentWeek.len(); i > 0; i--) {
				currentWeek.append(today);
				today = dateAdd("d", 1, today);
			}
			nextTwoWeeks.append(currentWeek);
		}

		return nextTwoWeeks;
	}

	date function getPreviousSunday (required date input) {
		return dateAdd("d", -1 * (dayOfWeek(input)-1), input);
	}

	date function getPreviousMonday (required date input) {
		return dateAdd("d", 1, getPreviousSunday());
	}

	date function getFirstDayOfMonth (required date monthDate) {
		return createDate(year(monthDate), month(monthDate), 1);
	}

	date function getLastDayOfMonth (required date monthDate) {
		return createDate(year(monthDate), month(monthDate), daysInMonth(monthDate));
	}

	date function getFirstDOWForMonth (required date monthDate, required numeric dow) {
		if (dow < 1 || dow > 7) {
			throw(message="Invalid DOW: #dow#");
		}

		var output = getFirstDayOfMonth(monthDate);
		for (var i = 1; i <= 7; i++) {
			if (dayOfWeek(output) == dow) {
				break;
			}
			output = dateAdd("d", 1, output);
		}

		return output;
	}

	date function getLastDOWForMonth (required date monthDate, required numeric dow) {
		if (dow < 1 || dow > 7) {
			throw(message="Invalid DOW: #dow#");
		}

		var output = getLastDayOfMonth(monthDate);
		for (var i = 1; i <= 7; i++) {
			if (dayOfWeek(output) == dow) {
				break;
			}
			output = dateAdd("d", -1, output);
		}

		return output;
	}


	function sb (string start = "") {
		return createObject("java", "java.lang.StringBuffer").init(start);
	}

	function JSONResponse (data, messenger) {
		var out = sb("{");

		out.append('"hasError":');
		out.append(messenger.hasErrors());
		out.append(', "errors":');
		out.append(messenger.toJSON(messenger.getErrors()));
		out.append(',"hasWarning":');
		out.append(messenger.hasWarnings());
		out.append(', "warnings":');
		out.append(messenger.toJSON(messenger.getWarnings()));
		out.append(', "data":');
		if (isJSON(data)) {
			out.append(data);
		} else {
			if ((isObject(data) || isStruct(data)) && structKeyExists(data, "toJSON")) {
				out.append(data.toJSON());
			} else {
				out.append(serializeJSON(data));
			}
		}
		out.append('}')
		messenger.clear();

	    return out.toString();
	}

	function findFirst (collection, f) {
		for (var i = 1; i <= arrayLen(collection); i++) {
			var item = collection[i];
			if ( f(item, i, collection)) {
				return item;
			}
		}
		return javacast("null",0);
	}

	function times (required numeric nTimes, required any f) {
		for (var i = 1; i <= nTimes; i++) {
			f(i);
		}
	}

	function convertDataPathToRelativeLink (inputPath) {
		var dataDir = replace(replace(expandPath(getSetting("dataDir")), "\", "/", "all"), "/data", "");
		inputPath = replace(inputPath, "\", "/", "all");
		inputPath = replaceNoCase(inputPath, dataDir, "");
		return inputPath;
	}

	function convertDataPathToAbsoluteLink (inputPath) {
		//return (cgi.https == 'ON' ? 'https' : 'http') & '://' & cgi.http_host & ':' & cgi.server_port & convertDataPathToRelativeLink(inputPath);
		if (inputPath.trim().len()) {
			return (cgi.https == 'ON' ? 'https' : 'http') & '://' & cgi.http_host & convertDataPathToRelativeLink(inputPath);
		}
		return "";
	}

}