component{

	function configure(){
		// Set Full Rewrites
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 *
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 *
		 */
		route("userManagement/viewUserDetail/:userID", "userManagement.viewUserDetail");
		route("userManagement/viewUserUpdate/:userID", "userManagement.viewUserUpdate");
		route("userManagement/viewGroupDetail/:groupID", "userManagement.viewGroupDetail");
		route("userManagement/viewGroupUpdate/:groupID", "userManagement.viewGroupUpdate");

		// A nice healthcheck route example
		route("/healthcheck",function(event,rc,prc){
			return "Ok!";
		});

		// A nice RESTFul Route example
		route( "/api/echo", function( event, rc, prc ){
			return {
				"error" : false,
				"data" 	: "Welcome to my awesome API!"
			};
		} );

		// Conventions based routing
		route( ":handler/:action?" ).end();
	}

}