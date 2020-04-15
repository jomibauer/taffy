<cfoutput>
	<h3>
		<strong>Sorry, but an unexpected error has occurred. If this error persists please contact your site administrator.</strong>
		<cfset ssl = CGI.HTTPS EQ "on" ? "https" : "http" />
		<a href="#ssl & "://" & CGI.HTTP_HOST & getDirectoryFromPath( CGI.SCRIPT_NAME )#">Click here to continue</a>
	</h3>
</cfoutput>
