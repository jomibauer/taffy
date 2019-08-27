component extends="coldbox.system.EventHandler" {
	property name="userService" inject="userService";
	property name="groupService" inject="groupService";
	property name="cryptoService" inject="cryptoService";
	property name="formatterService" inject="formatterService";
	property name="ref_stateService" inject="ref_stateService";

/************************************** IMPLICIT ACTIONS *********************************************/

	function preHandler(event,rc,prc){
		session.flash.restore(event,rc,prc);

		rc.hideMenu = false;

		rc.controllerName = "userManagement";

		rc.xeh.viewUserList = "userManagement/viewUserList";
		rc.xeh.viewGroupList = "userManagement/viewGroupList";
		rc.xeh.viewAccountDetail = 'userManagement/viewAccountDetail';
		rc.xeh.userManagementIndex = 'userManagement/index';
		rc.xeh.processLogout = 'main/processLogout';
	}

	function postHandler(event,rc,prc){

	}

/************************************ END IMPLICIT ACTIONS *******************************************/


	function index (event,rc,prc) {
		relocate('userManagement/viewUserList');
	}

	function viewUserList (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		rc.qUsers = userService.getAllUsers();
		rc.q = "";

		rc.formatterService = formatterService;

		rc.xeh.viewUserDetail = "userManagement/viewUserDetail";
		rc.xeh.viewUserCreate = "userManagement/viewUserCreate";
		rc.xeh.ajaxSearchUsers = "userManagement/ajaxSearchUsers";
		event.setView("userManagement/userList");
	}

	function ajaxSearchUsers (event,rc,prc) output="false" {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		if ( !structKeyExists(rc, "q") || !structKeyExists(rc, "token") || !len(trim(rc.token)) ) {
			fw.renderData("json", false);
			return;
		}

		var output = '{"token":' & rc.token & ', "data":' & userService.searchUsersJSON(rc.q) & '}';

		fw.renderData("text", output);
	}

	function viewUserCreate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		//rc.user might be coming from session.flash.restore(event,rc,prc) see before()

		param name="rc.user" default=userService.load(0);

		param name="rc.generatePassword" default=true;
		param name="rc.requireUserToChangePassword" default=false;
		param name="rc.sendLoginInstructions" default=false;

		// @jquery-autocomplete (<- search for this tag to find other places where jquery-autocomplete is being documented)
		// here we are setting rc.statesArray for use in the javascript at the bottom of userCreate.js
		rc.statesArray = ref_stateService.getAllStatesJSONforAutocomplete();

		rc.xeh.viewUserCreate = "userManagement/viewUserCreate";
		rc.xeh.processUserCreate = "userManagement/processUserCreate";
		rc.xeh.ajaxIsEmailAvailable = "userManagement/ajaxIsEmailAvailable";
		rc.xeh.ajaxIsUsernameAvailable = "userManagement/ajaxIsUsernameAvailable";
		event.setView("userManagement/userCreate");
	}

	function processUserCreate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		rc.intCreatedBy = session.user.getIntUserID();
		rc.user = userService.getEmptyDomain();

		param name="rc.requireUserToChangePassword" default="false";
		param name="rc.sendLoginInstructions" default="false";

		rc.dtCreatedOn = now();
		rc.dtLastModifiedOn = rc.dtCreatedOn;
		rc.intLastModifiedBy = rc.intCreatedBy;
		rc.vcCreatedByIP = cgi.remote_addr;
		rc.vcLastModifiedByIP = cgi.remote_addr;
		rc.btIsActive = true;
		rc.btIsProtected = false;
		rc.btIsLocked = false;

		var hasError = userService.validateCreate(rc, session.messenger);

		fw.populate(rc.user);

		if ( hasError ) {
			session.flash.store(rc, "user");
			session.flash.store(rc, "generatePassword");
			session.flash.store(rc, "requireUserToChangePassword");
			session.flash.store(rc, "sendLoginInstructions");

			relocate(action='userManagement/viewUserCreate', preserve='user');
		}

		rc.user = userService.save(rc.user);

		if (rc.generatePassword) {
			rc.password = cryptoService.genPassword(minLength=8, qtyNumbers=2, qtyLowerCaseAlpha=1, qtyOtherChars=1);
			//rc.hashedPassword = cryptoService.hashPassword(rc.password);

			userService.changePassword(userID=rc.user.getIntUserID()
					, newPassword=rc.password
					, isTempPassword=true
					, requireNewPassword=false
					, setBy=session.user.getIntUserID()
					, setByIP=cgi.remote_addr);
			rc.sendLoginInstructions = true;
		} else {
			userService.changePassword(intUserID=rc.user.getIntUserID()
					, newPassword=rc.password
					, isTempPassword=rc.requireUserToChangePassword
					, requireNewPassword=false
					, setBy=session.user.getIntUserID()
					, setByIP=cgi.remote_addr);
		}

		if (rc.sendLoginInstructions) {
			userService.sendLoginInstructions(user=rc.user, password=rc.password);
		}

		session.messenger.addAlert(
			messageType="SUCCESS"
			, message="The user was successfully created."
			, messageDetail=""
			, field="");

		rc.userID = rc.user.getIntUserID();
		relocate(uri="/userManagement/viewUserDetail/:userID");
	}

	function viewAccountDetail (event,rc,prc) {
		rc.isAccountDetail = true;
		rc.user = session.user;
		rc.userID = session.user.getIntUserID();

		rc.createdBy = userService.load(rc.user.getIntCreatedBy());
		rc.lastModifiedBy = userService.load(rc.user.getIntLastModifiedBy());
		rc.passwordLastSetBy = userService.load(rc.user.getIntPasswordLastSetBy());
		rc.formatterService = formatterService;
		rc.groups = groupService.getAllGroups();
		rc.groupsJSON = groupService.getAllGroupsJSON();

		rc.xeh.viewUserUpdate = "userManagement/viewUserUpdate";
		rc.xeh.viewUserDetail = "userManagement/viewUserDetail";
		rc.xeh.viewUpdateAccount = "userManagement/viewUpdateAccount";
		rc.xeh.viewChangePassword = "main/viewChangePassword";
		rc.xeh.processUserExpirePassword = "userManagement/processUserExpirePassword";
		rc.xeh.ajaxAddUserToGroup = "userManagement/ajaxAddUserToGroup";
		rc.xeh.ajaxRemoveUserFromGroup = "userManagement/ajaxRemoveUserFromGroup";

		rc.hideMenu = true;
		event.setView("userManagement/userDetail");
	}

	function viewUserDetail (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		if (!structKeyExists(rc, "userID") || !isNumeric(rc.userID)) {
			relocate(action="main/index");
		}

		rc.isAccountDetail = false;

		rc.user = userService.load(rc.userID);
		if (!rc.user.getIntUserID()) {
			relocate(action="main/index");
		}

		rc.createdBy = userService.load(rc.user.getIntCreatedBy());
		rc.lastModifiedBy = userService.load(rc.user.getIntLastModifiedBy());
		rc.passwordLastSetBy = userService.load(rc.user.getIntPasswordLastSetBy());
		rc.formatterService = formatterService;
		rc.groups = groupService.getAllGroups();
		rc.groupsJSON = groupService.getAllGroupsJSON();

		rc.xeh.viewUserUpdate = 'userManagement/viewUserUpdate';
		rc.xeh.viewUserDetail = "userManagement/viewUserDetail";
		rc.xeh.viewChangePassword = 'main/viewChangePassword';
		rc.xeh.processUserExpirePassword = "userManagement/processUserExpirePassword";
		rc.xeh.ajaxRemoveUserFromGroup = "userManagement/ajaxRemoveUserFromGroup";
		rc.xeh.ajaxAddUserToGroup = "userManagement/ajaxAddUserToGroup";
		rc.xeh.processUserRemove = "userManagement.processUserRemove";
		event.setView("userManagement/userDetail");
	}

	function processUserRemove(event,rc,prc) {
		// not implemented yet
	}

	function viewUpdateAccount (event,rc,prc) {
		rc.isAccountDetail = true;
		rc.user = session.user;
		rc.statesArray = ref_stateService.getAllStatesJSONforAutocomplete();

		rc.xeh.viewUserDetail = "userManagement/viewUserDetail";
		rc.xeh.viewUserUpdate = "userManagement/viewUserUpdate";
		rc.xeh.processUserUpdate = "userManagement/processUserUpdate";
		rc.xeh.ajaxIsEmailAvailable = "userManagement/ajaxIsEmailAvailable";

		rc.hideMenu = true;
		event.setView("userManagement/userUpdate");
	}

	function processUserExpirePassword (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		if (!structKeyExists(rc, "userID") || !isNumeric(rc.userID)) {
			relocate(action="main/index");
		}

		rc.user = userService.load(rc.userID);
		if ( !rc.user.getIntUserID() ) {
			relocate(action="main/index");
		}

		rc.user.setBtIsPasswordExpired(true);
		rc.user = userService.save(rc.user);

		session.messenger.addAlert(
			messageType="SUCCESS"
			, message="The user will now be required to change their password the next time they log in."
			, messageDetail=""
			, field="");

		relocate(uri="/userManagement/viewUserDetail/:userID");
	}

	function viewUserUpdate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		if (!structKeyExists(rc, "userID") || !isNumeric(rc.userID)) {
			relocate(action="main/index");
		}

		param name="rc.user" default=userService.load(rc.userID);

		if (!rc.user.getIntUserID()) {
			relocate(action="main/index");
		}

		rc.isAccountDetail = false;
		rc.statesArray = ref_stateService.getAllStatesJSONforAutocomplete();

		rc.xeh.viewUserDetail = "userManagement/viewUserDetail";
		rc.xeh.viewUserUpdate = "userManagement/viewUserUpdate";
		rc.xeh.processUserUpdate = "userManagement/processUserUpdate";
		rc.xeh.ajaxIsEmailAvailable = "userManagement/ajaxIsEmailAvailable";
		event.setView("userManagement/userUpdate");
	}

	function processUserUpdate (event,rc,prc) {
		rc.intLastModifiedBy = session.user.getIntUserID();

		if (!structKeyExists(rc, "userID") || !isNumeric(rc.userID)) {
			relocate(action="main/index");
		}

		rc.user = userService.load(rc.userID);
		if (!rc.user.getIntUserID()) {
			relocate(action="main/index");
		}

		if (rc.user.getIntUserID() != session.user.getIntUserID() &&
		    !session.user.isUserInGroup("USERMANAGE")) {
			relocate(action="main/index");
		}

		rc.dtLastModifiedOn = now();
		rc.vcLastModifiedByIP = cgi.remote_addr;

		var hasError = userService.validateUpdate(rc, session.messenger);

		fw.populate(rc.user);

		rc.userID = rc.user.getIntUserID();

		//redirectCustomURL( string uri, string preserve = 'none', statusCode = '302' )

		if ( hasError ) {

			session.flash.set("user", rc.user);

			if (rc.referringAction == "userManagement/viewUserUpdate") {
				relocate(action='userManagement/viewUserUpdate', append="userID", preserve='user');
			} else {
				relocate(action='userManagement/viewUpdateAccount', append="userID", preserve='user');
			}
		} else {

			rc.user = userService.save(rc.user);

			session.messenger.addAlert(
				messageType="SUCCESS"
					, message="The user has been successfully updated."
					, messageDetail=""
					, field="");

			if (rc.referringAction == "userManagement/viewUpdateAccount") {
			//it is account detail, update the in session user object
				fw.populate(session.user);
			}
		}

		if (rc.referringAction == "userManagement/viewUserUpdate") {
			//must use custom url because we are redirecting to a route, can use :variable to pull data out of the rc
			relocate(uri='/userManagement/viewUserDetail/:userID');
		} else {
			relocate(action="userManagement/viewAccountDetail");
		}

	}

	function ajaxIsUsernameAvailable (event,rc,prc) output="false"{
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		if( !structKeyExists(rc, "userID") ||
			!isNumeric(rc.userID) ||
			!structKeyExists(rc, "username") ||
			!len(rc.username)) {

			fw.renderData("json", false);
			return;
		}

		var userByUsername = userService.loadByUsername(rc.username);

		if ( userByUsername.getIntUserID() && userByUsername.getIntUserID() != rc.userID) {
			fw.renderData("json", false);
			return;
		}

		fw.renderData("json", true);
		return;
	}

	function ajaxIsEmailAvailable (event,rc,prc) output="false"{
		// IWB - 2015/02/11
		// I'm not going to limit this to only users in USERMANAGE because 
		// we need this for the updateAccount() event which can be used by any user.

		if( !structKeyExists(rc, "userID") ||
			!isNumeric(rc.userID) ||
			!structKeyExists(rc, "email") ||
			!len(rc.email)) {

			fw.renderData("json", false);
			return;
		}

		var userByEmail = userService.loadByEmail(rc.email);

		if ( userByEmail.getIntUserID() && userByEmail.getIntUserID() != rc.userID) {
			fw.renderData("json", false);
			return;
		}

		fw.renderData("json", true);
		return;
	}

	function ajaxAddUserToGroup (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		if (isNull(rc.userID) || !isNumeric(rc.userID) || isNull(rc.groupID) || !isNumeric(rc.groupID)){
			fw.renderData("json", rc);
			return;
		}

		userService.addUserToGroup(rc.userID, rc.groupID);

		fw.renderData("json", true);
		return;
	}

	function ajaxRemoveUserFromGroup (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		if (isNull(rc.userID) || !isNumeric(rc.userID) || isNull(rc.groupID) || !isNumeric(rc.groupID)){
			fw.renderData("json", false);
			return;
		}

		userService.removeUserFromGroup(rc.userID, rc.groupID);

		fw.renderData("json", true);
		return;
	}

	function viewGroupList (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		rc.groups = groupService.getAllGroups();

		rc.xeh.viewGroupDetail = "userManagement/viewGroupDetail";
		rc.xeh.viewGroupCreate = "userManagement/viewGroupCreate";
		event.setView("userManagement/groupList");
	}

	function viewGroupDetail (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		if (!structKeyExists(rc, "groupID") ||
			!isNumeric(rc.groupID)) {
			relocate(action = "userManagement/viewGroupList");
		}

		rc.group = groupService.load(rc.groupID);
		if (!rc.group.getIntGroupID()) {
			relocate(action = "userManagement/viewGroupList");
		}

		rc.createdBy = userService.load(rc.group.getIntCreatedBy());
		rc.lastModifiedBy = userService.load(rc.group.getIntLastModifiedBy());

		if (rc.group.getIntGroupID() != rc.groupID) {
			relocate(action = "userManagement/viewGroupList");
		}

		rc.formatterService = formatterService;

		rc.xeh.viewGroupDetail = "userManagement/viewGroupDetail";
		rc.xeh.viewGroupUpdate = "userManagement/viewGroupUpdate";
		event.setView("userManagement/groupDetail");
	}

	function viewGroupCreate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		param name="rc.group" default=groupService.load(0);

		rc.xeh.viewGroupDetail = "userManagement/viewGroupDetail";
		rc.xeh.viewGroupCreate = "userManagement/viewGroupCreate";
		rc.xeh.processGroupCreate = "userManagement/processGroupCreate";
		rc.xeh.ajaxIsGroupNameAvailable = "userManagement/ajaxIsGroupNameAvailable";
		rc.xeh.ajaxIsGroupAbbrAvailable = "userManagement/ajaxIsGroupAbbrAvailable";
		event.setView("userManagement/groupCreate");
	}

	function ajaxIsGroupNameAvailable(event,rc,prc) output="false" {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			fw.renderData("json", false);
			return;
		}

		if( !structKeyExists(rc, "vcGroupName") ||
			!len(rc.vcGroupName)) {

			fw.renderData("json", false);
			return;
		}

		var groupByName = groupService.loadByName(rc.vcGroupName);

		if ( groupByName.getIntGroupID()) {
			fw.renderData("json", false);
			return;
		}

		fw.renderData("json", true);
		return;
	}

	function ajaxIsGroupAbbrAvailable(event,rc,prc) output="false" {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			fw.renderData("json", false);
			return;
		}

		if( !structKeyExists(rc, "vcGroupAbbr") ||
			!len(rc.vcGroupAbbr)) {

			fw.renderData("json", false);
			return;
		}

		var groupByAbbr = groupService.loadByAbbr(rc.vcGroupAbbr);

		if ( groupByAbbr.getIntGroupID()) {
			fw.renderData("json", false);
			return;
		}

		fw.renderData("json", true);
		return;
	}

	function processGroupCreate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		rc.intCreatedBy = session.user.getIntUserID();
		rc.dtCreatedOn = now();

		var hasError = groupService.validateCreate(rc, session.messenger);

		rc.group = groupService.getEmptyDomain();
		fw.populate(rc.group);

		if ( hasError ) {
			relocate(action='userManagement/viewGroupCreate', preserve='group');
		}

		rc.group = groupService.save(rc.group);

		rc.groupID = rc.group.getIntGroupID();
		relocate(uri="/userManagement/viewGroupDetail/:groupID");

	}

	function viewGroupUpdate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		if (!structKeyExists(rc, "groupID") ||
			!isNumeric(rc.groupID)) {
			relocate(action = "userManagement/groupList");
		}

		param name="rc.group" default=groupService.load(rc.groupID);

		if (!rc.group.getIntGroupID()) {
			relocate(action = "userManagement/groupList");
		}

		rc.xeh.viewGroupDetail = "userManagement/viewGroupDetail";
		rc.xeh.viewGroupUpdate = "userManagement/viewGroupUpdate";
		rc.xeh.processGroupUpdate = "userManagement/processGroupUpdate";
		event.setView("userManagement/groupUpdate");
	}

	function processGroupUpdate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate("main/index");
		}

		if (!structKeyExists(rc, "groupID") ||
			!isNumeric(rc.groupID)) {
			relocate(action = "userManagement/viewGroupList");
		}

		rc.group = groupService.load(rc.groupID);
		if (!rc.group.getIntGroupID()) {
			relocate(action = "userManagement/viewGroupList");
		}

		rc.intLastModifiedBy = session.user.getIntUserID();
		rc.dtLastModifiedOn = now();

		var hasError = groupService.validateUpdate(rc, session.messenger);

		fw.populate(rc.group);

		if ( hasError ) {
			session.flash.set("group", rc.group);
			relocate(action='userManagement/viewGroupUpdate', append="groupID", preserve='group');
		}

		rc.group = groupService.save(rc.group);

		rc.groupID = rc.group.getIntGroupID();
		relocate(uri="/userManagement/viewGroupDetail/:groupID");
	}

}