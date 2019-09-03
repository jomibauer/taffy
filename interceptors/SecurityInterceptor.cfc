component extends="coldbox.system.Interceptor" cache="false" {
	property name="userService" inject="userService";

	public any function configure() {

		variables.config = structNew();

		setNonSecuredHandlers(getSetting('security_nonSecuredHandlers'));

        /* any individual events that you do not want secured, add them to this list (handler.event) */
        setNonSecuredEvents(getSetting('security_nonSecuredItems'));

        /* login form event */
        setLoginFormEvent(getSetting('security_loginFormItem'));

        /* loginSubmit event */
        setLoginSubmitEvent(getSetting('security_loginSubmitItem'));

        /* logoutSubmit Event */
        setLogoutSubmitEvent(getSetting('security_logoutSubmitItem'));

        /* resetPasswordForm event */
        setResetPasswordFormEvent(getSetting('security_resetPasswordFormItem'));

		checkConfig();

		return this;
	}

	public void function checkConfig() {

		if (!structKeyExists(variables.config,"nonSecuredHandlers")) {
			throw(message="SecurityInterceptor: Missing config setting for nonSecuredHandlers. Please call setNonSecuredHandlers() in the config.");
		}

		if (!structKeyExists(variables.config,"nonSecuredEvents")) {
			throw(message="SecurityInterceptor: Missing config setting for nonSecuredEvents. Please call setNonSecuredEvents() in the config.");
		}

		if (!structKeyExists(variables.config,"loginFormEvent")) {
			throw(message="SecurityInterceptor: Missing config setting for loginFormEvent. Please call setLoginFormEvent() in the config.");
		}

		if (!structKeyExists(variables.config,"loginSubmitEvent")) {
			throw(message="SecurityInterceptor: Missing config setting for loginSubmitEvent. Please call setLoginSubmitEvent() in the config.");
		}

		if (!structKeyExists(variables.config,"logoutSubmitEvent")) {
			throw(message="SecurityInterceptor: Missing config setting for logoutSubmitEvent. Please call setLogoutSubmitEvent() in the config.");
		}

		if (!structKeyExists(variables.config,"resetPasswordFormEvent")) {
			throw(message="SecurityInterceptor: Missing config setting for resetPasswordFormEvent. Please call setResetPasswordFormEvent() in the config.");
		}

	}

	private void function setNonSecuredHandlers(required string input) {
		variables.config.nonSecuredHandlers = arguments.input;
	}

	private void function setNonSecuredEvents(required string input) {
		variables.config.nonSecuredEvents = arguments.input;
	}

	private void function setLoginFormEvent(required string input) {
		variables.config.loginFormEvent = arguments.input;
	}

	private void function setLoginSubmitEvent(required string input) {
		variables.config.loginSubmitEvent = arguments.input;
	}

	private void function setLogoutSubmitEvent(required string input) {
		variables.config.logoutSubmitEvent = arguments.input;
	}

	private void function setResetPasswordFormEvent(required string input) {
		variables.config.resetPasswordFormEvent = arguments.input;
	}

	public void function preProcess(required any event, required struct interceptData) {
		var rc = event.getCollection();
		var prc = event.getCollection(private=true);

		local.username = event.getValue("username","");
		local.password = event.getValue("password","");
		local.action = event.getValue("action","");

		param name="session.user" default="#userService.getEmptyDomain()#";
		param name="session.messenger" default="#new model.domains.Messenger()#";

		/* make sure the messenger exists */
		if (!structKeyExists(session,"messenger") || event.getValue("clearSession",false) || event.valueExists("fwreinit") || event.getValue("appreinit",false)) {
			lock scope="session" timeout="3" {
				session.messenger = new domains.Messenger();
			}
		}

		local.isSecuredEvent = false;

		if (!listFindNoCase(variables.config.nonSecuredHandlers,event.getCurrentHandler())
			&& !listFindNoCase(variables.config.nonSecuredEvents,event.getCurrentEvent())
			&& !listFindNoCase(variables.config.loginFormEvent,event.getCurrentEvent())
		) {
			local.isSecuredEvent = true;
		}

		/* logout */
		if (event.getCurrentEvent() == variables.config.logoutSubmitEvent) {
			session.user = userService.getEmptyDomain();
			session.user.setIsLoggedIn(false);
		}

		/* trying to login */
		if (event.getCurrentEvent() == variables.config.loginSubmitEvent) {
			if (len(trim(local.username)) && len(trim(local.password))) {
				local.user = userService.authenticateUser(local.username,local.password,cgi.remote_addr);

				if (local.user.getIntUserID()) {
					/* successfully authenticated */
					session.user = local.user;
					session.user.setIsLoggedIn(true);

					if (len(trim(variables.config.resetPasswordFormEvent)) && local.user.getBtIsPasswordExpired()) {
						session.messenger.addAlert(messageType="INFO",message="You must change your password",messageDetail="");
						relocate(event=variables.config.resetPasswordFormEvent);
					}
				} else {
					/* failed authentication */
					session.user.setIsLoggedIn(false);
					session.messenger.addAlert(messageType="ERROR",message="Invalid Username and/or Password",messageDetail="",field="username");

					relocate(event=variables.config.loginFormEvent);
				}
			}
		}

		if (local.isSecuredEvent && !session.user.isLoggedIn()) {
			saveAttemptedURL(arguments.event);
			relocate(event=variables.config.loginFormEvent);
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