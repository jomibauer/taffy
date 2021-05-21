<cfoutput>

	<cfinclude template="includes/_menu.cfm" />

	<div class="row">
    	<div class="col">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#event.buildLink(prc.xeh.viewUserList)#">User List</a></li>
				<li class="breadcrumb-item"><a href="#event.buildLink(prc.xeh.viewUserCreate)#">Create New User</a></li>
			</ol>
		</div>
	</div>

	<form class="form-horizontal" action="#event.buildLink(prc.xeh.processUserCreate)#" method="POST" id="userCreateForm">
		<div class="row">
			<div class="col">
				<h2>Create User</h2>
				<hr />

				<div class="row mb-3">
					<label class="control-label col-3 label-required" for="username">Username:</label>
					<div class="col-5">
						<input type="text" id="username" name="vcUsername" class="form-control <cfif session.messenger.fieldHasAlert('vcUsername')>is-invalid</cfif>" value="#rc.user.getVcUsername()#" />
					</div>
					<div class="col-4">
						<span class="help-block" id="username_loading" style="display:none;"><img src="includes/img/ajax-loader.gif" /></span>
						<span class="help-block" id="username_ok" style="display:none;"><span class="oi oi-check"></span></span>
						<span class="help-block" id="username_warning" style="display:none;">
							<span class="oi oi-warning"></span> That username is already assigned.
						</span>
						<span class="help-block" id="username_invalid" style="display:none;">
							<span class="oi oi-warning"></span> Username is not valid.
						</span>
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3 label-required" for="email">Email:</label>
					<div class="col-5">
						<input type="text" id="email" name="vcEmail" class="form-control <cfif session.messenger.fieldHasAlert('vcEmail')>is-invalid</cfif>" value="#rc.user.getVcEmail()#" />
					</div>
					<div class="col-4">
						<span class="help-block" id="email_loading" style="display:none;"><img src="includes/img/ajax-loader.gif" /></span>
						<span class="help-block" id="email_ok" style="display:none;"><span class="oi oi-check"></span></span>
						<span class="help-block" id="email_warning" style="display:none;">
							<span class="oi oi-warning"></span> That email address is already assigned.
						</span>
						<span class="help-block" id="email_invalid" style="display:none;">
							<span class="oi oi-warning"></span> Email address is not valid.
						</span>
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3" for="namePrefix">Prefix:</label>
					<div class="col-5">
						<select class="form-control" name="vcNamePrefix" id="namePrefix <cfif session.messenger.fieldHasAlert("vcNamePrefix")>has-error</cfif>">
							<option value="" <cfif rc.user.getVcNamePrefix() EQ ""> selected="true"</cfif>></option>
							<option value="Ms." <cfif rc.user.getVcNamePrefix() EQ "Ms."> selected="true"</cfif>>Ms.</option>
							<option value="Mrs." <cfif rc.user.getVcNamePrefix() EQ "Mrs."> selected="true"</cfif>>Mrs.</option>
							<option value="Mr." <cfif rc.user.getVcNamePrefix() EQ "Mr."> selected="true"</cfif>>Mr.</option>
							<option value="Dr." <cfif rc.user.getVcNamePrefix() EQ "Dr."> selected="true"</cfif>>Dr.</option>
						</select>
					</div>
					<div class="col-4">
						<cfif session.messenger.fieldHasAlert("vcNamePrefix")><span class="help-block">#session.messenger.getAlertForField("vcNamePrefix").message#</span></cfif>
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3 label-required" for="name">First Name:</label>
					<div class="col-5">
						<input type="text" id="firstName" name="vcFirstName" class="form-control <cfif session.messenger.fieldHasAlert('vcFirstName')>is-invalid</cfif>" value="#rc.user.getVcFirstName()#" />
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3" for="name">Middle Name:</label>
					<div class="col-5">
						<input type="text" id="middleName" name="vcMiddleName" class="form-control <cfif session.messenger.fieldHasAlert('vcMiddleName')>is-invalid</cfif>" value="#rc.user.getVcMiddleName()#" />
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3 label-required" for="name">Last Name:</label>
					<div class="col-5">
						<input type="text" id="lastName" name="vcLastName" class="form-control <cfif session.messenger.fieldHasAlert('vcLastName')>is-invalid</cfif>" value="#rc.user.getVcLastName()#" />
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3" for="nameSuffix">Suffix:</label>
					<div class="col-5">
						<input type="text" id="nameSuffix" name="vcNameSuffix" class="form-control <cfif session.messenger.fieldHasAlert("vcNameSuffix")>has-error</cfif>" value="#rc.user.getVcNameSuffix()#" />
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3" for="generatePassword">Password Option:</label>
					<div class="col-5">
						<select name="generatePassword" id="generatePassword" class="form-control <cfif session.messenger.fieldHasAlert("generatePassword")>has-error</cfif>">
							<option value="true" <cfif rc.generatePassword>selected="true"</cfif>>Generate Temporary Password For User</option>
							<option value="false" <cfif NOT rc.generatePassword>selected="true"</cfif>>Provide Password for User</option>
						</select>
						<cfif session.messenger.fieldHasAlert("generatePassword")><span class="help-block">#session.messenger.getAlertForField("generatePassword").message#</span></cfif>
					</div>
				</div>

				<div class="card bg-light mb-3" id="passwordQuestionsWell" style="display:none;">
					<div class="form-group row card-body mb-0 pb-0">
						<label class="control-label col-3" for="showPasswordText">Show Passwords:</label>
						<div class="col-5">
							<input type="checkbox" id="showPasswordText" class="checkbox mt-2" value="true" />
						</div>
					</div>
					<div class="form-group row card-body mb-0 pb-0 passwordInputControlGroup <cfif session.messenger.fieldHasAlert("password")>has-error</cfif>">
						<label class="control-label col-3" for="password">Password:</label>
						<div class="col-5">
							<input type="password" id="password" name="password" class="form-control passwordInput" value="" />
						</div>
						<div class="col-4">
							<span class="help-block passwordsDontMatchErrorMessage mt-0" style="display:none;">The passwords do not match. Please try again.</span>
							<span class="help-block otherPasswordErrorMessage mt-0" <cfif NOT session.messenger.fieldHasAlert("password")>style="display:none;"</cfif>>#session.messenger.getAlertForField("password").message#</span>
						</div>
					</div>
					<div class="form-group row card-body mb-0 pb-0 passwordInputControlGroup <cfif session.messenger.fieldHasAlert("password2")>has-error</cfif>">
						<label class="control-label col-3" for="password2">Password Again:</label>
						<div class="col-5">
							<input type="password" id="password2" name="password2" class="form-control passwordInput" value="" />
						</div>
						<div class="col-4">
							<span class="help-block passwordsDontMatchErrorMessage mt-0" style="display:none;">The passwords do not match. Please try again.</span>
							<span class="help-block otherPasswordErrorMessage mt-0" <cfif NOT session.messenger.fieldHasAlert("password")>style="display:none;"</cfif>>#session.messenger.getAlertForField("password").message#</span>
						</div>
					</div>

					<div class="form-group row card-body mb-0 pb-0 passwordInputControlGroup <cfif session.messenger.fieldHasAlert("password2")>has-error</cfif>">
						<label class="control-label col-3" for="requireUserToChangePassword">&nbsp;</label>
						<div class="col-1">
        					<input type="checkbox" class="checkbox mt-2" name="requireUserToChangePassword" id="requireUserToChangePassword" value="true" <cfif rc.requireUserToChangePassword>checked="true"</cfif> />
						</div>
						<div class="col-4">
    						<label for="requireUserToChangePassword">Require user to change password at first login</label>
						</div>
					</div>

					<div class="form-group row card-body mb-0 passwordInputControlGroup <cfif session.messenger.fieldHasAlert("password2")>has-error</cfif>">
						<label class="control-label col-3" for="sendLoginInstructions">&nbsp;</label>
						<div class="col-1">
        					<input type="checkbox" class="checkbox mt-2" name="sendLoginInstructions" id="sendLoginInstructions" value="true" <cfif rc.sendLoginInstructions>checked="true"</cfif> />
						</div>
						<div class="col-4">
    						<label for="sendLoginInstructions">Send Login Instructions</label><br />
							<div class="help-inline" style="font-weight:bold;color:##c09853;display:none;" id="passwordClearTextWarning"><i class="glyphicon glyphicon-warning-sign"></i> Warning: Password will be sent in clear text in the email.</div>
						</div>
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3" for="address1">Address 1:</label>
					<div class="col-5">
						<input type="text" id="address1" name="vcAddress1" class="form-control <cfif session.messenger.fieldHasAlert("vcAddress1")>has-error</cfif>" value="#rc.user.getVcAddress1()#" />
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3" for="address2">Address 2:</label>
					<div class="col-5">
						<input type="text" id="address2" name="vcAddress2" class="form-control <cfif session.messenger.fieldHasAlert("vcAddress2")>has-error</cfif>" value="#rc.user.getVcAddress2()#" />
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3" for="city">City:</label>
					<div class="col-5">
						<input type="text" id="city" name="vcCity" class="form-control <cfif session.messenger.fieldHasAlert("vcCity")>has-error</cfif>" value="#rc.user.getVcCity()#" />
					</div>
				</div>

				<div id="state-form-group" class="row mb-3">
					<label class="control-label col-3" for="state">State:</label>
					<div class="col-5">
						<input type="text" id="state" name="vcState" class="form-control has-error <cfif session.messenger.fieldHasAlert("vcState")>has-error</cfif>" value="#rc.user.getVcState()#" />
					</div>
					<div>
						<span class="help-block" id="state_valid" style="display:none;"><span class="oi oi-check"></span></span>
						<span class="help-block" id="state_invalid" style="display:none;"><span class="oi oi-warning"></span> Invalid state.</span>
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3" for="postalCode">Postal Code:</label>
					<div class="col-5">
						<input type="text" id="postalCode" name="vcPostalCode" class="form-control <cfif session.messenger.fieldHasAlert("vcPostalCode")>has-error</cfif>" value="#rc.user.getVcPostalCode()#" maxlength="5" />
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3" for="phone1">Primary Phone:</label>
					<div class="col-5">
						<input type="text" id="phone1" name="vcPhone1" class="form-control <cfif session.messenger.fieldHasAlert("vcPhone1")>has-error</cfif>" value="#prc.formatterService.formatPhone(rc.user.getVcPhone1())#" />
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3" for="phone2">Alternate Phone:</label>
					<div class="col-5">
						<input type="text" id="phone2" name="vcPhone2" class="form-control <cfif session.messenger.fieldHasAlert("vcPhone2")>has-error</cfif>" value="#prc.formatterService.formatPhone(rc.user.getVcPhone2())#" />
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-5 offset-3">
						<input type="hidden" name="modifiedById" value="#session.user.getVcEmail()#" />
						<input type="hidden" name="userID" value="#rc.user.getIntUserID()#" />
						<input type="submit" value="Create Account" class="float-right btn btn-primary" id="createAccountSubmitButton" />
					</div>
				</div>
			</div>

			<div class="col-5">
				<div class="card bg-light">
					<p class="card-body mb-0">Fields that are <strong>bold</strong> are required.</p>
					<p class="card-body mb-0">You will be able to add groups for this user in the next step.</p>
					<p class="card-body mb-0">
						The user will be able to edit this information for themselves
						once they log in through Account Settings.
					</p>
					<p class="card-body mb-0">
						You can choose to have the system generate a temporary password which will be emailed to the
						new user with instructions on how to log in and change their password, or you can set the
						initial password for the user and optionally send it in an email.
					</p>
				</div>
			</div>
		</div>
	</form>

	<script>
		var PAGE = {
			userID: #rc.user.getIntUserID()#,
			xeh: {
				ajaxIsUsernameAvailable: '#event.buildLink(prc.xeh.ajaxIsUsernameAvailable)#',
				ajaxIsEmailAvailable: '#event.buildLink(prc.xeh.ajaxIsEmailAvailable)#'
			},

			// @jquery-autocomplete (<- search for this tag to find other places where jquery-autocomplete is being documented)
			// these values will be used in the state input's auto complete functionality provided by jquery-ui.
			statesArray: #prc.statesArray#,
			numStateMatches: 0,
			stateMatch: {}
		};
	</script>

	<script src="includes/js/userManagement/userCreate.js"></script>


</cfoutput>