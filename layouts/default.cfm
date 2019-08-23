<!DOCTYPE html>
<html>
	<head>
		<base href="<cfoutput>#iif( CGI.HTTPS eq "on", de("https"), de("http") ) & "://" & CGI.HTTP_HOST & getDirectoryFromPath( CGI.SCRIPT_NAME )#</cfoutput>" />

		<title><cfoutput>#getSetting("appName",false,'')#</cfoutput></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- Bootstrap -->

		<link href="/includes/css/jquery-ui-1.11.2-smoothness.css" rel="stylesheet">
		<link href="/includes/css/bootstrap.min.css" rel="stylesheet">
		<link href="/includes/css/bootstrap-toggle.min.css" rel="stylesheet">
		<link href="/includes/css/app.css" rel="stylesheet">

  		<script src="/includes/js/jquery-2.1.3.min.js"></script>
  		<script src="/includes/js/jquery-ui-1.11.2.min.js"></script>
  		<script src="/includes/js/lodash-3.6.0.min.js"></script>
		<script src="/includes/js/bootstrap.min.js"></script>
		<script src="/includes/js/bootstrap-toggle.min.js"></script>
        <script src="/includes/js/jscolor.js"></script>

		<!--- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries --->
		<!--- WARNING: Respond.js doesn't work if you view the page via file:// --->
		<!--[if lt IE 9]>
	<script src="/includes/js/html5shiv-3.7.0.js"></script>
	<script src="/includes/js/respond-1.3.0.min.js"></script>
	<![endif]-->

		<script>
			PAGE = {
				xeh: {}
			};
		</script>
	</head>
	<body>
		<cfinclude template="includes/navbar.cfm" />
		<div class="container">
			<cfinclude template="includes/messages.cfm" />
			<cfoutput>#renderView()#</cfoutput>
		</div>


	</body>
</html>
<cfset session.messenger.clear() />