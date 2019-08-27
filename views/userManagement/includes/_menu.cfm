<cfoutput>
	<cfif NOT rc.hideMenu>
		<div class="row">
			<div class="col">
				<ul class="nav nav-tabs" style="margin-bottom:15px;">
					<li class="nav-item">
						<a class="nav-link <cfif event.getCurrentEvent() EQ rc.xeh.viewUserList>active</cfif>" href="#event.buildLink(rc.xeh.viewUserList)#">Manage Users</a>
					</li>
					<li class="nav-item">
						<a class="nav-link <cfif event.getCurrentEvent() EQ rc.xeh.viewGroupList>active</cfif>" href="#event.buildLink(rc.xeh.viewGroupList)#">Manage Groups</a>
					</li>
				</ul>
			</div>
		</div>
	</cfif>
</cfoutput>