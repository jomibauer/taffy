<cfoutput>
	<cfinclude template="includes/_menu.cfm" />

	<div class="row">
		<div class="col">

			<div class="row">
				<div class="col-6">
					<h2>Groups</h2>
				</div>
				<div class="col-6">
					<a href="#event.buildLink(prc.xeh.viewGroupCreate)#" class="float-right btn btn-primary">Create New Group</a>
				</div>
			</div>

			<br />

			<table id="usersTable" class="table table-sm table-hover table-bordered table-striped">
				<thead>
					<tr>
						<th>
							Group Name
						</th>
						<th>
							Description
						</th>
						<th>
							Group Abbr.
						</th>
					</tr>
				</thead>
				<tbody>
					<cfloop array="#prc.groups#" index="local.group">
						<tr class="clickable" data-href="#event.buildLink(prc.xeh.viewGroupDetail & '/' & local.group.getIntGroupID())#">
							<td>
								#local.group.getVcGroupName()#
							</td>
							<td>
								#local.group.getVcGroupDesc()#
							</td>
							<td>
								#local.group.getVcGroupAbbr()#
							</td>
						</tr>
					</cfloop>
				</tbody>
			</table>
		</div>
	</div>

	<script src="includes/js/userManagement/userList.js"></script>

</cfoutput>