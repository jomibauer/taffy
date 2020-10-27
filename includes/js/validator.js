

	function validator(validatorParams) {
		errors = new Object();

		errors.start = function() {
			var requiredFields = errors.getRequiredFields();
			var whichField;
			var memberIds;
			var dtFormat;

			if (!errors.testParams(validatorParams)) {
				return false;
			}

			for (var i = 0; i < requiredFields.length; i++) {
				errors.listen("#" + requiredFields[i].id, "change", function any(field) {
					if (validatorParams.display === "topDisplay") {
						if (field.dataset && field.dataset.group) {
							memberIds = errors.getGroupMemberIds(field.dataset.group);
							memberIds.forEach(function(id, idx) {
								if (document.getElementById("err-" + id)) {
									document.getElementById("err-" + id).remove();
								}
							});
						}
						else {
							if (document.getElementById("err-" + field.id)) {
								document.getElementById("err-" + field.id).remove();
							}
						}
					}
					errorList = errors.validate(field, []);
					if (field.dataset && field.dataset.group) {
						whichField = field.dataset.group;
					}
					else {
						whichField = field.id;
					}
					if (!errorList.length) {
						if (validatorParams.display === "topDisplay" && document.getElementById("err-" + field.id)) {
							document.getElementById("err-" + whichField).remove();
						}
						else {
							errors.clearError(whichField);
						}
					}
					else {
						if (validatorParams.display === "topDisplay") {
							errorList.forEach(function(error, idx) {
								errors.addError(error);
							});
						}
					}
				});

				if (requiredFields[i].dataset && requiredFields[i].dataset.type === "date" && document.getElementById(requiredFields[i].id).value === "") {
					if (requiredFields[i].dataset.format && requiredFields[i].dataset.separator) {
						errors.checkDateFormat(requiredFields[i].id, requiredFields[i].dataset.format, requiredFields[i].dataset.separator);
						document[validatorParams.formName][requiredFields[i].name].placeholder = errors.formatDatePlaceholder(
							requiredFields[i].dataset.format, 
							requiredFields[i].dataset.separator
						);
					}
				}
			}

			if (validatorParams.autoSubmit && document.getElementById(validatorParams.submitButtonId)) {
				errors.listen("#" + validatorParams.submitButtonId, "click", function any() {
					errors.validateAll();
				});
			}
		};

		errors.testParams = function(validatorParams) {
			var blanks = false;
			var missing = [];
			var params = [
				"display",
				"formName",
				"submitButtonId",
				"autoSubmit",
				"padDates",
				"topErrorTargetId",
				"topErrorItemClass",
				"errorHideClass"
			];
			var type;

			if (typeof(validatorParams) !== "object") {
				errors.showInternalError("Your validatorParams variable is not a valid object.");
				return false;
			}

			params.forEach(function(param, idx) {
				if (!validatorParams.hasOwnProperty(param)) {
					missing.push(param);
				}
			});

			if (missing.length) {
				errors.showInternalError("You failed to pass the following values in your validatorParams object: " + missing.join(", ") + ".");
				return false;
			}

			params.forEach(function(param, idx) {
				var type = param === "padDates" || param === "autoSubmit" ? "boolean" : "string";
				var ok = true;

				if (typeof(validatorParams[param]) !== type) {
					errors.showInternalError("The value of " + param + " must be of the type " + type + ".");
					ok = false;
				}

				if (!ok) {
					return false;
				}
			});

			if (validatorParams.autoSubmit && (!document.getElementById(validatorParams.submitButtonId) || validatorParams.submitButtonId.trim() == "")) {
				errors.showInternalError("You can't use the autoSubmit feature because the submitButtonId you passed in was undefined or doesn't exist.");
				return false;
			}

			if (!document.getElementById(validatorParams.formName)) {
				errors.showInternalError("The form \"" + validatorParams.formName + "\" referenced in your validatorParams object doesn't exist.");
				return false;
			}

			if (validatorParams.display === "topDisplay" && !document.getElementById(validatorParams.topErrorTargetId)) {
				errors.showInternalError("The element \"" + validatorParams.topErrorTargetId + "\" referenced in your validatorParams object doesn't exist.");
				return false;
			}

			["display", "topErrorItemClass", "errorHideClass"].forEach(function(item, idx) {
				if (validatorParams[item].trim() === "") {
					errors.showInternalError("The validatorParams \"" + item + "\" value cannot be an empty string.");
					blanks = true;
					return;					
				}
			});

			if (blanks) {
				return false;
			}

			return true;
		}

		errors.formatDatePlaceholder = function(format, separator) {
			if (format.substr(0, 1).toLowerCase() === "m" || format.substr(0, 1).toLowerCase() === "d") {
				return format.substr(0, 2) + separator + format.substr(2, 2) + separator + format.substr(4, 4)
			}
			else if (format.substr(0, 1).toLowerCase() === "y") {
				return format.substr(0, 4) + separator + format.substr(4, 2) + separator + format.substr(6, 2)
			}
			return "";
		};

		errors.showMissingElement = function(id) {
			if (!document.getElementById(id)) {
				errors.showInternalError("The error display element \"" + id + "\" is missing.");
				return true;
			}
		};

		errors.showInternalError = function(msg) {
			console.warn("VALIDATOR SAYS: " + msg);
			return true;
		};

		errors.showError = function(id, msg) {
			id = id + "-error";
			if (errors.showMissingElement(id)) {
				return false;
			}
			document.getElementById(id).innerHTML = msg;
			errors.removeClass(id, validatorParams.errorHideClass);
		};

		errors.clearError = function(id) {
			id = id + "-error";
			if (errors.showMissingElement(id)) {
				return false;
			}
			document.getElementById(id).innerHTML = "";
			errors.addClass(id, validatorParams.errorHideClass);
		};

		errors.addError = function(msg) {
			newElement = document.createElement("span");
			newElement.innerHTML = msg;
			document.getElementById(validatorParams.topErrorTargetId).appendChild(newElement);
			errors.removeClass(validatorParams.topErrorTargetId, validatorParams.errorHideClass);
		};

		errors.clearErrors = function() {
			if (validatorParams.display === "onField") {
				var requiredFields = errors.getRequiredFields();

				for (var i = 0; i < requiredFields.length; i++) {
					if (requiredFields[i].dataset && requiredFields[i].dataset.group) {
						errors.clearError(requiredFields[i].dataset.group);
					}
					else {
						errors.clearError(requiredFields[i].id);
					}
				}
			}
			else {
				document.getElementById(validatorParams.topErrorTargetId).innerHTML = "";
				errors.addClass(validatorParams.topErrorTargetId, validatorParams.errorHideClass);
			}
		};

		errors.output = function(errorList) {
			var errorString = "";

			errors.removeClass(validatorParams.topErrorTargetId, validatorParams.errorHideClass);

			errorList.forEach(function(error, idx) {
				errorString += error;
			});
			document.getElementById(validatorParams.topErrorTargetId).innerHTML = errorString;
		};

		errors.getRequiredFields = function() {
			var requiredFields = [];
			var fields;
			var msg;

			["input", "select", "textarea"].forEach(function(item, idx) {
				fields = Array.prototype.slice.call(document.getElementsByTagName(item));
				for (var i = 0; i < fields.length; i++) {
					if (fields[i].type !== "button") {
						if (fields[i].dataset && fields[i].dataset.required) {
							if (!fields[i].dataset.type || !fields[i].dataset.label) {
								msg = "The input element called \"" + fields[i].id + "\" is missing either its dataset.type or dataset.label.";
								errors.showInternalError(msg);
								return false;
							}
							if (fields[i].dataset && fields[i].dataset.fromTo) {
								if (fields[i].dataset.fromTo !== "from" && fields[i].dataset.fromTo !== "to") {
									msg = "The dataset.from-to value at the input element \"" + fields[i].id + "\" must be either \"from\" or \"to\" (case sensitive).";
									errors.showInternalError(msg);
									return false;
								}
							}
							requiredFields.push(fields[i]);
						}
					}
				}
			});
			return requiredFields;
		}

		errors.placeValidatedFlag = function() {
			var flag = "<input type=\"hidden\" id=\"clientValidated\" name=\"clientValidated\" value=\"true\">";

			if (!document.getElementById("clientValidated")) {
				newElement = document.createElement("span");
				newElement.innerHTML = flag;
				document.getElementById(validatorParams.formName).appendChild(newElement);
			}
		}

		errors.removeValidatedFlag = function() {
			if (document.getElementById("clientValidated")) {
				document.getElementById("clientValidated").remove();
			}
		}

		errors.validateAll = function() {
			var requiredFields = errors.getRequiredFields();

			errors.removeValidatedFlag();
			errors.clearErrors();
			errorList = [];

			for (var i = 0; i < requiredFields.length; i++) {
				if (validatorParams.display === "onField") {
					errors.validate(requiredFields[i], errorList);
				}
				else if (validatorParams.display === "topDisplay") {
					errorList = errors.validate(requiredFields[i], errorList);
				}
			}
			if (validatorParams.display === "topDisplay" && errorList.length) {
				errors.output(errorList);
			}

			if (!errorList.length) {
				errors.placeValidatedFlag();
				if (validatorParams.autoSubmit) {
					document[validatorParams.formName].submit();
				}
			}

			return errorList.length ? false : true;
		};

		errors.validate = function(field, errorList) {
			var msg = "";
			var oldMsg;
			var checkedCount = 0;
			var radio;
			var radioChecked = false;
			var fileTypes;
			var okTypes = "";
			var arr;
			var ext;
			var ok = false;
			var dates;
			var fromDate;
			var toDate;
			var phone;

			if (d = field.dataset) {
				if (d.label) {
					switch(d.type) {
						case "string":
							if (field.value.trim() === "" && d.required === "true") {
								msg = "Please enter the " + d.label;
							} 
							else {
								msg = errors.checkConditions(d, field, checkedCount);
							}
							break;

						case "number":
							if (field.value.trim() === "" && d.required === "true") {
								msg = "Please enter the " + d.label;
							} 
							else if (isNaN(field.value)) {
								if (validatorParams.display === "onField") {
									msg = "This must be a numeric value";
								}
								else {
									msg = "The " + d.label + " must be a numeric value";
								}
							}
							else if (d.numtype && d.numtype === "integer" && field.value.indexOf(".") > -1) {
								if (validatorParams.display === "onField") {
									msg = "This must be a whole number";
								} 
								else {
									msg = "The " + d.label + " must be a whole number";
								}
							}
							if (msg === "") {
								msg = errors.checkConditions(d, field, checkedCount);
							}
							break;

						case "date":
							if (d.group) {
								arr = errors.getGroupMemberIds(d.group);
								if (arr.length !== 2) {
									errors.showInternalError("A date range group must have two fields, no more, no less.");
									return false;
								}
								else {
									dates = errors.getDateRangeDates(field.id, d.group);

									fromDateObj = errors.makeField(dates.fromDateId);
									toDateObj = errors.makeField(dates.toDateId);

									if (d.required === "true") {
										if (!errors.checkDate(fromDateObj) || !errors.checkDate(toDateObj)) {
											if (validatorParams.display === "onField") {
												msg = "Please enter valid from/to dates in " + errors.showDateFormat(d) + " format";
											}
											else {
												msg = "Please enter valid from/to dates in " + errors.showDateFormat(d) + " format at " + d.label;
											}
										}
									}
									else if (field.value.length) {
										if (!errors.checkDate(field) || !errors.checkDate(field)) {
											if (validatorParams.display === "onField") {
												msg = "Please enter valid from/to dates";
											}
											else {
												msg = "Please enter valid from/to dates at " + d.label;
											}
										}
									}
									if (!msg.length) {
										fromDate = document[validatorParams.formName][dates.fromDateId].value.trim();
										toDate = document[validatorParams.formName][dates.toDateId].value.trim();

										if (!errors.checkDateRange(fromDate, toDate)) {
											if (validatorParams.display === "onField") {
												msg = "The To date can't come before the From date";
											}
											else {
												msg = "The To date can't come before the From date at " + d.label;
											}
										}
									}
									if (msg === "" && field.value.length) {
										errors.padDate(field);
									}
								}
							} 
							else {
								if (field.value.trim() === "" && d.required === "true") {
									msg = "Please enter the " + d.label;
								} 
								else if (field.value.trim().length && !errors.checkDate(field)) {
									if (validatorParams.display === "onField") {
										msg = "Please enter a valid date in " + errors.showDateFormat(d) + " format";
									}
									else {
										msg = "Please enter a valid date in " + errors.showDateFormat(d) + " format at " + d.label;
									}
								}
								if (msg === "") {
									errors.padDate(field);
								}
							}
							break;

						case "check":
							if (d.group) {
								checkedCount = errors.getGroupStatus(d.group);
							}
							if (d.group && d.required === "true") {
								if (checkedCount === 0) {
									if (validatorParams.display === "onField") {
										msg = "Please check on at least one item";
									}
									else {
										msg = "Please check on at least one item at " + d.label;
									}
								} else {
									msg = errors.checkConditions(d, field, checkedCount);
								}
							}
							else if (d.group && d.required === "false") {
								msg = errors.checkConditions(d, field, checkedCount);
							}
							else if (d.required === "true" && !document.getElementById(field.id).checked)  {
								if (validatorParams.display === "onField") {
									msg = "Please check this on";
								}
								else {
									msg = "Please check the " + d.label + " checkbox on";
								}
							}
							break;

						case "radio":
							if (!errors.checkRadio(field.name) && d.required === "true") {
								if (validatorParams.display === "onField") {
									msg = "Please make a selection";
								}
								else {
									msg = "Please make a selection at " + d.label;
								}
							}
							break;

						case "select":
							if (field.value.trim() === "" && d.required === "true") {
								if (validatorParams.display === "onField") {
									msg = "Please make a selection";
								}
								else {
									msg = "Please make a selection at " + d.label;
								}
							} 
							break;

						case "multiselect":
							if (field.value.trim() === "" && d.required === "true") {
								if (validatorParams.display === "onField") {
									msg = "Please make a selection";
								}
								else {
									msg = "Please make a selection at " + d.label;
								}
							}
							if (msg === "") {
								msg = errors.checkConditions(d, field, checkedCount);
							}
							break;

						case "file":
							if (!d.filetypes) {
								msg = "The file input element called \"" + field.id + "\" is missing its dataset.filetypes parameter. That\n";
								msg += "parameter must be used, even if its value is an empty string (meaning any file type may be uploaded).";
								errors.showInternalError(msg);
								return false;
							}
							if (d.filetypes.length) {
								if (field.value.trim() === "" && d.required === "true") {
									if (validatorParams.display === "onField") {
										msg = "Please choose a file";
									}
									else {
										msg = "Please choose a file at " + d.label;
									}
								}
								if (msg === "" && field.value.trim().length) {

									if (field.value.indexOf(".") < 0) {
										if (validatorParams.display === "onField") {
											msg = "The filename extension is missing"
										}
										else {
											msg = "The filename extension is missing at " + d.label;
										}
									}
									else {
										arr = field.value.split(".");
										ext = arr[arr.length - 1].toLowerCase();
										fileTypes = d.filetypes.split(",");

										for (var i = 0; i < fileTypes.length; i++) {
											okTypes += fileTypes[i] + " ";
											if (ext === fileTypes[i].toLowerCase()) {
												ok = true;
											}
										}
										if (!ok) {
											if (validatorParams.display === "onField") {
												msg = "The file must be in one of these formats: " + okTypes.toUpperCase().trim();
											}
											else {
												msg = "The file chosen at " + d.label + " must be in one of these formats: " + okTypes.toUpperCase().trim();
											}
										}
									}
								}
							}
							break;

						case "phone":
							if (field.value.trim() === "" && d.required === "true") {
								msg = "Please enter a 10-digit number at " + d.label;
							}
							else if (field.value.length) {
								if (d.format) {
									if (!errors.checkPhoneFormat(field.id, d.format)) {
										return false;
									}
									phone = errors.checkPhone(field.value.trim(), d.format);
								}
								else {
									phone = errors.checkPhone(field.value.trim());
								}
								if (phone.ok) {
									document.getElementById(field.id).value = phone.phone;
								}
								else {
									if (validatorParams.display === "onField") {
										msg = "Please enter a 10-digit number";
									}
									else {
										msg = "Please enter a 10-digit number at " + d.label;
									}
								}
							}
							break;

						case "email":
							if (field.value.trim() === "" && d.required === "true") {
								if (validatorParams.display === "onField") {
									msg = "Please enter an email";
								}
								else  {
									msg = "Please enter an email at " + d.label;
								}
							}
							else if (field.value.length && !errors.checkEmail(field.value.trim())) {
								if (validatorParams.display === "onField") {
									msg = "This email doesn't look valid";
								}
								else {
									msg = "The email at " + d.label + " doesn't look valid";
								}
							}
							break;
					}
				}
			}

			if (msg.length) {
				msg += ".";

				if (validatorParams.display === "topDisplay") {
					oldMsg = msg;
					msg = "<p id=\"err-" + field.id + "\" class=\"" + validatorParams.topErrorItemClass + "\">" + msg + "</p>";
					if (!errors.substrArray(errorList, oldMsg)) {
						errorList.push(msg);
					}
				}
				else {
					if (errorList.indexOf(oldMsg) < 0) {
						errorList.push(msg);
					}
					if (d.group) {
						errors.showError(d.group, msg);
					}
					else {
						errors.showError(field.id, msg);
					}
				}
			}
			return errorList;
		};

		errors.checkConditions = function(d, field, checkedCount) {
			var msg = "";
			var optionCount = 0;
			var options;
			var charCheck;
			var noNums = false;

			switch(d.type) {
				case "string":
					if (field.value.length) {

						if (d.max && !d.min && field.value.trim().length > d.max) {
							if (validatorParams.display === "onField") {
								msg = "This must be no more than " + d.max + " characters";
							}
							else {
								msg = "The " + d.label + " must be no more than " + d.max + " characters";
							}
						}
						else if (d.min && !d.max && field.value.trim().length < d.min) {
							if (validatorParams.display === "onField") {
								msg = "This must contain at least " + d.min + " characters";
							}
							else {
								msg = "The " + d.label + " must contain at least " + d.min + " characters";
							}
						}
						else if (d.min && d.min) {
							if (field.value.trim().length > d.max || field.value.trim().length < d.min) {
								if (validatorParams.display === "onField") {
									msg = "This must be between " + d.min + " and " + d.max + " characters";
								}
								else {
									msg = "The " + d.label + "'s length must be between " + d.min + " and " + d.max + " characters";
								}
							}
						}

						if (d.nonums || d.nospecials) {
							charCheck = errors.checkForCharacters(d, field.value.trim());
							if (charCheck !== "ok") {
								if (d.nonums && d.nonums === "true") {
									noNums = true;
								}
								if (charCheck === "ns") {
									if (noNums) {
										if (validatorParams.display === "onField") {
											msg = "This can contain only letters, no numbers or special characters";
										}
										else {
											msg = "The " + d.label + " can contain only letters, no numbers or special characters";
										}
									}
									else {
										if (validatorParams.display === "onField") {
											msg = "This can contain only letters or numbers, no special characters";
										}
										else {
											msg = "The " + d.label + " can contain only letters or numbers, no special characters";
										}
									}
								}
								else if (charCheck === "an") {
									if (validatorParams.display === "onField") {
										msg = "This can contain only letters or numbers, no special characters";
									}
									else {
										msg = "The " + d.label + " can contain only letters or numbers, no special characters";
									}
								}
								else if (charCheck === "ao") {
									if (validatorParams.display === "onField") {
										msg = "This can contain only letters, no numbers or special characters";
									}
									else {
										msg = "The " + d.label + " can contain only letters, no numbers or special characters";
									}
								}
							}
						}
					}
					break;

				case "number":
					if (field.value.length) {
						if (d.max && !d.min && field.value > d.max) {
							if (validatorParams.display === "onField") {
								msg = "This number can't be more than " + d.max;
							}
							else {
								msg = "The " + d.label + " can't be more than " + d.max;
							}
						}
						else if (d.min && !d.max && field.value < d.min) {
							if (validatorParams.display === "onField") {
								msg = "This number can't be less than " + d.min;
							}
							else {
								msg = "The " + d.label + " can't be less than " + d.min;
							}
						}
						else if (d.min && d.min) {
							if (field.value > d.max || field.value < d.min) {
								if (validatorParams.display === "onField") {
									msg = "This number must be between " + d.min + " and " + d.max;
								}
								else {
									msg = "The " + d.label + " must be between " + d.min + " and " + d.max;
								}
							}
						}
					}
					break;

				case "check":
					if (d.min && !d.max && checkedCount < d.min) {
						if (validatorParams.display === "onField") {
							msg = "Please check at least " + d.min + " item" + errors.plural(d.min);
						}
						else {
							msg = "Please check at least " + d.min + " item" + errors.plural(d.min) + " at " + d.label;
						}
					}
					else if (!d.min && d.max && checkedCount > d.max) {
						if (validatorParams.display === "onField") {
							msg = "Please check no more than " + d.max + " item" + errors.plural(d.max);
						}
						else {
							msg = "Please check no more than " + d.max + " item" + errors.plural(d.max) + " at " + d.label;
						}
					}
					else if (d.min && d.min) {
						if (checkedCount > d.max || checkedCount < d.min) {
							if (validatorParams.display === "onField") {
								msg = "Please check between " + d.min + " and " + d.max + " items";
							}
							else {
								msg = "Please check between " + d.min + " and " + d.max + " items at " + d.label;
							}
						}
					}
					break;

				case "multiselect":
					options = document.getElementById(field.id).options;

					for (var i = 0; i < options.length; i++) {
						if (options[i].selected) {
							optionCount++;
						}
					}
					if (d.min && !d.max && optionCount < d.min) {
						if (validatorParams.display === "onField") {
							msg = "Please select at least " + d.min + " item" + errors.plural(d.min);
						}
						else {
							msg = "Please select at least " + d.min + " item" + errors.plural(d.min) + " at " + d.label;
						}
					}
					else if (!d.min && d.max && optionCount > d.max) {
						if (validatorParams.display === "onField") {
							msg = "Please select no more than " + d.max + " item" + errors.plural(d.max);
						}
						else {
							msg = "Please select no more than " + d.max + " item" + errors.plural(d.max) + " at " + d.label;
						}
					}
					else if (d.min && d.min) {
						if (optionCount > d.max || optionCount < d.min) {
							if (validatorParams.display === "onField") {
								msg = "Please select between " + d.min + " and " + d.max + " items";
							}
							else {
								msg = "Please select between " + d.min + " and " + d.max + " items at " + d.label;
							}
						}
					}
					break;
			}
			return msg;
		};

		errors.getDateRangeDates = function(id, groupName) {
			var requiredFields = errors.getRequiredFields();
			var dates;
			var fromDate;
			var toDate;

			for (var i = 0; i < requiredFields.length; i++) {
				if (requiredFields[i].dataset && requiredFields[i].dataset.group && requiredFields[i].dataset.group === groupName) {
					if (requiredFields[i].dataset.fromTo && requiredFields[i].dataset.fromTo === "from") {
						fromDate = requiredFields[i];
					}
					else if (requiredFields[i].dataset.fromTo && requiredFields[i].dataset.fromTo === "to") {
						toDate = requiredFields[i];
					}
				}
			}
			dates = {
				"fromDateId": fromDate.id,
				"fromDateValue": fromDate.value,
				"toDateId": toDate.id,
				"toDateValue": toDate.value
			};
			return dates;
		};

		errors.checkForCharacters = function(d, inputString) {
			var allowedCharacters = [];

			for (var i = 65; i <= 90; i++) {
				allowedCharacters.push(i);
			}
			for (var i = 97; i <= 122; i++) {
				allowedCharacters.push(i);
			}
			if (!d.nonums || (d.nonums && d.nonums === "false")) {
				for (var i = 48; i <= 57; i++) {
					allowedCharacters.push(i);
				}
				nums = true;
			}
			allowedCharacters.push(32);
			allowedCharacters.push(39);
			allowedCharacters.push(45);

			for (var i = 0; i < inputString.length; i++) {
				if (allowedCharacters.indexOf(inputString.substr(i, 1).charCodeAt(0)) < 0) {
					return allowedCharacters.indexOf(97) > 0 ? "ao" : "an";
				}
			}

			return "ok";
		};

		errors.checkEmail = function(email) {
			var specials = "!#$%^&*()\' +=[];/{}|\":<>?";
			var arr;

			if (email.search("@") > -1 && email.search(".") > -1) {
				arr = email.split("@");
				if (arr[0].length < 2) {
					return false;
				}
				arr = arr[1].split(".");
				for (var i = 0; i < arr.length; i++) {
					if (arr[i].length < 2) {
						return false;
					}
					for (var x = 0; x < arr[i].length; x++) {
						if (!isNaN(arr[i].substr(x, 1))) {
							return false;
						}
					}
				}
				email.split("").forEach(function(char) {
					if (email.indexOf(char) > -1) {
						return false;
					}
				});
				return true;
			}
			return false;
		};

		errors.checkPhone = function(phone, style) {
			var formatted, area, exchange, numbr;
			var response = {};
			var separator;
			var num = "";

			if (phone && phone.length) {
				for (var i = 0; i < phone.length; i++) {
					if (!isNaN(phone.substr(i, 1)) && phone.substr(i, 1) !== " ") {
						num += phone.substr(i, 1);
					}
				}
				if (num.length === 10 && !isNaN(num)) {
					area = num.substr(0, 3);
					exchange = num.substr(3, 3);
					numbr = num.substr(6, 4);
					if (style && style.length) {
						if (style === "." || style === "-") {
							formatted = area + style + exchange + style + numbr;
						}
						else if (style === "()-" || style === "().") {
							separator = style === "()-" ? "-" : ".";
							formatted = "(" + area + ") " + exchange + separator + numbr;
						}
						else {
							formatted = num;
						}
					}
					else {
						formatted = num;
					}
					response = {
						"phone": formatted,
						"ok": true
					};
				}
				else {
					response = {
						"phone": phone,
						"ok": false
					};
				}
			}
			else {
				response = {
					"phone": "",
					"ok": false
				};
			}
			return response;
		};

		errors.checkPhoneFormat = function(id, format) {
			var formats = ["()-", "().", "-", "."];
			var msg;

			if (formats.indexOf(format) < 0) {
				msg = "The phone format requested by the input element \"" + id + "\" isn't valid. Please see the doc for available options and usage.";
				errors.showInternalError(msg);
				return false;
			}
			return true;
		};

		errors.checkDateFormat = function(id, format, separator) {
			var formats = ["MMDDYYYY", "YYYYMMDD"];
			var separators = ["/", "-"];
			var msg;

			if (formats.indexOf(format.toUpperCase()) < 0) {
				msg = "The date format requested by the input element \"" + id + "\" isn't valid.\n";
				msg += "Valid formats are: " + formats.join(" or ") + ". Case doesn't matter.";
				errors.showInternalError(msg);
				return false;
			}
			if (separators.indexOf(separator) < 0) {
				msg = "The date separator requested by the input element \"" + id + "\" isn't valid.\n";
				msg += "Valid separators are: " + separators.join(" or ") + ".";
				errors.showInternalError("Please use one of these date format separators: " + separators.join(" or ") + ".");
				return false;
			}
			return true;
		};

		errors.showDateFormat = function(d) {
			if (d.format.toUpperCase() === "MMDDYYYY") {
				return "MM" + d.separator + "DD" + d.separator + "YYYY";
			}
			else if (d.format.toUpperCase() === "YYYYMMDD") {
				return "YYYY" + d.separator + "MM" + d.separator + "DD";
			}
		}

		errors.checkDate = function(field) {
			var theDate = field.value;
			var yearPosition = 2;
			var delimiter = field.dataset.separator;
			var arr = [];

			if (errors.countSubstring(theDate, delimiter) !== 2 || theDate.length !== 10) {
				return false;
			}
			if (field.dataset && field.dataset.format && field.dataset.separator) {
				errors.checkDateFormat(field.dataset.id, field.dataset.format, field.dataset.separator);
				if (field.dataset.format.substr(0, 1).toLowerCase() === "y") {
					yearPosition = 0;
				}
			}
			arr = theDate.split(delimiter);
			if (arr[yearPosition].length !== 4) {
				return false;
			}
			for (var i = 0; i < arr.length; i++) {
				if (i !== yearPosition) {
					if (!arr[i].length) {
						return false;
					}
					else if (arr[i].length > 2) {
						return false;
					}
				}
			}
			if (newDate = new Date(theDate)) {
				if (isNaN(newDate.getTime())) {
					return false;
				}
				return true;
			}
			return false;
		};

		errors.padDate = function(field) {
			if (validatorParams.padDates && field.value.trim().length) {
				var yearPosition = 2;
				var monthPosition = 0;
				var dayPosition = 1;
				var separator = "/";
				var theDate = "";
				var arr = [];

				if (field.value.search("-") > -1) {
					separator = "-";
				}

				if (field.dataset && field.dataset.format && field.dataset.separator) {
					errors.checkDateFormat(field.dataset.id, field.dataset.format, field.dataset.separator);
					if (field.dataset.format.substr(0, 1).toLowerCase() === "y") {
						yearPosition = 0;
						monthPosition = 1;
						dayPosition = 2;
						separator = field.dataset.separator;
					}
				}

				arr = field.value.split(field.dataset.separator);
				if (arr[monthPosition].length === 1) {
					arr[monthPosition] = "0" + arr[monthPosition];
				}
				if (arr[dayPosition].length === 1) {
					arr[dayPosition] = "0" + arr[dayPosition];
				}

				if (yearPosition === 0) {
					theDate = arr[yearPosition] + separator + arr[monthPosition] + separator + arr[dayPosition];
				}
				else {
					theDate = arr[monthPosition] + separator + arr[dayPosition] + separator + arr[yearPosition];
				}
				document.getElementById(field.id).value = theDate;
			}
		}

		errors.checkDateRange = function(fromDate, toDate) {
			return Date.parse(toDate) < Date.parse(fromDate) ? false : true;
		};

		errors.checkRadio = function(fieldName) {
			var radio = document[validatorParams.formName][fieldName];
			var radioChecked = false;

			for (var i = 0; i < radio.length; i++) {
				if (radio[i].checked) {
					radioChecked = true;
					break;
				}
			}
			return radioChecked;
		};

		errors.makeField = function(fieldId) {
			var fieldObject = {};

			fieldObject["id"] = fieldId;
			if (document.getElementById(fieldId).name) {
				fieldObject["name"] = document.getElementById(fieldId).name;
			}
			if (document.getElementById(fieldId).dataset) {
				fieldObject["dataset"] = document.getElementById(fieldId).dataset;
			}
			fieldObject["value"] = document.getElementById(fieldId).value;

			return fieldObject;
		}

		errors.plural = function(num) {
			if (num && !isNaN(num)) {
				return num === 1 ? "" : "s";
			}
			return "";
		};

		errors.countSubstring = function(haystack, needle) {
			var counter = 0;

			haystack.split("").forEach(function(char) {
				if (char === needle) {
					counter++;
				}
			});
			return counter;
		}

		errors.substrArray = function(arr, needle) {
			var found = false;

			arr.forEach(function(item, idx) {
				if (item.search(needle) > -1) {
					found = true;
					return;
				}
			});
			return found;
		};

		errors.getGroupStatus = function(groupName) {
			var requiredFields = errors.getRequiredFields();
			var checkedCount = 0;

			for (var i = 0; i < requiredFields.length; i++) {
				if (requiredFields[i].dataset && requiredFields[i].dataset.group && requiredFields[i].dataset.group === groupName) {
					if (document.getElementById(requiredFields[i].id).checked) {
						checkedCount++;
					}
				}
			}
			return checkedCount;
		};

		errors.getGroupMemberIds = function(groupName) {
			var requiredFields = errors.getRequiredFields();
			var memberIds = [];

			for (var i = 0; i < requiredFields.length; i++) {
				if (requiredFields[i].dataset && requiredFields[i].dataset.group && requiredFields[i].dataset.group === groupName) {
					memberIds.push(requiredFields[i].id);
				}
			}
			return memberIds;
		};

		errors.addClass = function(id, classname) {
			var classes = document.getElementById(id).classList;
			classes.add(classname);
		};

		errors.removeClass = function(id, classname) {
			var classes = document.getElementById(id).classList;
			classes.remove(classname);
		};

		errors.listen = function(elements, eventname, callback) {
			var items = [];
			var data = {};
			elements = elements.split(" ");

			if (elements.length && eventname && (callback && typeof(callback) === "function")) {
				elements.forEach(function(elm, idx) {
					if (elm.substr(0, 1) === ".") {
						classes = document.getElementsByClassName(elm.replace(".", "").trim());
						for (var i = 0; i < classes.length; i++) {
							items.push(classes[i]);
						}
					}
					else if (elm.substr(0, 1) === "#") {
						items.push(document.getElementById(elm.replace("#", "").trim()));
					}
				});
				for (var i = 0; i < items.length; i++) {
					items[i].addEventListener(eventname, function(e) {
						for (key in e.target) {
							try {
								data[key] = e.target[key];
							} catch (e) {
								data[key] = null;
							}
						}
						callback(data);
					});
				}
			}
		};

		return errors;
	}
