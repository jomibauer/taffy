/**
* Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ---
*/
component{
	// Application properties
	this.name = 'coldboxbase' & hash( getCurrentTemplatePath() ) & "2019-09-03-v3";
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0,6,0,0);
	this.applicationTimeout = createTimeSpan(2,0,0,0);
	this.datasource = getDSN();

	// COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
	COLDBOX_APP_ROOT_PATH 	= getDirectoryFromPath( getCurrentTemplatePath() );
	// The web server mapping to this application. Used for remote purposes or static purposes
	COLDBOX_APP_MAPPING   	= "";
	// COLDBOX PROPERTIES
	COLDBOX_CONFIG_FILE  	= "";
	// COLDBOX APPLICATION KEY OVERRIDE
	COLDBOX_APP_KEY 		= "";

	private string function getDSN() {
		return "fw1base";
	}

	// application start
	public boolean function onApplicationStart(){
		application.cbBootstrap = new coldbox.system.Bootstrap( COLDBOX_CONFIG_FILE, COLDBOX_APP_ROOT_PATH, COLDBOX_APP_KEY, COLDBOX_APP_MAPPING );
		application.cbBootstrap.loadColdbox();
		// it was a good dream but it doesn't work
		//application.name = application.cbcontroller.getSetting("appName");
		//application.datasource = application.cbcontroller.getSetting("datasource");

		return true;
	}

	// application end
	public void function onApplicationEnd( struct appScope ){
		arguments.appScope.cbBootstrap.onApplicationEnd( arguments.appScope );
	}

	// request start
	public boolean function onRequestStart( string targetPage ){
		// Process ColdBox Request
		application.cbBootstrap.onRequestStart( arguments.targetPage );

		return true;
	}

	public void function onSessionStart(){
		application.cbBootStrap.onSessionStart();
	}

	public void function onSessionEnd( struct sessionScope, struct appScope ){
		arguments.appScope.cbBootStrap.onSessionEnd( argumentCollection=arguments );
	}

	public boolean function onMissingTemplate( template ){
		return application.cbBootstrap.onMissingTemplate( argumentCollection=arguments );
	}

}