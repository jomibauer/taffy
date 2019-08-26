component singleton=true {

	public date function gmt () {
		return dateConvert("local2UTC", now());
	}

	public date function unixTimeMS () {
		return createObject("java", "java.lang.System").currentTimeMillis();
	}

	public date function unixTime () {
		return int(createObject("java", "java.lang.System").currentTimeMillis() / 1000);
	}

	any function saveStruct (required struct data) {
		return save(populate(getEmptyDomain(), data));
	}

	function assertExists (required struct obj, required string keyName, string errorMessage = "{key} does not exist and is required.") {
		if (!obj.keyExists(keyName)) {
			throw(message=errorMessage.replaceNoCase("{key}", keyName));
		}
	}

	boolean function validateLength (
				  required struct rc
				, required Messenger messenger
				, required string fieldName
				, required string friendlyName
				, required boolean isRequired
				, required numeric maxLength
				, numeric minLength = 0) {

		var length = len(trim(rc[fieldName]));

		if (isRequired && length == 0) {
			messenger.addAlert(messageType="ERROR",
								message=friendlyName & " is Required",
								messageDetail="",
								field=fieldName);
			return false;
		}

		if (maxLength > 0 && length > maxLength) {
			messenger.addAlert(messageType="ERROR",
								message=friendlyName & " is too long",
								messageDetail=friendlyName & " must be fewer than " & maxLength & " characters.",
								field=fieldName);
			return false;
		}

		if (minLength > 0 && length < minLength) {
			messenger.addAlert(messageType="ERROR",
								message=friendlyName & " is too short",
								messageDetail=friendlyName & " must be more than " & arguments.minLength & " characters.",
								field=fieldName);
			return false;
		}

		return true;
	}

	boolean function validateInteger (
				  required struct rc
				, required Messenger messenger
				, required string fieldName
				, required string friendlyName
				, required boolean isRequired
				, required numeric minValue
				, required numeric maxValue
				, required numeric defaultInvalid) {

		var length = len(trim(rc[fieldName]));

		if (isRequired && length == 0) {
			messenger.addAlert(messageType="ERROR",
								message=friendlyName & " is Required",
								messageDetail="",
								field=fieldName);
			return false;
		}

		if (length) {
			if (!isNumeric(rc[fieldName]) || int(rc[fieldName]) != rc[fieldName]) {
				messenger.addAlert(messageType="ERROR",
									message=friendlyName & " must be a whole number between " & minValue & " and " & maxValue,
									messageDetail="",
									field=fieldName);
				rc[fieldName] = defaultInvalid;
				return false;
			}

			if (rc[fieldName] > maxValue || rc[fieldName] < minValue) {
				messenger.addAlert(messageType="ERROR",
									message=friendlyName & " must be a whole number between " & minValue & " and " & maxValue,
									messageDetail="",
									field=fieldName);
				return false;
			}
		}

		if (!isNumeric(rc[fieldName])) {
			rc[fieldName] = defaultInvalid;
		}

		return true;
	}

	boolean function validateNumeric (
				  required struct rc
				, required Messenger messenger
				, required string fieldName
				, required string friendlyName
				, required boolean isRequired
				, required numeric minValue
				, required numeric maxValue
				, required numeric defaultInvalid) {

		var length = len(trim(rc[fieldName]));

		if (isRequired && length == 0) {
			messenger.addAlert(messageType="ERROR",
								message=friendlyName & " is Required",
								messageDetail="",
								field=fieldName);
			return false;
		}

		if (length) {
			if (!isNumeric(rc[fieldName])) {
				messenger.addAlert(messageType="ERROR",
									message=friendlyName & " must be a number between " & minValue & " and " & maxValue,
									messageDetail="",
									field=fieldName);
				rc[fieldName] = defaultInvalid;
				return false;
			}

			if (rc[fieldName] > maxValue || rc[fieldName] < minValue) {
				messenger.addAlert(messageType="ERROR",
									message=friendlyName & " must be a number between " & minValue & " and " & maxValue,
									messageDetail="",
									field=fieldName);
				return false;
			}
		}

		if (!isNumeric(rc[fieldName])) {
			rc[fieldName] = defaultInvalid;
		}

		return true;
	}

	boolean function validateURL (
				  required struct rc
				, required Messenger messenger
				, required string fieldName
				, required string friendlyName
				, required boolean isRequired
				, required numeric maxLength ) {

		var length = len(trim(rc[fieldName]));

		if (isRequired && length == 0) {
			messenger.addAlert(messageType="ERROR",
								message=friendlyName & " is Required",
								messageDetail="",
								field=fieldName);
			return false;
		}

		if (maxLength > 0 && length > maxLength) {
			messenger.addAlert(messageType="ERROR",
								message=friendlyName & " is too long.",
								messageDetail=friendlyName & " must be fewer than " & maxlength & " characters",
								field=fieldName);
			return false;
		}

		if (length && !isValid("URL", rc[fieldName])) {
			messenger.addAlert(messageType="ERROR",
								message=friendlyName & " is not a valid URL.",
								messageDetail="",
								field=fieldName);
			return false;
		}

		return true;
	}

	boolean function validateEmail (
				  required struct rc
				, required Messenger messenger
				, required string fieldName
				, required string friendlyName
				, required boolean isRequired
				, numeric maxLength = 2048
				, numeric minLength = 0) {

		var length = len(trim(rc[fieldName]));

		if (isRequired && length == 0) {
			messenger.addAlert(messageType="ERROR",
								message=friendlyName & " is Required",
								messageDetail="",
								field=fieldName);
			return false;
		}

		if (length) {
			if (maxLength > 0 && length > maxLength) {
				messenger.addAlert(messageType = "ERROR",
					message = friendlyName & " is too long",
					messageDetail = friendlyName & " must be fewer than " & maxLength & " characters.",
					field = fieldName);
				return false;
			}

			if (minLength > 0 && length < minLength) {
				messenger.addAlert(messageType = "ERROR",
					message = friendlyName & " is too short",
					messageDetail = friendlyName & " must be more than " & arguments.minLength & " characters.",
					field = fieldName);
				return false;
			}

			if (!isValid("email", rc[fieldName])) {
				messenger.addAlert(messageType = "ERROR",
					message = friendlyName & " is not a valid email address",
					messageDetail = friendlyName & " must be a validly formatted email address.",
					field = fieldName);
				return false;
			}
		}

		return true;
	}

}