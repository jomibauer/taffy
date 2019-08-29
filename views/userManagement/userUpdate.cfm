<cfoutput>

	<cfinclude template="includes/_menu.cfm" />

	<cfif NOT rc.isAccountDetail>
		<div class="row">
			<div class="col">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#event.buildLink(rc.xeh.viewUserList)#">User List</a></li>
					<li class="breadcrumb-item"><a href="#event.buildLink(rc.xeh.viewUserDetail & "/" & rc.user.getIntUserID())#">User: #rc.user.getVcFirstName()# #rc.user.getVcLastName()#</a></li>
					<li class="breadcrumb-item"><a href="#event.buildLink(rc.xeh.viewUserUpdate & "/" & rc.user.getIntUserID())#">Update User: #rc.user.getVcFirstName()# #rc.user.getVcLastName()#</a></li>
				</ol>
			</div>
		</div>
	<cfelse>
		<br />
		<br />
	</cfif>

	<form class="form-horizontal" action="#event.buildLink(rc.xeh.processUserUpdate)#" method="POST" id="userUpdateForm">
		<div class="row">
			<div class="col">
				<h2>Update User: #rc.user.getVcFirstName()# #rc.user.getVcLastName()#</h2>
				<hr />

				<div class="row mb-3">
					<label class="control-label col-3 label-required" for="email">Email:</label>
					<div class="col-5">
						<input type="text" id="email" name="vcEmail" class="form-control <cfif session.messenger.fieldHasAlert('vcEmail')>is-invalid</cfif>" value="#rc.user.getVcEmail()#" />
					</div>
					<div>
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
						<input type="text" id="phone1" name="vcPhone1" class="form-control <cfif session.messenger.fieldHasAlert("vcPhone1")>has-error</cfif>" value="#rc.formatterService.formatPhone(rc.user.getVcPhone1())#" />
					</div>
				</div>

				<div class="row mb-3">
					<label class="control-label col-3" for="phone2">Alternate Phone:</label>
					<div class="col-5">
						<input type="text" id="phone2" name="vcPhone2" class="form-control <cfif session.messenger.fieldHasAlert("vcPhone2")>has-error</cfif>" value="#rc.formatterService.formatPhone(rc.user.getVcPhone2())#" />
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-5 offset-3">
						<input type="hidden" name="modifiedBy" value="#session.user.getVcEmail()#" />
						<input type="hidden" name="userID" value="#rc.user.getIntUserID()#" />
						<input type="hidden" name="referringAction" value="#event.getCurrentEvent()#"/>
						<input id="updateSubmit" type="submit" value="Update" class="float-right btn btn-primary" id="updateAccountSubmitButton" />
					</div>
				</div>
			</div>

			<div class="col-5">
				<div class="card bg-light">
					<p class="card-body mb-0">Fields that are <strong>bold</strong> are required.</p>
				</div>
			</div>
		</div>
	</form>

	<script>
		var PAGE = {
			xeh: {
				ajaxIsEmailAvailable: '#event.buildLink(rc.xeh.ajaxIsEmailAvailable)#'
			},
			userID: #rc.user.getIntUserID()#,
			statesArray: JSON.parse('#rc.statesArray#')
		};
	</script>

 	<script src="includes/js/userManagement/userUpdate.js"></script>

</cfoutput>




