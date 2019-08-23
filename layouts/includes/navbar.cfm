
<cfoutput>
	<nav class="navbar navbar-default navbar-static-top navbar-inverse" role="navigation">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<a class="navbar-brand" href="##">#getSetting("appName",false,'')#</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-left">
					<cfif session.user.isLoggedIn()>
						<cfif session.user.isUserInGroup("ADMIN")>
							<li <cfif rc.controllerName EQ "main">class="active"</cfif>><a href="#buildURL("main.index")#">Main Home</a></li>
						</cfif>
					</cfif>
				</ul>

				<ul class="nav navbar-nav navbar-right">
					<cfif session.user.isLoggedIn()>
						<cfif session.user.isUserInGroup("ADMIN")>
							<li <cfif rc.controllerName EQ "userManagement">class="active"</cfif>><a href="#buildURL(rc.xeh.userManagementIndex)#">User Management</a></li>
						</cfif>
						<li class="dropdown">
							<a href="##" class="dropdown-toggle" data-toggle="dropdown">
								<i class="icon-user icon-white"></i>#session.user.getVcFirstName()# #session.user.getVcLastname()# <b class="caret"></b>
							</a>
							<ul id="actions-submenu" class="dropdown-menu">
								<li><a href="#buildURL(rc.xeh.viewAccountDetail)#">Account Settings</a></li>
								<li><a href="#buildURL(rc.xeh.processLogout)#">Logout</a></li>
							</ul>
						</li>
					</cfif>
				</ul>
			</div><!-- /.navbar-collapse -->
		</div>
	</nav>

</cfoutput>

