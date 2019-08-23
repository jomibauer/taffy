<cfoutput>
	<cfif NOT rc.hideMenu >
		<div class="row">
			<div class="col-md-12">
				<ul class="nav nav-tabs" style="margin-bottom:15px;">
					<li class="<cfif getFullyQualifiedAction() EQ rc.xeh.viewUserList>active</cfif>"><a href="#buildUrl(rc.xeh.viewUserList)#">Manage Users</a></li>
					<li class="<cfif getFullyQualifiedAction() EQ rc.xeh.viewGroupList>active</cfif>"><a href="#buildUrl(rc.xeh.viewGroupList)#">Manage Groups</a></li>
				</ul>
			</div>
		</div>
	</cfif>
</cfoutput>