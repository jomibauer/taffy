component extends="coldbox.system.Interceptor" cache="false" {
	property name="userService" inject="userService";

	PROPERTY_NAMES = [
		"nonSecuredHandlers",
		"nonSecuredItems",
		"loginFormItem",
		"loginSubmitItem",
		"logoutSubmitItem",
		"resetPasswordFormItem"
	];

	public any function configure() {
		checkConfig();
	}

	public void function checkConfig() {
		var missingProperties = PROPERTY_NAMES.filter(function(propertyName) {
				return !propertyExists(propertyName);
			})
			.toList();

		if (listLen(missingProperties) > 0) {
			throw(message="SecurityInterceptor missing properties: #missingProperties#");
		}
	}

	public void function preProcess(required any event, required struct interceptData) {
		var rc = event.getCollection();
		var prc = event.getCollection(private=true);
		var action = event.getValue("action", "");

		param name="session.user" default="#userService.getEmptyDomain()#";
		param name="session.messenger" default="#new model.domains.Messenger()#";

		/* make sure the messenger exists */
		if (!structKeyExists(session, "messenger") || event.getValue("clearSession", false) || event.valueExists("fwreinit") || event.getValue("appreinit",false)) {
			lock scope="session" timeout="3" {
				session.messenger = new model.domains.Messenger();
			}
		}

		var config = getProperties();
		var currentEvent = event.getCurrentEvent();
		var username = trim(event.getValue("username", ""));
		var password = trim(event.getValue("password", ""));
		var isSecuredEvent = !listFindNoCase(config.nonSecuredHandlers, event.getCurrentHandler())
			&& !listFindNoCase(config.nonSecuredItems, event.getCurrentEvent())
			&& !listFindNoCase(config.loginFormItem, event.getCurrentEvent());

		if (currentEvent == config.loginSubmitItem) {
			session.user = userService.authenticateUser(username, password, cgi.remote_addr);
			session.user.setIsLoggedIn(session.user.getIntUserId() > 0);
			if (session.user.getIsLoggedIn()) {
				if (len(trim(config.resetPasswordFormItem)) && session.user.getBtIsPasswordExpired()) {
					session.messenger.addAlert(messageType = "INFO", message = "You must change your password", messageDetail = "");
					relocate(config.resetPasswordFormItem);
				}
			} else {
				session.messenger.addAlert(messageType="ERROR",message="Invalid Username and/or Password",messageDetail="",field="username");
				relocate(event=config.loginFormItem);
			}
		} elseif (currentEvent == config.logoutSubmitItem) {
			session.user = userService.getEmptyDomain();
			session.user.setIsLoggedIn(false);
			relocate(event=config.loginFormItem);
		} elseif (isSecuredEvent && !session.user.isLoggedIn()) {
			saveAttemptedURL(arguments.event);
			relocate(event=config.loginFormItem);
		}
	}

	public void function saveAttemptedURL(required any event) {
		param name="session.attemptedURLParams" default="";

		session.attemptedURL = arguments.event.getValue("event","");

		/* the event it was trying to go to is an ajax event */
		if (FindNoCase("ajax", session.attemptedURL) NEQ 0) {
			session.attemptedURL = listFirst(session.attemptedURL,".") & ".index";
			return;
		}

		if (arguments.event.valueExists("ID")) {
			session.attemptedURLParams = arguments.event.getCollection().ID;

			if (arguments.event.valueExists("ID2")) {
				session.attemptedURLParams = listAppend(session.attemptedURLParams,arguments.event.getCollection().ID2,"/");

				if (arguments.event.valueExists("ID3")) {
					session.attemptedURLParams = listAppend(session.attemptedURLParams,arguments.event.getCollection().ID3,"/");

					if (arguments.event.valueExists("ID4")) {
						session.attemptedURLParams = listAppend(session.attemptedURLParams,arguments.event.getCollection().ID4,"/");

						if (arguments.event.valueExists("ID5")) {
							session.attemptedURLParams = listAppend(session.attemptedURLParams,arguments.event.getCollection().ID5,"/");

							if (arguments.event.valueExists("ID6")) {
								session.attemptedURLParams = listAppend(session.attemptedURLParams,arguments.event.getCollection().ID6,"/");
							}
						}
					}
				}
			}
		}
	}
}