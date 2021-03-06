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
			, reinitPassword			= "2019mInd"
			, handlersIndexAutoReload 	= false

			//Implicit Events
			, defaultEvent				= "main.index"
			, requestStartHandler		= "main.onRequestStart"
			, requestEndHandler			= "main.onRequestEnd"
			, applicationStartHandler 	= "main.onAppStart"
			, applicationEndHandler		= "main.onAppEnd"
			, sessionStartHandler 		= "main.onSessionStart"
			, sessionEndHandler			= "main.onSessionEnd"
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
			, customErrorTemplate		= "/views/main/error.cfm"

			//Application Aspects
			, handlerCaching 			= true
			, eventCaching				= true
			, viewCaching				= true
			, singletonReload 			= false
			// Will automatically do a mapDirectory() on your `models` for you.
			, autoMapModels				= true
		};

		settings = {
			never 							= createDateTime(1970,1,1,0,0,0)
			, dateFormatMask 				= "yyyy-mm-dd"
			, timeFormatMask 				= "h:mm tt"
			, forgotPasswordEmailFrom 		= "donotreply@mind-over-data.com"
			, passwordRotation 				= 0 //you cannot use any of your last 5 passwords
			, loginInstructionsEmailFrom 	= "donotreply@mind-over-data.com"
			, loginURL 						= "http://coldboxbase.loc:8079/main/viewLogin"
			, security_loginFormItem = "main.viewLogin"
			// This is the default, make sure the settings are adjusted for particular environments.
			, maintenanceConfig				= {
				emailFrom					= "noreply@xtsuite.com"
				, emailTo					= "support@mind-over-data.com"
				, server					= "modexchange.mod-llc.com"
				, port						= 25
				, endDate					= dateAdd("yyyy", 1, now())
			}
			, acceptedMimeTypes				= "image/jpeg,text/plain,image/tiff,application/msword,application/vnd.ms-excel,application/pdf,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/x-tika-ooxml,application/octet-stream"
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
			{
				class = "interceptors.SecurityInterceptor",
				properties = {
					nonSecuredHandlers = ""
					, nonSecuredItems = "main.test,main.viewForgotPassword,main.processForgotPassword,main.robots"
					, loginFormItem = "main.viewLogin"
					, loginSubmitItem = "main.processLogin"
					, logoutSubmitItem = "main.processLogout"
					, resetPasswordFormItem = "main.viewChangePassword"
				}
			}
		];

		/*
		// module setting overrides
		moduleSettings = {
			moduleName = {
				settingName = "overrideValue"
			}
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

		// flash scope configuration
		flash = {
			scope = "cache",
			properties = {}, // constructor properties for the flash scope implementation
			inflateToRC = true, // automatically inflate flash data into the RC scope
			inflateToPRC = false, // automatically inflate flash data into the PRC scope
			autoPurge = true, // automatically purge flash data for you
			autoSave = true // automatically save flash scopes at end of a request and on relocations.
		};

		//Conventions
		conventions = {
			handlersLocation = "handlers",
			viewsLocation 	 = "views",
			layoutsLocation  = "layouts",
			modelsLocation 	 = "model.domains",
			eventAction 	 = "index"
		};

		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			local = "coldboxbase.loc*"
			, qa = "^qalucaws.*"
			, production = "mind-over-data\.com"
			, development = "mod-llc\.com"
		};
	}

	// environment functions
	function local() {
		//coldbox.customErrorTemplate = "/coldbox/system/includes/BugReport.cfm";
		coldbox.reinitPassword = "true";
		coldbox.handlersIndexAutoReload = true;
		coldbox.handlerCaching = false;
		coldbox.eventCaching = false;
		coldbox.viewCaching = false;
		coldbox.singletonReload = true;
	}

	function qa() {
		//coldbox.customErrorTemplate = "/coldbox/system/includes/BugReport.cfm";
		coldbox.reinitPassword = "true";
		coldbox.singletonReload = true;
		settings["serverName"] = "https://" & cgi.server_name & replace(cgi.script_name, "/index.cfm", "");
	}

	function production() {
		coldbox.reinitPassword = "2m0i2n0d"
		coldbox.singletonReload = true;
	}

}