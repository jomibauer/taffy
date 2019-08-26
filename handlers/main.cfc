component extends="coldbox.system.EventHandler" {

	// Default Action
	function index(event,rc,prc){
		prc.welcomeMessage = "Welcome to ColdBox!";
		event.setView("main/index");
	}

	// Do something
	function doSomething(event,rc,prc){
		relocate( "main.index" );
	}

	/************************************** IMPLICIT ACTIONS *********************************************/

	function onAppInit(event,rc,prc){

	}

	function onRequestStart(event,rc,prc){

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
	}

	// importing fw/1 main


	property userService;
	property securityService;
	property beanFactory;
	property validationService;
	property formatterService;


	function init (fw) {
		variables.fw = arguments.fw;
	}

	function error (rc) {
		for (var line in request.exception.cause.tagcontext) {
			writeoutput(line.raw_trace);
			writeoutput("<br />");
		}
		writedump(request.exception);
		abort;
	}

	function before (rc) {
		rc.xeh.processLogout = 'main.processLogout';
		rc.xeh.viewAccountDetail = 'userManagement.viewAccountDetail';
		rc.xeh.userManagementIndex = 'userManagement.index';

		rc.controllerName = "main";
	}

	function after (rc) {

	}

	function checkAuthorization (rc) {
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
			relocate(securityService.getLoginFormItem());
		}
	}

	function setupSession (rc) {
		session.user = userService.load(0);
		session.messenger = beanFactory.getBean("Messenger");
		session.flash = beanFactory.getBean("FlashStorage");
	}

	function index (rc) {

	}

	function viewLogin (rc) {
		if (session.user.isLoggedIn()) {
			relocate("main.index");
		}

		rc.xeh.processLogin = "main.processLogin";
		rc.xeh.viewForgotPassword = "main.viewForgotPassword";
		fw.setView("main.login");
	}

	function processLogin (rc) {
		var authenticatedUser = userService.authenticateUser(
			username=rc.username
				, password=rc.password
				, ipAddress=cgi.remote_addr);

		if ( authenticatedUser.getIntUserID() && authenticatedUser.isLoggedIn() ) {
			session.user = authenticatedUser;

			if ( authenticatedUser.getbtIsPasswordExpired() ) {
				relocate(action=securityService.getResetPasswordFormItem());
			}

			if ( structKeyExists(session, "login_requestedPage") && len(session.login_requestedPage) ) {
				var redirectTo = session.login_requestedPage;
				structDelete(session, "login_requestedPage");
				relocateCustomURL(redirectTo);
			} else {
				relocate(action='main.index');
			}
		} else {
//bad authentication
			session.messenger.addAlert(
				messageType="ERROR"
					, message="Invalid Username and/or Password"
					, messageDetail=""
					, field="username");

			relocate(action=securityService.getLoginFormItem(), queryString="##authenticationError");
		}
		fw.setView("main.login");
	}

	function processLogout (rc) {
		session.user = userService.load(0);
		relocate(action=securityService.getLoginFormItem());
	}

	function viewChangePassword (rc) {
		param name="rc.user" default=session.user;

		rc.xeh.processChangePassword = 'main.processChangePassword';
		fw.setView("main.changePassword");
	}

	function processChangePassword (rc) {
		var hasErrors = userService.validateChangePassword(rc=rc, messenger=session.messenger);

		if ( !hasErrors ) {
			userService.changePassword(intUserID=rc.userID
					, newPassword=rc.password
					, isTempPassword=false
					, requireNewPassword=false
					, setBy=session.user.getIntUserID()
					, setByIP=cgi.remote_addr);
			session.messenger.addAlert(messageType="INFO", message="The password has been successfully changed");
			relocate(action='userManagement.viewAccountDetail');
		} else {
//this wont work if we let someone change a password for someone else
			relocate(action='main.viewChangePassword');
		}
	}

	function viewForgotPassword (rc) {
		param name="rc.email" default="";

		rc.xeh.processForgotPassword = 'main.processForgotPassword';
		fw.setView("main.forgotPassword");
	}

	function processForgotPassword (rc) {
		if ( isNull(rc.email) || !len(trim(rc.email)) ) {
			relocate(action=securityService.getLoginFormItem());
		}

		var user = userService.loadByEmail(rc.email);

		if ( !user.getIntUserID() ) {
			session.messenger.addAlert(
				messageType="ERROR"
					, message="Invalid Email"
					, messageDetail="We do not have an account for that email address.  Please check the input and try again."
					, field="email");
			relocate(action='main.viewForgotPassword', persist='email');
		}

		userService.sendPasswordResetEmail(user);

		session.messenger.addAlert(
			messageType="SUCCESS"
				, message="Your temporary password has been sent to your email."
				, messageDetail="Follow the instructions in the email to login and reset your password.");

		relocate(action=securityService.getLoginFormItem());
	}

	function robots (rc) {

	}


}