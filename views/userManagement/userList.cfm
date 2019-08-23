<cfoutput>
	<cfinclude template="includes/_menu.cfm" />

	<div class="row">
		<div class="col-md-12">
			<form class="form-inline">
				<p>Search by user&apos;s first name, last name, email address, <strong>OR</strong> username.</p>
				<div class="form-group">
					<input id="inpUserSearch" name="q" value="#rc.q#" type="text" class="form-control col-md-3" placeholder="search">
				</div>
				<span id="search_loading" style="display:none;"><img src="assets/img/ajax-loader.gif" /></span>
			</form>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<h2>Users</h2>

			<table id="usersTable" class="table table-condensed table-bordered table-striped">
				<tr>
					<th style="width:225px;">
						Username
					</th>
					<th>
						Email
					</th>
					<th style="width:250px;">
						Name
					</th>
					<th style="width:50px;">
						&nbsp;
					</th>
					<th style="width:50px;">
						&nbsp;
					</th>
					<th style="width:150px;">
						Password Last Set
					</th>
					<th style="width:150px;">
						Last Login
					</th>
				</tr>
				<tbody>
					<cfloop query="rc.qUsers">
						<tr>
							<td>
								<a href="#buildURL(rc.xeh.viewUserDetail & "/" & rc.qUsers.intUserID)#">#rc.qUsers.vcUsername#</a>
							</td>
							<td>
								<a href="#buildURL(rc.xeh.viewUserDetail & "/" & rc.qUsers.intUserID)#">#rc.qUsers.vcEmail#</a>
							</td>
							<td>
								#rc.qUsers.vcFirstname# #rc.qUsers.vcLastname#
							</td>
							<td style="text-align:center;">
								<cfif rc.qUsers.btIsActive>
									<span class="label label-success">Active</span>
								<cfelse>
									<span class="label label-danger">Inactive</span>
								</cfif>
							</td>
							<td style="text-align:center;">
								<cfif rc.qUsers.btIsLocked>
									<span class="label label-danger">Locked</span>
								</cfif>
							</td>
							<td>
								#rc.formatterService.formatDate(rc.qUsers.dtPasswordLastSetOn)#
								<cfif rc.qUsers.btIsPasswordExpired>
									<span class="label label-danger">Expired</span>
								</cfif>
							</td>
							<td>
								#rc.formatterService.formatDate(rc.qUsers.dtLastLoggedInOn)#
							</td>
						</tr>
					</cfloop>
				</tbody>
			</table>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<a href="#buildURL(rc.xeh.viewUserCreate)#" class="btn btn-primary">Create New User</a>
		</div>
	</div>

	<script>
		var PAGE = {
			xeh: {
				userDetail: '#buildURL(rc.xeh.viewUserDetail & "/")#',
				ajaxSearchUsers: '#buildURL(rc.xeh.ajaxSearchUsers)#'
			}
		};
	</script>

	<script src="/assets/js/userManagement/userList.js"></script>

</cfoutput>