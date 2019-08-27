<cfoutput>
	<cfinclude template="includes/_menu.cfm" />

	<div class="row">
		<div class="col">

			<div class="row">
				<div class="col-6">
					<h2>Users</h2>
				</div>
				<div class="col-6">
					<a href="#event.buildLink(rc.xeh.viewUserCreate)#" class="float-right btn btn-primary">Create New User</a>
				</div>
			</div>

			<br />

			<table id="usersTable" class="table table-sm table-hover table-bordered table-striped">
				<thead>
					<tr>
						<th>
							Username
						</th>
						<th>
							Email
						</th>
						<th>
							Name
						</th>
						<th>
							Status
						</th>
						<th>
							Password Last Set
						</th>
						<th>
							Last Login
						</th>
					</tr>
				</thead>
				<tbody>
					<cfloop query="rc.qUsers">
						<tr class="clickable" data-href="#event.buildLink(rc.xeh.viewUserDetail & '/' & rc.qUsers.intUserID)#">
							<td>
								#rc.qUsers.vcUsername#
							</td>
							<td>
								#rc.qUsers.vcEmail#
							</td>
							<td>
								#rc.qUsers.vcFirstName# #rc.qUsers.vcLastName#
							</td>
							<td class="text-center">
								<cfif rc.qUsers.btIsActive>
									<span class="text-white font-weight-bold bg-success pl-2 pr-2">Active</span>
								<cfelseif rc.qUsers.btIsLocked>
									<span class="text-white font-weight-bold bg-danger pl-2 pr-2">Locked</span>
								<cfelse>
									<span class="text-white font-weight-bold bg-danger pl-2 pr-2">Inactive</span>
								</cfif>
							</td>
							<td class="text-right">
								<cfif rc.qUsers.btIsPasswordExpired>
									<span class="label label-danger">Expired</span>
								</cfif>
								#rc.formatterService.formatDate(rc.qUsers.dtPasswordLastSetOn)#
							</td>
							<td class="text-right">
								#rc.formatterService.formatDate(rc.qUsers.dtLastLoggedInOn)#
							</td>
						</tr>
					</cfloop>
				</tbody>
			</table>
		</div>
	</div>

	<script src="includes/js/userManagement/userList.js"></script>

</cfoutput>