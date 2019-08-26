component extends="coldbox.system.EventHandler" {
	property name="userService";
	property name="securityService";
	property name="beanFactory";
	property name="validationService";
	property name="formatterService";

	property name="security_loginFormItem";
	property name="security_loginSubmitItem";
	property name="security_logoutSubmitItem";
	property name="security_resetPasswordFormItem";

	// Default Action
	function index(event,rc,prc){
		prc.welcomeMessage = "Welcome to ColdBox!";
		event.setView("main/index");
	}

	// Do something
	function doSomething(event,rc,prc){
		relocate( "main/index" );
	}

	/************************************** IMPLICIT ACTIONS *********************************************/

	function onAppInit(event,rc,prc){

	}

	function onRequestStart(event,rc,prc){
		rc.xeh.processLogout = 'main/processLogout';
		rc.xeh.viewAccountDetail = 'userManagement/viewAccountDetail';
		rc.xeh.userManagementIndex = 'userManagement/index';

		rc.controllerName = "main";
	}

	function onRequestEnd(event,rc,prc){

	}

	function onSessionStart(event,rc,prc){

	}

	function onSessionEnd(event,rc,prc){
		var sessionScope = event.getValue("sessionReference");
		var applicationScope = event.getValue("applicationReference");
	}

	function onException(event,rc,prc){
		event.setHTTPHeader( statusCode = 500 );
		//Grab Exception From private request collection, placed by ColdBox Exception Handling
		var exception = prc.exception;
		//Place exception handler below:
		writeDump(exception);
		abort;
	}

	// importing fw/1 main

	/*function checkAuthorization (event,rc,prc) {
		if (isNull(session.user) || isNull(session.messenger) || isNull(session.flash)) {
			setupSession();
		}

		var isSecuredEvent = securityService.isSecuredEvent(fw.getSection(), fw.getItem());
		if ( isSecuredEvent && (isNull(session.user) || !session.user.isLoggedIn())) {
			if (len(cgi.path_info)) {
				session.login_requestedPage = cgi.path_info;
			} else if (findNoCase("index.cfm", cgi.request_url)) {
				var requestURLList = replaceNoCase(cgi.request_url, "index.cfm", "|");
				if (listLen(requestURLList,"|") > 1) {
					session.login_requestedPage = listLast(requestURLList, "|");
				} else {
					session.login_requestedPage = "/";
				}
			} else {
				session.login_requestedPage = "/";
			}
			relocate(loginFormItem);
		}
	}*/

	/*function setupSession (event,rc,prc) {
		session.user = userService.load(0);
		session.messenger = beanFactory.getBean("Messenger");
		session.flash = beanFactory.getBean("FlashStorage");
	}*/

	function viewLogin (event,rc,prc) {
		if (session.user.isLoggedIn()) {
			relocate("main/index");
		}

		rc.xeh.processLogin = "main/processLogin";
		rc.xeh.viewForgotPassword = "main/viewForgotPassword";
		event.setView("main/login");
	}

	function processLogin (event,rc,prc) {
		if ( session.user.getIntUserID() && session.user.isLoggedIn() ) {
			session.user = session.user;
			session.user = session.user;

			if ( session.user.getbtIsPasswordExpired() ) {
				relocate(action=resetPasswordFormItem);
			}

			if ( structKeyExists(session, "login_requestedPage") && len(session.login_requestedPage) ) {
				var redirectTo = session.login_requestedPage;
				structDelete(session, "login_requestedPage");
				relocateCustomURL(redirectTo);
			} else {
				relocate(action='main/index');
			}
		}
	}

	/*function processLogout (event,rc,prc) {
		session.user = userService.load(0);
		relocate(action=loginFormItem);
	}*/

	function viewChangePassword (event,rc,prc) {
		param name="rc.user" default=session.user;

		rc.xeh.processChangePassword = 'main/processChangePassword';
		event.setView("main/changePassword");
	}

	function processChangePassword (event,rc,prc) {
		var hasErrors = userService.validateChangePassword(rc=rc, messenger=session.messenger);

		if ( !hasErrors ) {
			userService.changePassword(intUserID=rc.userID
					, newPassword=rc.password
					, isTempPassword=false
					, requireNewPassword=false
					, setBy=session.user.getIntUserID()
					, setByIP=cgi.remote_addr);
			session.messenger.addAlert(messageType="INFO", message="The password has been successfully changed");
			relocate(action='userManagement/viewAccountDetail');
		} else {
			//this wont work if we let someone change a password for someone else
			relocate(action='main/viewChangePassword');
		}
	}

	function viewForgotPassword (event,rc,prc) {
		param name="rc.email" default="";

		rc.xeh.processForgotPassword = 'main/processForgotPassword';
		event.setView("main/forgotPassword");
	}

	function processForgotPassword (event,rc,prc) {
		if ( isNull(rc.email) || !len(trim(rc.email)) ) {
			relocate(action=loginFormItem);
		}

		var user = userService.loadByEmail(rc.email);

		if ( !user.getIntUserID() ) {
			session.messenger.addAlert(
				messageType="ERROR"
					, message="Invalid Email"
					, messageDetail="We do not have an account for that email address.  Please check the input and try again."
					, field="email");
			relocate(action='main/viewForgotPassword', persist='email');
		}

		userService.sendPasswordResetEmail(user);

		session.messenger.addAlert(
			messageType="SUCCESS"
				, message="Your temporary password has been sent to your email."
				, messageDetail="Follow the instructions in the email to login and reset your password.");

		relocate(action=loginFormItem);
	}

	function robots (event,rc,prc) {

	}


}