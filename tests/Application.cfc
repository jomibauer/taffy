/**
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
*/
component{

	// APPLICATION CFC PROPERTIES
	this.name = "ColdBoxTestingSuite" & hash(getCurrentTemplatePath());
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0,6,0,0);
	this.applicationTimeout = createTimeSpan(2,0,0,0);
	this.datasource = getDSN();

	// Create testing mapping
	this.mappings[ "/tests" ] = getDirectoryFromPath( getCurrentTemplatePath() );

	// Map back to its root
	rootPath = REReplaceNoCase( this.mappings[ "/tests" ], "tests(\\|/)", "" );
	this.mappings["/root"]   = rootPath;

	private string function getDSN() {
		return "coldboxbase";
	}

	public void function onRequestEnd() {
		structDelete( application, "cbController" );
		structDelete( application, "wirebox" );
	}
}