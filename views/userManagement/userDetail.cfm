<cfoutput>

	<cfinclude template="includes/_menu.cfm" />

	<cfif NOT prc.isAccountDetail>
		<div class="row">
			<div class="col">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#event.buildLink(prc.xeh.viewUserList)#">User List</a></li>
					<li class="breadcrumb-item">
						<a href="#event.buildLink(prc.xeh.viewUserDetail & "/" & rc.user.getIntUserID())#">
							User: #rc.user.getVcFirstName()# #rc.user.getVcLastName()#
						</a>
					</li>
				</ol>
			</div>
		</div>
	<cfelse>
		<br />
		<br />
	</cfif>

	<div class="row">
		<div class="col-8">

			<h2>#rc.user.getVcFirstName()# #rc.user.getVcLastName()#</h2>

			<table class="table table-condensed table-detail">
				<tr>
					<th width="200">
						Email:
					</th>
					<td>
						#rc.user.getVcEmail()#
					</td>
				</tr>
				<tr>
					<th>
						Username:
					</th>
					<td>
						#rc.user.getVcUsername()#
						<cfif rc.user.getBtIsActive()>
							<span class="text-white font-weight-bold bg-success pl-1 pr-1">Active</span>
						<cfelse>
							<span class="text-white font-weight-bold bg-danger pl-1 pr-1">Inactive</span>
						</cfif>
					</td>
				</tr>
				<tr>
					<th>
						Name:
					</th>
					<td>
						#rc.user.getNameDisplay()#
					</td>
				</tr>
				<tr>
					<th>
						Address:
					</th>
					<td>
						#rc.user.getAddressDisplay()#
					</td>
				</tr>
				<tr>
					<th>
						Phone:
					</th>
					<td>
						#prc.formatterService.formatPhone(rc.user.getVcPhone1())#
					</td>
				</tr>
				<cfif len(trim(rc.user.getVcPhone2()))>
					<tr>
						<th>
							Alternate Phone:
						</th>
						<td>
							#prc.formatterService.formatPhone(rc.user.getVcPhone2())#
						</td>
					</tr>
				</cfif>
				<cfif NOT prc.isAccountDetail>
					<tr>
						<th>
							Created:
						</th>
						<td>
							#rc.createdBy.getVcFirstName()# #rc.createdBy.getVcLastName()# &##64; #prc.formatterService.formatDateTime(rc.user.getDtCreatedOn())#
						</td>
					</tr>
					<cfif dateCompare(rc.user.getDtModifiedOn(), getSetting("never")) != 0>
						<tr>
							<th>
								Last Modified:
							</th>
							<td>
								#rc.lastModifiedBy.getVcFirstName()# #rc.lastModifiedBy.getVcLastName()# &##64; #prc.formatterService.formatDateTime(rc.user.getDtModifiedOn())#
							</td>
						</tr>
					</cfif>
					<tr>
						<th>
							Password Last Set:
						</th>
						<td>
							#rc.passwordLastSetBy.getVcFirstName()# #rc.passwordLastSetBy.getVcLastName()# &##64; #prc.formatterService.formatDateTime(rc.user.getDtPasswordLastSetOn())#
							<cfif rc.user.getBtIsPasswordExpired()><span class="label label-danger">Expired</span></cfif>
						</td>
					</tr>

					<tr>
						<th>
							Last Login:
						</th>
						<td>
							<cfif dateCompare(rc.user.getDtLastLoggedInOn(), getSetting("never")) != 0>
								#prc.formatterService.formatDateTime(rc.user.getDtLastLoggedInOn())#
							<cfelse>
								Never
							</cfif>
						</td>
					</tr>
				</cfif>
			</table>
		</div>
		<div class="col-4">
			<div class="card bg-light mb-3">
				<div class="card-body">

					<cfif prc.isAccountDetail>
						<strong>Your Groups</strong>
					<cfelse>
						<strong>#rc.user.getVcFirstName()# #rc.user.getVcLastName()#'s Groups</strong>
					</cfif>

					<br />

					<ul id="groupUL" class="p-0 mt-1">
						<cfloop array="#rc.user.getUserGroups()#" item="group">
							<li class="#(session.user.isUserInGroup('ADMIN') OR session.user.isUserInGroup('USERMANAGE') ? 'group-item-remove' : '')# list-group-item" data-user-id="#rc.userID#" data-group-id="#group.getIntGroupID()#" id="group_#group.getIntGroupID()#">
								#group.getVcGroupName()#
								<span class="oi oi-x float-right text-white"></span>
							</li>
						</cfloop>
					</ul>

					<cfif NOT prc.isAccountDetail AND NOT rc.user.getBtIsProtected() >
						<select id="newGroupID" class="addGroupSelect form-control" >
							<option value="-1" data-user-id="-1" data-group-id="-1" disabled="true" selected="true">- Choose Group -</option>
							<cfloop array="#prc.groups#" item="group">
								<option class="newGroupOption" value="#group.getIntGroupID()#" data-user-id="#rc.user.getIntUserID()#" data-group-id="#group.getIntGroupID()#">#group.getVcGroupName()#</option>
							</cfloop>
						</select>
					</cfif>

				</div>
			</div>
			<div class="card bg-light mb-3">
				<div class="card-body">

					<cfif prc.isAccountDetail>
						<p>To update your account, click the button below.</p>
						<a href="#event.buildLink(prc.xeh.viewUpdateAccount)#" class="btn btn-primary">Update Account</a>
					<cfelse>
						<p>To update this user, click the button below.</p>
						<a href="#event.buildLink(prc.xeh.viewUserUpdate & "/" & rc.userID)#" class="btn btn-primary">Update User</a>
					</cfif>

				</div>
			</div>

			<cfif prc.isAccountDetail>
				<div class="card bg-light mb-3">
					<div class="card-body">
						<p>To change your password, click the button below.</p>
						<a href="#event.buildLink(prc.xeh.viewChangePassword)#" class="btn btn-primary">Change Password</a>
					</div>
				</div>
			<cfelse>
				<div class="card bg-light mb-3">
					<div class="card-body">
						<p>To require the user to change their password, click the button below.</p>
						<a href="#event.buildLink(to=prc.xeh.processUserExpirePassword, queryString="userID=" & rc.userID)#" class="btn btn-primary">Require user to Change Password</a>
					</div>
				</div>


				<cfif rc.user.getBtIsActive()>
					<div class="card bg-light mb-3">
						<div class="card-body">
							<p>To deactivate this user, click the button below.</p>
                            <a href="#event.buildLink(to=prc.xeh.processUserDeactivate, queryString="userID=" & rc.userID)#" class="btn btn-warning">Deactivate User</a>
						</div>
					</div>
				<cfelse>
					<div class="card bg-light mb-3">
						<div class="card-body">
							<p>To activate this user, click the button below.</p>
                            <a href="#event.buildLink(to=prc.xeh.processUserActivate, queryString="userID=" & rc.userID)#" class="btn btn-primary">Activate User</a>
						</div>
					</div>
				</cfif>
			</cfif>

			<cfif NOT prc.isAccountDetail AND NOT rc.user.btIsProtected()>
				<div class="card bg-light mb-3">
					<div id="removeCardBody" class="card-body">
						<p>To remove this user, click the button below.</p>
						<a id="removeBtn" class="btn btn-primary text-white">Remove User</a>
					</div>
					<div id="removeCardBodyConfirm" class="card-body" style="display:none;">
						<p class="text-danger font-weight-bold" >Are you sure you want to remove this user? This cannot be undone.</p>
						<a id="removeBtnCancel" class="btn btn-primary text-white mb-3">No, cancel removing this user</a>
						<a href="#event.buildLink(prc.xeh.processUserRemove & "?userID=" & rc.userID)#" class="btn btn-danger text-white">Yes, remove this user</a>
					</div>
				</div>
			</cfif>
		</div>
	</div>
	<cfif NOT prc.isAccountDetail AND NOT rc.user.getBtIsProtected() >
		<script>
			var PAGE = {
				arAllGroups: JSON.parse('#prc.groupsJSON#'),
				userID: #rc.user.getIntUserID()#,
				xeh: {
					ajaxAddUserToGroup: '#event.buildLink(prc.xeh.ajaxAddUserToGroup)#',
					ajaxRemoveUserFromGroup: '#event.buildLink(prc.xeh.ajaxRemoveUserFromGroup)#'
				}
			}
		</script>

		<script src="includes/js/userManagement/userDetail.js"></script>
	</cfif>
</cfoutput>