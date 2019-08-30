<cfoutput>

	<div class="row justify-content-md-center">
		<div class="col-4">
			<br />
			<form class="form-horizontal" method="post" action="#event.buildLink(prc.xeh.processLogin)#">
				<fieldset>
					<legend>Log In</legend>
					<br />
					<div class="form-group row">
						<label class="control-label col-3 text-right" for="username">Username:</label>
						<div class="col">
							<input type="text" id="username" name="username" class="form-control" value="" />
						</div>
					</div>
					<div class="form-group row">
						<label class="control-label col-3 text-right" for="password">Password:</label>
						<div class="col">
							<input type="password" id="password" name="password" class="form-control" value="" />
						</div>
					</div>
					<div class="form-group row">
						<div class="col">
							<button type="submit" class="btn btn-primary float-right">LOGIN</button>
							<br/><br />
							<a class="float-right" href="#event.buildLink(prc.xeh.viewForgotPassword)#">Forgot Password?</a>
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