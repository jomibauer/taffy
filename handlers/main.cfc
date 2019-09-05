component extends="coldbox.system.EventHandler" {

	property name="userService" inject="userService";
	property name="groupService" inject="groupService";
	property name="formatterService" inject="formatterService";

/************************************ APPLICATION-WIDE IMPLICIT ACTIONS *******************************************/

	function onAppStart(event,rc,prc){

	}

	function onAppEnd(event,rc,prc){

	}

	function onRequestStart(event,rc,prc){
		// exit handlers used in navbar
		prc.xeh.processLogout = "main/processLogout";
		prc.xeh.viewAccountDetail = "userManagement/viewAccountDetail";
		prc.xeh.userManagementIndex = "userManagement/index";
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
		writeDump(exception.getExceptionStruct());
		abort;
	}

	/************************************ END APPLICATION-WIDE IMPLICIT ACTIONS *******************************************/

	/************************************ IMPLICIT ACTIONS *******************************************/

	function preHandler(event,rc,prc){

	}

	function postHandler(event,rc,prc){

	}

	/************************************ END IMPLICIT ACTIONS *******************************************/

	function index (event,rc,prc) {

	}

	function viewLogin (event,rc,prc) {
		if (session.user.isLoggedIn()) {
			relocate(event="main/index");
		}

		prc.xeh.processLogin = "main/processLogin";
		prc.xeh.viewForgotPassword = "main/viewForgotPassword";
		event.setView("main/login");
	}

	function processLogin (event,rc,prc) {
		//SecurityInterceptor should pick up and redirect to requested url, if not, default to index
		relocate(event="main/index");
	}

	function viewChangePassword (event,rc,prc) {
		prc.user = session.user;

		prc.xeh.processChangePassword = "main/processChangePassword";
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
			relocate(event="userManagement/viewAccountDetail");
		} else {
			//this wont work if we let someone change a password for someone else
			relocate(event="main/viewChangePassword");
		}
	}

	function viewForgotPassword (event,rc,prc) {
		param name="rc.email" default="";

		prc.xeh.processForgotPassword = "main/processForgotPassword";
		event.setView("main/forgotPassword");
	}

	function processForgotPassword (event,rc,prc) {
		if ( isNull(rc.email) || !len(trim(rc.email)) ) {
			relocate(event=getSetting("security_loginFormItem"));
		}

		var user = userService.loadByEmail(rc.email);

		if ( !user.getIntUserID() ) {
			session.messenger.addAlert(
				messageType="ERROR"
					, message="Invalid Email"
					, messageDetail="We do not have an account for that email address.  Please check the input and try again."
					, field="email");

            flash.put(name="email", value=rc.email);
			relocate(event="main/viewForgotPassword");
		}

		userService.sendPasswordResetEmail(user);

		session.messenger.addAlert(
			messageType="SUCCESS"
				, message="Your temporary password has been sent to your email."
				, messageDetail="Follow the instructions in the email to login and reset your password.");

		relocate(event=getSetting("security_loginFormItem"));
	}

	function robots (event,rc,prc) {

	}
}