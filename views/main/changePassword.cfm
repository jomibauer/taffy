<cfoutput>

	<div class="row">
		<div class="col-md-8">

			<h2>Change password for #rc.user.getVcFirstName()# #rc.user.getVcLastName()#</h2>

			<form id="changePasswordForm" class="form-horizontal" action="#buildURL(rc.xeh.processChangePassword)#" method="POST">
				<div class="form-group">
					<label class="control-label col-md-3" for="showPasswordText">Show Passwords:</label>
					<div class="col-md-5">
						<input type="checkbox" id="showPasswordText" class="checkbox" value="true" />
					</div>
				</div>

				<div class="form-group passwordInputControlGroup <cfif session.messenger.fieldHasAlert("password")>has-error</cfif>">
					<label class="control-label col-md-3" for="password">Password:</label>
					<div class="col-md-5">
						<input type="password" id="password" name="password" class="form-control passwordInput" value="" />
						<span class="help-block passwordsDontMatchErrorMessage" style="display:none;">The passwords do not match. Please try again.</span>
						<span class="help-block otherPasswordErrorMessage" <cfif NOT session.messenger.fieldHasAlert("password")>style="display:none;"</cfif>>#session.messenger.getAlertForField("password").message#</span>
					</div>
				</div>
				<div class="form-group passwordInputControlGroup <cfif session.messenger.fieldHasAlert("password2")>has-error</cfif>">
					<label class="control-label col-md-3" for="password2">Password Again:</label>
					<div class="col-md-5">
						<input type="password" id="password2" name="password2" class="form-control passwordInput" value="" />
						<span class="help-block passwordsDontMatchErrorMessage"style="display:none;">The passwords do not match. Please try again.</span>
						<span class="help-block otherPasswordErrorMessage" <cfif NOT session.messenger.fieldHasAlert("password")>style="display:none;"</cfif>>#session.messenger.getAlertForField("password").message#</span>
					</div>
				</div>


				<div class="form-group well">
					<div class="col-md-offset-3 col-md-5">
						<input type="hidden" name="intPasswordLastSetBy" value="#session.user.getintUserID()#" />
						<input type="hidden" name="userID" value="#rc.user.getIntUserID()#" />
						<input type="submit" value="Update Account" class="btn btn-primary" />
					</div>
				</div>
			</form>
		</div>

		<div class="col-md-4">
			<div class="well">
				<p>Please enter your new password.</p>
			</div>
		</div>

	</div>


	<script>
		$(function(){init();})

		$("##changePasswordForm").submit(function(e) {

			if ( $("##password").val() == $("##password2").val() ) {
				return true;
			} else {
				$(".passwordInputControlGroup").addClass("has-error");
				$(".passwordsDontMatchErrorMessage").show();
				$('##password').select();
				$('##password').focus();

				e.preventDefault();
				return false;
			}
		});

		$("##showPasswordText").change(function(e){
			if (this.checked){
				$(".passwordInput").attr("type","text");
			} else {
				$(".passwordInput").attr("type","password");
			}
		});

		$(".passwordInput").bind("change keyup", function(e){
			if (e.type != "keyup" || e.keyCode != 13 ) {
				$(".passwordInputControlGroup").removeClass("error");
				$(".passwordsDontMatchErrorMessage").hide();
				$(".otherPasswordErrorMessage").hide();
			}
		});



		function init() {
			$('##password').select();
			$('##password').focus();
		}

	</script>


</cfoutput>