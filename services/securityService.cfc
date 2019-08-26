component extends="baseService" accessors="true" singleton=true {

	property array nonSecuredHandlers;
	property array nonSecuredItems;
	property string loginFormItem;
	property string loginSubmitItem;
	property string logoutSubmitItem;
	property string resetPasswordFormItem;

	private void function addNonSecuredItem (required string value) {
		if (!arrayFindNoCase(nonSecuredItems, value)) {
			arrayAppend(nonSecuredItems, value);
		}
	}

	private string function cleanEvent (required string event) {
		return replace(event, "/", ".");
	}

	private function cleanEvents (required any set) {
		return arrayMap(set, function (item) {
			return cleanEvent(item);
		});
	}

	boolean function isSecuredEvent (required string currentSection, required string currentItem) {
		var currentAction = currentSection & "." & currentItem;

		if (arrayFindNoCase(nonSecuredSections, currentSection)
			|| arrayFindNoCase(nonSecuredItems, currentAction)) {
			return false;
		}

		return true;
	}

	boolean function isAuthorized (required User user, required string currentSection, required string currentItem) {
		return !isSecuredEvent(currentSection, currentItem) && !user.isLoggedIn();
	}




}