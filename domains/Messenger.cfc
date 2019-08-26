component name="Messenger" {

	property array messageTypeArray;
	property array messageCodeArray;

	property array alerts;
	property numeric currentIndex;

	function init () {

		messageTypeArray = ["ERROR", "WARNING", "INFO", "SUCCESS"];
		messageCodeArray = ["REQUIRED", "MAXLENGTH", "MINLENGTH", "VALIDATION"];

		clear();
		reset();

		return this;
	}

	void function clear() {
		alerts = [];
		alertsByField = {};
	}

	void function reset () {
		currentIndex = 0;
	}

	string function getMessageTypeList() {
		return arrayToList(messageTypeArray);
	}

	boolean function isValidMessageType (required string input) {
		return arrayFindNoCase(messageTypeArray, input);
	}

	string function getMessageCodeList () {
		return arrayToList(messageCodeArray);
	}

	boolean function isValidMessageCode (required string input) {
		return arrayFindNoCase(messageCodeArray, input);
	}

	void function addAlert(
			  required string message
	        , string messageType = "ERROR"
	        , string messageDetail = ""
	        , string messageCode = ""
	        , string field = ""
	        , string alertingEvent = ""
	        , date messageSetOn = now()
			)
	{

		if (!isValidMessageType(messageType)) {
			throw(message = "Invalid messageType: " & messageType);
		}

		if (len(trim(messageCode)) && !isValidMessageCode(messageCode)) {
			throw(message = "Invalid messageCode: " & messageCode);
		}

		arrayAppend(alerts, arguments);
	}

	boolean function fieldHasAlert (required string field) {
		return alerts.some(function(item) {
			return listFindNoCase(item.field, field);
		}, true);
	}

	array function getAlertsByField (required string field) {
		return alerts.filter(function(item) {
			return listFindNoCase(item.field, field);
		}, true)
	}

	struct function getAlertForField (required string field) {
		var alertsByField = getAlertsByField(field);
		if (arrayLen(alertsByField)) {
			return arrayFirst(alertsByField);
		}
		return {message="", messageType="", messageDetail="", messageCode="", field="", alertingEvent="", messageSetOn=now()};
	}

	numeric function getAlertCount () {
		return alerts.len();
	}

	numeric function length () {
		return alerts.len();
	}

	boolean function hasAlerts () {
		return length() > 0;
	}

	array function getAlerts() {
		return duplicate(alerts);
	}

	private any function stringBuffer(string init = "") {
		return createObject("java", "java.lang.StringBuffer").init(init);
	}

	string function toJSON() {
		var sb = stringBuffer("[");

		sb = alerts.reduce(function(acc, alert, index) {
			if (index > 1) {
				acc.append(",");
			}
			acc.append("{");
			acc.append('"messageType":' & serializeJSON(alert.messageType));
			acc.append(', "message":' & serializeJSON(alert.message));
			acc.append(', "messageDetail":' & serializeJSON(alert.messageDetail));
			acc.append(', "messageCode":' & serializeJSON(alert.messageCode));
			acc.append(', "field":' & serializeJSON(alert.field));
			acc.append(', "alertingEvent":' & serializeJSON(alert.alertingEvent));
			acc.append(', "messageSetOn":' & serializeJSON(getHTTPTimeString(alert.messageSetOn)));
			acc.append("}");
			return acc;
		}, sb);

		sb.append("]");

		return sb.toString();
	}

	//iterator methods

	boolean function hasNext() {
		return arrayIsDefined(alerts, currentIndex + 1);
	}

	struct function getCurrent() {
		if (!arrayIsDefined(alerts, currentIndex)) {
			throw(message="Invalid Index: There is no current alert.  Use reset() to start over.");
		}

		return duplicate(alerts[currentIndex]);
	}

	struct function getNext() {
		currentIndex++;
		return getCurrent();
	}

	void function sort () {

		var temp = [];

		messageTypeArray.each(function (messageType) {
			temp.append(alerts.filter(function (alert){
				return alert.messageType == messageType;
			}));
		});

	}

}