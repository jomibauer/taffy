<cfoutput>

	<cfinclude template="includes/_menu.cfm" />

	<div class="row">
		<div class="col-md-12">
			<ol class="breadcrumb">
				<li><a href="#buildURL(rc.xeh.viewUserList)#">User List</a></li>
				<li><a href="#buildURL(rc.xeh.viewUserCreate)#">Create New User</a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<h2>Create New User</h2>
		</div>
	</div>

	<div class="row">
		<div class="col-md-9">
			<form class="form-horizontal" action="#buildURL(action=rc.xeh.processUserCreate)#" method="POST" id="userCreateForm">

				<div id="username-form-group" class="form-group <cfif session.messenger.fieldHasAlert("vcUsername")>has-error</cfif>">
					<label class="control-label col-md-3 label-required" for="username">Username:</label>
					<div class="col-md-5">
						<input type="text" id="username" name="vcUsername" class="form-control" value="#rc.user.getVcUsername()#" />

					</div>
					<div>
						<cfif session.messenger.fieldHasAlert("vcUsername")><span class="help-block" id="username_serverSideErrorMessage">#session.messenger.getAlertForField("vcUsername").message#</span></cfif>
						<span class="help-block" id="username_loading" style="display:none;"><img src="assets/img/ajax-loader.gif" /></span>
						<span class="help-block" id="username_ok" style="display:none;"><span class="glyphicon glyphicon-ok"></span></span>
						<span class="help-block" id="username_warning" style="display:none;"><i class="glyphicon glyphicon-warning-sign"></i> That username is already assigned.</span>
						<span class="help-block" id="username_invalid" style="display:none;"><i class="glyphicon glyphicon-warning-sign"></i> Please enter a username.</span>
					</div>
				</div>

				<div id="email-form-group" class="form-group <cfif session.messenger.fieldHasAlert("vcEmail")>has-error</cfif>">
					<label class="control-label col-md-3 label-required" for="email">Email:</label>
					<div class="col-md-5">
						<input type="text" id="email" name="vcEmail" class="form-control" value="#rc.user.getVcEmail()#" />

					</div>
					<div>
						<cfif session.messenger.fieldHasAlert("vcEmail")><span class="help-block" id="email_serverSideErrorMessage">#session.messenger.getAlertForField("vcEmail").message#</span></cfif>
						<span class="help-block" id="email_loading" style="display:none;"><img src="assets/img/ajax-loader.gif" /></span>
						<span class="help-block" id="email_ok" style="display:none;"><span class="glyphicon glyphicon-ok"></span></span>
						<span class="help-block" id="email_warning" style="display:none;"><i class="glyphicon glyphicon-warning-sign"></i> That email address is already assigned.</span>
						<span class="help-block" id="email_invalid" style="display:none;"><i class="glyphicon glyphicon-warning-sign"></i> Email address is not valid.</span>
					</div>
				</div>

				<div class="form-group <cfif session.messenger.fieldHasAlert("vcNamePrefix")>has-error</cfif>">
					<label class="control-label col-md-3" for="namePrefix">Prefix:</label>
					<div class="col-md-5">
						<select class="form-control" name="vcNamePrefix" id="namePrefix">
							<option value="" <cfif rc.user.getVcNamePrefix() EQ ""> selected="true"</cfif>></option>
							<option value="Ms." <cfif rc.user.getVcNamePrefix() EQ "Ms."> selected="true"</cfif>>Ms.</option>
							<option value="Mrs." <cfif rc.user.getVcNamePrefix() EQ "Mrs."> selected="true"</cfif>>Mrs.</option>
							<option value="Mr." <cfif rc.user.getVcNamePrefix() EQ "Mr."> selected="true"</cfif>>Mr.</option>
							<option value="Dr." <cfif rc.user.getVcNamePrefix() EQ "Dr."> selected="true"</cfif>>Dr.</option>
						</select>
						<cfif session.messenger.fieldHasAlert("vcNamePrefix")><span class="help-block">#session.messenger.getAlertForField("vcNamePrefix").message#</span></cfif>
					</div>
				</div>
				<div class="form-group <cfif session.messenger.fieldHasAlert("vcFirstName")>has-error</cfif>">
					<label class="control-label col-md-3 label-required" for="firstName">First Name:</label>
					<div class="col-md-5">
						<input type="text" id="firstName" name="vcFirstName" class="form-control" value="#rc.user.getVcFirstname()#" />
						<cfif session.messenger.fieldHasAlert("vcFirstName")><span class="help-block">#session.messenger.getAlertForField("vcFirstName").message#</span></cfif>
					</div>
				</div>
				<div class="form-group <cfif session.messenger.fieldHasAlert("vcMiddleName")>has-error</cfif>">
					<label class="control-label col-md-3" for="middleName">Middle Name:</label>
					<div class="col-md-5">
						<input type="text" id="middleName" name="vcMiddleName" class="form-control" value="#rc.user.getVcMiddleName()#" />
						<cfif session.messenger.fieldHasAlert("vcMiddleName")><span class="help-block">#session.messenger.getAlertForField("vcMiddleName").message#</span></cfif>
					</div>
				</div>
				<div class="form-group <cfif session.messenger.fieldHasAlert("vcLastName")>has-error</cfif>">
					<label class="control-label col-md-3 label-required" for="lastName">Last Name:</label>
					<div class="col-md-5">
						<input type="text" id="lastName" name="vcLastName" class="form-control" value="#rc.user.getVcLastname()#" />
						<cfif session.messenger.fieldHasAlert("vcLastName")><span class="help-block">#session.messenger.getAlertForField("vcLastName").message#</span></cfif>
					</div>
				</div>
				<div class="form-group <cfif session.messenger.fieldHasAlert("vcNameSuffix")>has-error</cfif>">
					<label class="control-label col-md-3" for="nameSuffix">Suffix:</label>
					<div class="col-md-5">
						<input type="text" id="nameSuffix" name="vcNameSuffix" class="form-control" value="#rc.user.getVcNameSuffix()#" />
						<cfif session.messenger.fieldHasAlert("vcNameSuffix")><span class="help-block">#session.messenger.getAlertForField("vcNameSuffix").message#</span></cfif>
					</div>
				</div>
				<div class="form-group <cfif session.messenger.fieldHasAlert("generatePassword")>has-error</cfif>">
					<label class="control-label col-md-3" for="generatePassword">Password Option:</label>
					<div class="col-md-5">
						<select name="generatePassword" id="generatePassword" class="form-control">
							<option value="true" <cfif rc.generatePassword>selected="true"</cfif>>Generate Temporary Password For User</option>
							<option value="false" <cfif NOT rc.generatePassword>selected="true"</cfif>>Provide Password for User</option>
						</select>
						<cfif session.messenger.fieldHasAlert("generatePassword")><span class="help-block">#session.messenger.getAlertForField("generatePassword").message#</span></cfif>
					</div>
				</div>

				<div class="well" id="passwordQuestionsWell" style="display:none;">
					<div class="checkbox" style="margin-bottom: 7px;">
						<label class="control-label col-md-3"></label>
						<div class="col-md-5">
							<input type="checkbox" id="showPasswordText" value="true" />
							<label for="showPasswordText">Show Passwords</label>
						</div>
					</div>

					<div class="form-group passwordInputFormGroup <cfif session.messenger.fieldHasAlert("password")>has-error</cfif>">
						<label class="control-label col-md-3 label-required" for="password">Password:</label>
						<div class="col-md-5">
							<input type="password" id="password" name="password" class="form-control passwordInput" value="" />
							<cfif session.messenger.fieldHasAlert("password")><span class="help-block">#session.messenger.getAlertForField("password").message#</span></cfif>
							<span class="help-block passwordsDontMatchErrorMessage" style="display:none;">The passwords do not match. Please try again.</span>
						</div>
					</div>
					<div class="form-group passwordInputFormGroup <cfif session.messenger.fieldHasAlert("password2")>has-error</cfif>">
						<label class="control-label col-md-3 label-required" for="password2">Password Again:</label>
						<div class="col-md-5">
							<input type="password" id="password2" name="password2" class="form-control passwordInput" value="" />
							<cfif session.messenger.fieldHasAlert("password2")><span class="help-block">#session.messenger.getAlertForField("password2").message#</span></cfif>
							<span class="help-block passwordsDontMatchErrorMessage" style="display:none;">The passwords do not match. Please try again.</span>
						</div>
					</div>

					<div class="checkbox" style="margin-bottom: 7px;">
						<label class="control-label col-md-3"></label>
						<div class="col-md-5">
							<input type="checkbox" name="requireUserToChangePassword" id="requireUserToChangePassword" value="true" <cfif rc.requireUserToChangePassword>checked="true"</cfif> />
							<label for="requireUserToChangePassword">Require user to change password at first login</label>
						</div>
					</div>
					<div class="checkbox" style="margin-bottom: 7px;">
						<label class="control-label col-md-3"></label>
						<div class="col-md-5">
							<input type="checkbox" name="sendLoginInstructions" id="sendLoginInstructions" value="true" <cfif rc.sendLoginInstructions>checked="true"</cfif> />
							<label for="sendLoginInstructions">Send Login Instructions</label><br />
						</div>
						<div class="col-md-4">
							<div class="help-inline" style="font-weight:bold;color:##c09853;display:none;" id="passwordClearTextWarning"><i class="glyphicon glyphicon-warning-sign"></i> Warning: Password will be sent in clear text in the email.</div>
						</div>
					</div>
				</div>

				<div class="form-group <cfif session.messenger.fieldHasAlert("vcAddress1")>has-error</cfif>">
					<label class="control-label col-md-3" for="address1">Address 1:</label>
					<div class="col-md-5">
						<input type="text" id="address1" name="vcAddress1" class="form-control" value="#rc.user.getVcAddress1()#" />
						<cfif session.messenger.fieldHasAlert("vcAddress1")><span class="help-block">#session.messenger.getAlertForField("vcAddress1").message#</span></cfif>
					</div>
				</div>
				<div class="form-group <cfif session.messenger.fieldHasAlert("vcAddress2")>has-error</cfif>">
					<label class="control-label col-md-3" for="address2">Address 2:</label>
					<div class="col-md-5">
						<input type="text" id="address2" name="vcAddress2" class="form-control" value="#rc.user.getVcAddress2()#" />
						<cfif session.messenger.fieldHasAlert("vcAddress2")><span class="help-block">#session.messenger.getAlertForField("vcAddress2").message#</span></cfif>
					</div>
				</div>
				<div class="form-group <cfif session.messenger.fieldHasAlert("vcCity")>has-error</cfif>">
					<label class="control-label col-md-3" for="city">City:</label>
					<div class="col-md-5">
						<input type="text" id="city" name="vcCity" class="form-control" value="#rc.user.getVcCity()#" />
						<cfif session.messenger.fieldHasAlert("vcCity")><span class="help-block">#session.messenger.getAlertForField("vcCity").message#</span></cfif>
					</div>
				</div>
				<div id="state-form-group" class="form-group <cfif session.messenger.fieldHasAlert("vcState")>has-error</cfif>">
					<label class="control-label col-md-3" for="state">State:</label>
					<div class="col-md-5">
						<input type="text" id="state" name="vcState" class="form-control" value="#rc.user.getVcState()#" />
						<cfif session.messenger.fieldHasAlert("vcState")><span class="help-block">#session.messenger.getAlertForField("vcState").message#</span></cfif>
					</div>
					<div>
						<span class="help-block" id="state_invalid" style="display:none;"><i class="glyphicon glyphicon-warning-sign"></i> Invalid state.</span>
					</div>
				</div>

				<div class="form-group <cfif session.messenger.fieldHasAlert("vcPostalCode")>has-error</cfif>">
					<label class="control-label col-md-3" for="postalCode">Postal Code:</label>
					<div class="col-md-5">
						<input type="text" id="postalCode" name="vcPostalCode" class="form-control" value="#rc.user.getVcPostalCode()#" maxlength="5" />
						<cfif session.messenger.fieldHasAlert("vcPostalCode")><span class="help-block">#session.messenger.getAlertForField("vcPostalCode").message#</span></cfif>
					</div>
				</div>
				<div class="form-group <cfif session.messenger.fieldHasAlert("vcPhone1")>has-error</cfif>">
					<label class="control-label col-md-3" for="phone1">Primary Phone:</label>
					<div class="col-md-5">
						<input type="text" id="phone1" name="vcPhone1" class="form-control" value="#rc.user.getFormattedPhone1()#" />
						<cfif session.messenger.fieldHasAlert("vcPhone1")><span class="help-block">#session.messenger.getAlertForField("vcPhone1").message#</span></cfif>
					</div>
				</div>
				<div class="form-group <cfif session.messenger.fieldHasAlert("vcPhone2")>has-error</cfif>">
					<label class="control-label col-md-3" for="phone2">Alternate Phone:</label>
					<div class="col-md-5">
						<input type="text" id="phone2" name="vcPhone2" class="form-control" value="#rc.user.getFormattedPhone2()#" />
						<cfif session.messenger.fieldHasAlert("vcPhone2")><span class="help-block">#session.messenger.getAlertForField("vcPhone2").message#</span></cfif>
					</div>
				</div>

				<div class="">
					<div class="col-md-offset-2 col-md-6 well">
						<input type="hidden" name="lastModifiedBy" value="#session.user.getVcUsername()#" />
						<input type="hidden" name="userID" value="#rc.user.getIntUserID()#" />
	                    <input type="hidden" name="referringAction" value="#getFullyQualifiedAction()#"/>
						<input type="submit" value="Create Account" class="btn btn-primary" id="createAccountSubmitButton" />
					</div>
				</div>
			</form>
		</div>
		<div class="col-md-3">
			<div class="well">
				<p>Fields that are <strong>bold</strong> are required.</p>
				<p>You will be able to add groups for this user in the next step.</p>
				<p>The user will be able to edit this information for themselves once they log in through
					Account Settings.</p>
				<p>You can choose to have the system generate a temporary password which will be emailed to the new user
					with instructions on how to log in and change their password, or you can set the initial password
					for the user and optionally send it in an email.</p>
			</div>
		</div>
	</div>


	<script>
		var PAGE = {
			userID: #rc.user.getIntUserID()#,
			xeh: {
				ajaxIsUsernameAvailable: '#buildURL(rc.xeh.ajaxIsUsernameAvailable)#',
				ajaxIsEmailAvailable: '#buildURL(rc.xeh.ajaxIsEmailAvailable)#'
			},

			// @jquery-autocomplete (<- search for this tag to find other places where jquery-autocomplete is being documented)
			// these values will be used in the state input's auto complete functionality provided by jquery-ui.
			// statesArray is available here in the rc because it is defined in the controller for this view
			// this way there is no need for an ajax call
			statesArray: #rc.statesArray#,
			numStateMatches: 0,
			stateMatch: {}
		};
	</script>

	<script src="/assets/js/userManagement/userCreate.js"></script>


</cfoutput>