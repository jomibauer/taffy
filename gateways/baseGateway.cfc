component singleton=true {

	/*this exists because of a bug in railo - hopefully will be fixed one day and this can be removed
	https://issues.jboss.org/browse/RAILO-3284*/
	function fixArgumentsStruct(input) {
		var output = {};
		for (var key in input) {
			output[key] = input[key];
		}
		return output;
	}
}