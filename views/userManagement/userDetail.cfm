<cfoutput>

	<cfinclude template="includes/_menu.cfm" />

	<cfif NOT rc.isAccountDetail>
		<div class="row">
			<div class="col-md-12">
				<ol class="breadcrumb">
					<li><a href="#buildURL(rc.xeh.viewUserList)#">User List</a></li>
					<li><a href="#buildURL(rc.xeh.viewUserDetail & "/" & rc.user.getIntUserID())#">User: #rc.user.getVcFirstName()# #rc.user.getVcLastName()#</a></li>
				</ol>
			</div>
		</div>
	</cfif>

	<div class="row">
		<div class="col-md-8">

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
							<span class="label label-success">Active</span>
						<cfelse>
							<span class="label label-danger">Inactive</span>
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
						#rc.user.getFormattedPhone1()#
					</td>
				</tr>
				<cfif len(trim(rc.user.getVcPhone2()))>
					<tr>
						<th>
							Alternate Phone:
						</th>
						<td>
							#rc.user.getFormattedPhone2()#
						</td>
					</tr>
				</cfif>
				<cfif NOT rc.isAccountDetail>
					<tr>
						<th>
							Created:
						</th>
						<td>
							#rc.createdBy.getVcUsername()# &##64; #rc.formatterService.formatDateTime(rc.user.getDtCreatedOn())#
						</td>
					</tr>
					<cfif rc.user.hasBeenModified()>
						<tr>
							<th>
								Last Modified:
							</th>
							<td>
								#rc.lastModifiedBy.getVcUsername()# &##64; #rc.formatterService.formatDateTime(rc.user.getDtLastModifiedOn())#
							</td>
						</tr>
					</cfif>
					<tr>
						<th>
							Password Last Set:
						</th>
						<td>
							#rc.passwordLastSetBy.getVcUsername()# &##64; #rc.formatterService.formatDateTime(rc.user.getDtPasswordLastSetOn())#
							<cfif rc.user.getBtIsPasswordExpired()><span class="label label-danger">Expired</span></cfif>
						</td>
					</tr>

					<tr>
						<th>
							Last Login:
						</th>
						<td>
							<cfif rc.user.hasLoggedIn()>
								#rc.formatterService.formatDateTime(rc.user.getDtLastLoggedInOn())#
							<cfelse>
								Never
							</cfif>
						</td>
					</tr>
				</cfif>
			</table>
		</div>
		<div class="col-md-4">
			<div class="well">
				<cfif rc.isAccountDetail>
					<strong>Your Groups</strong>
				<cfelse>
					<strong>#rc.user.getNameDisplay()#'s Groups</strong>
				</cfif>

				<br />

				<ul id="groupUL">
					<cfloop array="#rc.user.getUserGroups()#" item="variables.group">
						<li class="list-group-item #(rc.isAccountDetail ? '' : 'userGroupItem')#" data-user-id="#rc.userID#" data-group-id="#variables.group.getIntGroupID()#" id="group_#variables.group.getIntGroupID()#">#variables.group.getVcGroupName()# <i style="float:right;" class="glyphicon glyphicon-remove icon-white"></i></li>
					</cfloop>
				</ul>

				<cfif NOT rc.isAccountDetail AND (NOT rc.user.getBtIsProtected() OR session.user.isUserInGroup("ADMIN")) >
		            <select id="newGroupID" class="addGroupSelect form-control" >
		                <option value="-1" data-user-id="-1" data-group-id="-1" disabled="true" selected="true">- Choose Group -</option>
						<cfloop array="#rc.groups#" item="variables.group">
		                    <option class="newGroupOption" value="#group.getIntGroupID()#" data-user-id="#rc.user.getIntUserID()#" data-group-id="#group.getIntGroupID()#">#group.getVcGroupName()#</option>
						</cfloop>
		            </select>
				</cfif>

			</div>
			<div class="well">
				<cfif rc.isAccountDetail>
					<p>To update your account, click the button below.</p>
					<a href="#buildURL(rc.xeh.viewUpdateAccount)#" class="btn btn-default">Update Account</a>
				<cfelse>
					<p>To update this user, click the button below.</p>
					<a href="#buildURL(rc.xeh.viewUserUpdate & "/" & rc.userID)#" class="btn btn-default">Update User</a>
				</cfif>

			</div>

			<cfif rc.isAccountDetail>
				<div class="well">
					<p>To change your password, click the button below.</p>
					<a href="#buildURL(rc.xeh.viewChangePassword)#" class="btn btn-default">Change Password</a>
				</div>
			<cfelse>
				<div class="well">
					<p>To require the user to change their password, click the button below.</p>
					<a href="#buildURL(action=rc.xeh.processUserExpirePassword, queryString="userID=" & rc.userID)#" class="btn btn-default">Require user to Change Password</a>
				</div>
			</cfif>
		</div>
	</div>

	<cfif !rc.isAccountDetail AND (!rc.user.getBtIsLocked() OR session.user.hasRole("GLOBAL", "GLOBAL", "ADMIN"))>
		<script>
			var PAGE = {
				arAllGroups: JSON.parse('#rc.groupsJSON#'),
				userID: #rc.user.getIntUserID()#,
				xeh: {
					ajaxAddUserToGroup: '#buildURL(rc.xeh.ajaxAddUserToGroup)#',
					ajaxRemoveUserFromGroup: '#buildURL(rc.xeh.ajaxRemoveUserFromGroup)#'
				}
			}
		</script>

		<script src="/assets/js/userManagement/userDetail.js"></script>
	</cfif>
</cfoutput>

