component name="BaseDomain" accessors="true" {
	property name="formatterService" inject="formatterService";
	property string dataDir;
	property string idField;

	public numeric function getID() {
		if (!isNull(variables.idField)) {
			return this["get" & variables.idField];
		}
		throw(message="You need to call setIDField() in the init function in the following component: " & getMetadata(this).fullname);
	}

	public boolean function isEmpty() {
		return getID() == 0;
	}

	string function get__classtype () {
		return getComponentMetadata(this).fullname;
	}

	variables.instance.never = createDateTime(1970, 1, 1, 0, 0, 0);

	public date function gmt () {
		return dateConvert("local2UTC", now());
	}

	array function getToStringIgnore() {
		return ["getToStringIgnore"];
	}

	array function getUCaseProps() {
		return [];
	}

	function convertDataPathToRelativeLink (inputPath) {
		var dataDir = replace(replace(expandPath(dataDir), "\", "/", "all"), "/data", "");
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
	
	string function stripGetFromFunctionName (required string input) {
		var ucp = ArrayFindNoCase(getUCaseProps(), input) != 0; //check input before "get" stripped
		input = input.replace("get","");
		if (len(input) LT 2) {
			return ucp ? ucase(input ) : lcase(input);
		}
		else {
			return ucp ? ucase(input ) : lcase(left(input, 1)) & right(input, len(input)-1);
		}
	}

	struct function toStruct () {

		return findGettersRecursive(getMetadata(this)).reduce(function(agg, item){
			if (ArrayContains(getToStringIgnore(),item.name) eq 0) {
				agg[stripGetFromFunctionName(item.name)] = toStructRecursive(this[item.name]);
			}
			return agg;
		}, structNew());
	}

	private any function toStructRecursive (any input) {

		if (isSimpleValue(input)) {
			return input;
		}

		if (isObject(input) && isinstanceof(input, "BaseDomain")) {
			return input.toStruct();
		}

		if (isArray(input)) {
			return input.map(function(item) {
				return toStructRecursive(item);
			});
		}

		if (isStruct(input)) {
			return StructReduce(input,function(agg, key, item) {
				agg[key] = toStructRecursive(item);
				return agg;
			}, structNew());
		}

		return input;
	}


	private array function findGettersRecursive (required struct md) {
		var getters = isNull(md.functions) ? [] : md.functions.filter(function(item) {
			return left(item.name, 3) == "get";
		});

		if (!isNull(md.extends)) {
			getters.addAll(findGettersRecursive(md.extends));
		}

		return getters;
	}
}
		
