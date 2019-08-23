<cfoutput>

	<div class="row">
		<div class="col-md-offset-1 col-md-10">
			<form class="form-horizontal" method="post" action="#buildURL(rc.xeh.processForgotPassword)#">
				<fieldset>
					<legend>Forgot Password</legend>
					<div class="form-group">
						<p>Enter your email address and we will send you a temporary password which will let you log in, and change to a new password.</p>
					</div>

					<div class="form-group">
						<label class="control-label col-md-2" for="email">Email:</label>

						<div class="controls col-md-6">
							<input type="text" id="email" name="email" class="form-control" value="#rc.email#"/>
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-offset-2 col-md-6">
							<input type="submit" value="Send Email" class="btn btn-primary"/>
							<input type="hidden" name="action" value="forgotPassword"/>
						</div>
					</div>
				</fieldset>
			</form>
		</div>

	</div>

	<script>
		$('##email').focus();
	</script>

</cfoutput>