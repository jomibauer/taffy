<cfoutput>
	<div class="row mt-3">
		<div class="offset-1 col-10">
			<form class="form-horizontal" method="post" action="#event.buildLink(prc.xeh.processForgotPassword)#">
				<fieldset>
					<legend>Forgot Password</legend>
					<div class="form-group">
						<p>Enter your email address and we will send you a temporary password which will let you log in, and change to a new password.</p>
					</div>

					<div class="form-group row">
						<label class="control-label col-2" for="email">Email:</label>

						<div class="controls col-6">
							<input type="text" id="email" name="email" class="form-control" value="#rc.email#"/>
						</div>
					</div>
					<div class="form-group row">
						<div class="offset-2 col-6">
							<input type="submit" value="Send Email" class="btn btn-primary"/>
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