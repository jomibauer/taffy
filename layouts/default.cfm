<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<cfoutput>#iif( CGI.HTTPS eq "on", de("https"), de("http") ) & "://" & CGI.HTTP_HOST & getDirectoryFromPath( CGI.SCRIPT_NAME )#</cfoutput>" />

		<title><cfoutput>#getSetting("appName")#</cfoutput></title>
<!--- 		<link rel="shortcut icon" href="includes/img/favicon.ico" /> --->

		<link rel="stylesheet" type="text/css" href="../includes/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="../includes/css/bootstrap-grid.min.css" />
		<link rel="stylesheet" type="text/css" href="../includes/css/bootstrap-reboot.min.css" />
		<link rel="stylesheet" type="text/css" href="../includes/css/jquery-ui-1.11.2-smoothness.css" />
		<link rel="stylesheet" type="text/css" href="../includes/css/dataTables.min.css" />
		<link rel="stylesheet" type="text/css" href="../includes/css/dataTables.bootstrap4.min.css" />
		<link rel="stylesheet" type="text/css" href="../includes/css/open-iconic-bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="../includes/css/app.css" />
		<link rel="stylesheet" type="text/css" href="../includes/css/default.css" />

		<script type="text/javascript" src="../includes/js/jquery-2.1.3.min.js"></script>
		<script type="text/javascript" src="../includes/js/jquery-ui-1.11.2.min.js"></script>
		<script type="text/javascript" src="../includes/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../includes/js/dataTables.min.js"></script>
		<script type="text/javascript" src="../includes/js/dataTables.bootstrap4.min.js"></script>

	</head>
	<body>

		<cfinclude template="includes/navbar.cfm" />
		<br />
		<div class="container">
			<div id="primary">
				<cfinclude template="includes/messages.cfm" />
				<cfoutput>#renderView()#</cfoutput>
			</div>
		</div>

	</body>
</html>
<cfset session.messenger.clear() />
