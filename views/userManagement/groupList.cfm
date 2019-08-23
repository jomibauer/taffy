<cfoutput>
	<cfinclude template="includes/_menu.cfm" />

	<div class="row">
		<div class="col-md-12">
			<h2>Groups</h2>

			<table id="usersTable" class="table table-condensed table-bordered table-striped">
				<tr>
					<th style="width:225px;">
						Group Name
					</th>
					<th>
						Description
					</th>
					<th>
						Group Abbr.
					</th>
					<th>
						Group Email
					</th>
				</tr>
				<tbody>
					<cfloop array="#rc.groups#" index="local.group">
						<tr>
							<td>
								<a href="#buildURL(rc.xeh.viewGroupDetail & "/" & local.group.getIntGroupID())#">#local.group.getVcGroupName()#</a>
							</td>
							<td>
								#local.group.getVcGroupDesc()#
							</td>
							<td>
								#local.group.getVcGroupAbbr()#
							</td>
							<td>
								#local.group.getVcGroupEmail()#
							</td>
						</tr>
					</cfloop>
				</tbody>
			</table>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<a href="#buildURL(rc.xeh.viewGroupCreate)#" class="btn btn-primary">Create New Group</a>
		</div>
	</div>

</cfoutput>