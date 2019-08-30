<cfoutput>

	<nav class="navbar navbar-dark bg-dark navbar-expand-lg" role="navigation">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<a class="navbar-brand" href="#event.buildLink("main.index")#">#getSetting("appName")#</a>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="##navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarText">
				<ul class="navbar-nav mr-auto">
					<cfif session.user.isLoggedIn()>
						<cfif session.user.isUserInGroup("ADMIN")>
							<li class="nav-item <cfif rc.controllerName EQ "main">active</cfif>">
								<a class="nav-link" href="#getSetting("appMapping")#/testbox/tests/runner.cfm">Tests</a>
							</li>
						</cfif>
					</cfif>
				</ul>

				<ul class="navbar-nav navbar-right">
					<cfif session.user.isLoggedIn()>
						<cfif session.user.isUserInGroup("ADMIN")>
							<li class="nav-item <cfif rc.controllerName EQ "userManagement">active</cfif>">
								<a class="nav-link" href="#event.buildLink(rc.xeh.userManagementIndex)#">User Management</a>
							</li>
						</cfif>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="##" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								#session.user.getVcFirstName()#&nbsp;#session.user.getVcLastName()#
							</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
								<a class="dropdown-item" href="#event.buildLink(rc.xeh.viewAccountDetail)#">Account Settings</a>
								<a class="dropdown-item" href="#event.buildLink(rc.xeh.processLogout)#">Logout</a>
							</div>
						</li>
					</cfif>
				</ul>
			</div>
		</div>
	</nav>

</cfoutput>

