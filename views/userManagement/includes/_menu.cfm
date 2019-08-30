<cfoutput>
	<cfif NOT prc.hideMenu>
		<div class="row">
			<div class="col">
				<ul class="nav nav-tabs" style="margin-bottom:15px;">
					<li class="nav-item">
						<a class="nav-link <cfif event.getCurrentEvent() EQ prc.xeh.viewUserList>active</cfif>" href="#event.buildLink(prc.xeh.viewUserList)#">Manage Users</a>
					</li>
					<li class="nav-item">
						<a class="nav-link <cfif event.getCurrentEvent() EQ prc.xeh.viewGroupList>active</cfif>" href="#event.buildLink(prc.xeh.viewGroupList)#">Manage Groups</a>
					</li>
				</ul>
			</div>
		</div>
	</cfif>
</cfoutput>