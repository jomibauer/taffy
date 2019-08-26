<cfoutput>
	<div class="row">
		<div class="col-md-offset-2 col-md-8">
			<form class="form-horizontal" method="post" action="#event.buildLink(rc.xeh.processLogin)#">
				<fieldset>
					<legend>Log In</legend>
					<div class="form-group">
						<label class="control-label col-md-2" for="username">Username:</label>
						<div class="col-md-6">
							<input type="text" id="username" name="username" class="form-control" value="" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-2" for="password">Password:</label>
						<div class="col-md-6">
							<input type="password" id="password" name="password" class="form-control" value="" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-offset-2 col-md-6">
						<input type="submit" value="Login" class="btn btn-primary" /><br/><br />
						<a href="#event.buildLink(rc.xeh.viewForgotPassword)#">Forgot Password?</a>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>

	<script>
		$('##username').focus();
	</script>

</cfoutput>