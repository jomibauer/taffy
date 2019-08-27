component{

	// Configure ColdBox Application
	function configure(){

		// coldbox directives
		coldbox = {
			//Application Setup
			appName 					= "ColdboxBase"
			, eventName 				= "event"
			// datasource must be set in Application.cfc

			//Development Settings
			, reinitPassword			= ""
			, handlersIndexAutoReload 	= true

			//Implicit Events
			, defaultEvent				= ""
			, requestStartHandler		= "main.onRequestStart"
			, requestEndHandler			= ""
			, applicationStartHandler 	= "main.onAppInit"
			, applicationEndHandler		= ""
			, sessionStartHandler 		= ""
			, sessionEndHandler			= ""
			, missingTemplateHandler	= ""

			//Extension Points
			, applicationHelper 		= "includes/helpers/ApplicationHelper.cfm"
			, viewsHelper				= ""
			, modulesExternalLocation	= []
			, viewsExternalLocation		= ""
			, layoutsExternalLocation 	= ""
			, handlersExternalLocation  = ""
			, requestContextDecorator 	= ""
			, controllerDecorator		= ""

			//Error/Exception Handling
			, invalidHTTPMethodHandler 	= ""
			, exceptionHandler			= "main.onException"
			, invalidEventHandler		= ""
			, customErrorTemplate		= "/coldbox/system/includes/BugReport.cfm"

			//Application Aspects
			, handlerCaching 			= false
			, eventCaching				= false
			, viewCaching				= false
			// Will automatically do a mapDirectory() on your `models` for you.
			, autoMapModels				= true
		};

		settings = {
			never 							= createDateTime(1970,1,1,0,0,0)
			, dateFormatMask 				= "yyyy-mm-dd"
			, timeFormatMask 				= "h:mm tt"
			, forgotPasswordEmailFrom 		= "donotreply@fw1base.com"
			, passwordRotation 				= 0 //you cannot use any of your last 5 passwords
			, loginInstructionsEmailFrom 	= "donotreply@fw1base.com"
			, loginURL 						= "http://coldoxbase.loc:8079/main/viewLogin"
			, security_nonSecuredHandlers 	= ""
			, security_nonSecuredItems 		= "main.test,main.viewForgotPassword,main.processForgotPassword,main.robots" //the loginFormItem, loginSubmitItem and logoutSubmitItem will be automatically added to this list
			, security_loginFormItem 		= "main.viewLogin"
			, security_loginSubmitItem 		= "main.processLogin"
			, security_logoutSubmitItem 	= "main.processLogout"
			, security_resetPasswordFormItem = "main.viewChangePassword"

		};
		// Module Directives
		modules = {
			// An array of modules names to load, empty means all of them
			include = [],
			// An array of modules names to NOT load, empty means none
			exclude = []
		};

		//Layout Settings
		layoutSettings = {
			defaultLayout = "default",
			defaultView   = ""
		};

		//Interceptor Settings
		interceptorSettings = {
			customInterceptionPoints = ""
		};

		//Register interceptors as an array, we need order
		interceptors = [
			{class="interceptors.SecurityInterceptor"}
		];

		/*
		// module setting overrides
		moduleSettings = {
			moduleName = {
				settingName = "overrideValue"
			}
		};

		// flash scope configuration
		flash = {
			scope = "session,client,cluster,ColdboxCache,or full path",
			properties = {}, // constructor properties for the flash scope implementation
			inflateToRC = true, // automatically inflate flash data into the RC scope
			inflateToPRC = false, // automatically inflate flash data into the PRC scope
			autoPurge = true, // automatically purge flash data for you
			autoSave = true // automatically save flash scopes at end of a request and on relocations.
		};

		//Register Layouts
		layouts = [
			{ name = "login",
		 	  file = "Layout.tester.cfm",
			  views = "vwLogin,test",
			  folders = "tags,pdf/single"
			}
		];
		*/

		//Conventions
		conventions = {
			handlersLocation = "handlers",
			viewsLocation 	 = "views",
			layoutsLocation  = "layouts",
			modelsLocation 	 = "domains",
			eventAction 	 = "index"
		};



		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			local = "coldboxbase.loc*"
		};


	}

	// environment functions
	function local() {
		//coldbox.customErrorTemplate = "/coldbox/system/includes/BugReport.cfm";
	}

}