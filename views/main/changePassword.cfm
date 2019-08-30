<cfoutput>
	<div class="row">
		<div class="col-8">
			<h2>Change password for #prc.user.getVcFirstName()# #prc.user.getVcLastName()#</h2>

			<form id="changePasswordForm" class="form-horizontal" action="#event.buildLink(prc.xeh.processChangePassword)#" method="POST">
				<div class="form-group row">
					<label class="control-label col-3" for="showPasswordText">Show Passwords:</label>
					<div class="col-5">
						<input type="checkbox" id="showPasswordText" class="checkbox mt-2" value="true" />
					</div>
				</div>
				<div class="form-group row passwordInputControlGroup <cfif session.messenger.fieldHasAlert("password")>has-error</cfif>">
					<label class="control-label col-3" for="password">Password:</label>
					<div class="col-5">
						<input type="password" id="password" name="password" class="form-control passwordInput" value="" />
						<span class="help-block passwordsDontMatchErrorMessage" style="display:none;">The passwords do not match. Please try again.</span>
						<span class="help-block otherPasswordErrorMessage" <cfif NOT session.messenger.fieldHasAlert("password")>style="display:none;"</cfif>>#session.messenger.getAlertForField("password").message#</span>
					</div>
				</div>
				<div class="form-group row passwordInputControlGroup <cfif session.messenger.fieldHasAlert("password2")>has-error</cfif>">
					<label class="control-label col-3" for="password2">Password Again:</label>
					<div class="col-5">
						<input type="password" id="password2" name="password2" class="form-control passwordInput" value="" />
						<span class="help-block passwordsDontMatchErrorMessage"style="display:none;">The passwords do not match. Please try again.</span>
						<span class="help-block otherPasswordErrorMessage" <cfif NOT session.messenger.fieldHasAlert("password")>style="display:none;"</cfif>>#session.messenger.getAlertForField("password").message#</span>
					</div>
				</div>
				<div class="form-group row">
					<div class="offset-3 col-5">
						<input type="hidden" name="intPasswordLastSetBy" value="#session.user.getintUserID()#" />
						<input type="hidden" name="userID" value="#prc.user.getIntUserID()#" />
						<input type="submit" value="Update Account" class="btn btn-primary" />
					</div>
				</div>
			</form>
		</div>
		<div class="col-4">
			<div class="card bg-light">
				<div class="card-body">
					<p class="mb-0">Please enter your new password.</p>
				</div>
			</div>
		</div>
	</div>
</cfoutput>

	<script>
		$(function(){init();});

		$("#changePasswordForm").submit(function(e) {
		    console.log('testing');
			if ( $("#password").val() == $("#password2").val() ) {
				return true;
			} else {
				$(".passwordInputControlGroup").addClass("has-error");
				$(".passwordsDontMatchErrorMessage").show();
				$('#password').select();
				$('#password').focus();

				e.preventDefault();
				return false;
			}
		});

		$("#showPasswordText").change(function(e){
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
			$('#password').select();
			$('#password').focus();
		}

	</script>

