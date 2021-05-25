component extends="coldbox.system.EventHandler" {
	property name="userService" inject="userService";
	property name="groupService" inject="groupService";
	property name="cryptoService" inject="cryptoService";
	property name="formatterService" inject="formatterService";
	property name="ref_stateService" inject="ref_stateService";

/************************************** IMPLICIT ACTIONS *********************************************/

	function preHandler(event,rc,prc){
		prc.hideMenu = false;

		prc.xeh.viewUserList = "userManagement/viewUserList";
		prc.xeh.viewGroupList = "userManagement/viewGroupList";
		prc.xeh.viewAccountDetail = "userManagement/viewAccountDetail";
	}

	function postHandler(event,rc,prc){

	}

/************************************ END IMPLICIT ACTIONS *******************************************/


	function index (event,rc,prc) {
		relocate(event="userManagement/viewUserList");
	}

	function viewUserList (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		prc.qUsers = userService.getAllUsers();

		prc.formatterService = formatterService;

		prc.xeh.viewUserDetail = "userManagement/viewUserDetail";
		prc.xeh.viewUserCreate = "userManagement/viewUserCreate";
		prc.xeh.ajaxSearchUsers = "userManagement/ajaxSearchUsers";
		event.setView("userManagement/userList");
	}

	function ajaxSearchUsers (event,rc,prc) output=false renderdata="json" {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if ( !structKeyExists(rc, "q") || !structKeyExists(rc, "token") || !len(trim(rc.token)) ) {
			return false;
		}

		var output = '{"token":' & rc.token & ', "data":' & userService.searchUsersJSON(prc.q) & '}';

		return output;
	}

	function viewUserCreate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		param name="rc.user" default=userService.load(0);

		param name="rc.generatePassword" default=true;
		param name="rc.requireUserToChangePassword" default=false;
		param name="rc.sendLoginInstructions" default=false;

        prc.formatterService = formatterService;
		prc.statesArray = ref_stateService.getAllStatesJSONforAutocomplete();

		prc.xeh.viewUserCreate = "userManagement/viewUserCreate";
		prc.xeh.processUserCreate = "userManagement/processUserCreate";
		prc.xeh.ajaxIsEmailAvailable = "userManagement/ajaxIsEmailAvailable";
		prc.xeh.ajaxIsUsernameAvailable = "userManagement/ajaxIsUsernameAvailable";
		event.setView("userManagement/userCreate");
	}

	function processUserCreate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		rc.intCreatedById = session.user.getIntUserID();
		rc.user = userService.getEmptyDomain();

		param name="rc.requireUserToChangePassword" default=false;
		param name="rc.sendLoginInstructions" default=false;

		rc.dtCreatedOn = now();
		rc.dtModifiedOn = rc.dtCreatedOn;
		rc.intModifiedById = rc.intCreatedById;
		rc.vcCreatedByIP = cgi.remote_addr;
		rc.vcModifiedByIP = cgi.remote_addr;
		rc.btIsActive = true;
		rc.btIsProtected = false;
		rc.btIsRemoved = false;

		var hasError = userService.validateCreate(rc, session.messenger);

		populateModel(rc.user);

		if ( hasError ) {
			flash.put(name="user", value=rc.user);
			flash.put(name="generatePassword", value=rc.generatePassword);
			flash.put(name="requireUserToChangePassword", value=rc.requireUserToChangePassword);
			flash.put(name="sendLoginInstructions", value=rc.sendLoginInstructions);

			relocate(event="userManagement/viewUserCreate");
		}

		rc.user = userService.save(rc.user);

		if (rc.generatePassword) {
			rc.password = cryptoService.genPassword(minLength=8, qtyNumbers=2, qtyLowerCaseAlpha=1, qtyOtherChars=1);
			//rc.hashedPassword = cryptoService.hashPassword(rc.password);

			userService.changePassword(intUserID=rc.user.getIntUserID()
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

		relocate(uri="/userManagement/viewUserDetail/#rc.user.getIntUserID()#");
	}

	function viewAccountDetail (event,rc,prc) {
		prc.isAccountDetail = true;
		rc.user = session.user;
		rc.userID = session.user.getIntUserID();

<<<<<<< HEAD
		rc.createdById = userService.load(rc.user.getIntCreatedById());
		rc.modifiedById = userService.load(rc.user.getIntModifiedById());
		rc.passwordLastSetById = userService.load(rc.user.getIntPasswordLastSetById());
=======
		rc.createdBy = userService.load(rc.user.getIntCreatedById());
		rc.lastModifiedBy = userService.load(rc.user.getIntModifiedById());
		rc.passwordLastSetBy = userService.load(rc.user.getIntPasswordLastSetBy());
>>>>>>> develop
		prc.formatterService = formatterService;
		prc.groups = groupService.getAllGroups();
		prc.groupsJSON = groupService.getAllGroupsJSON();

		prc.xeh.viewUserUpdate = "userManagement/viewUserUpdate";
		prc.xeh.viewUserDetail = "userManagement/viewUserDetail";
		prc.xeh.viewUpdateAccount = "userManagement/viewUpdateAccount";
		prc.xeh.viewChangePassword = "main/viewChangePassword";
		prc.xeh.processUserExpirePassword = "userManagement/processUserExpirePassword";
		prc.xeh.processUserDeactivate = "userManagement/processUserDeactivate";
		prc.xeh.processUserActivate = "userManagement/processUserActivate";
		prc.xeh.processUserRemove = "userManagement/processUserRemove";
		prc.xeh.ajaxAddUserToGroup = "userManagement/ajaxAddUserToGroup";
		prc.xeh.ajaxRemoveUserFromGroup = "userManagement/ajaxRemoveUserFromGroup";

		prc.hideMenu = true;
		event.setView("userManagement/userDetail");
	}

	function viewUserDetail (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if (!structKeyExists(rc, "userID") || !isNumeric(rc.userID)) {
			relocate(event="main/index");
		}

		prc.isAccountDetail = false;

		rc.user = userService.load(rc.userID);
		if (!rc.user.getIntUserID()) {
			relocate(event="main/index");
		}

<<<<<<< HEAD
		rc.createdById = userService.load(rc.user.getIntCreatedById());
		rc.modifiedById = userService.load(rc.user.getIntModifiedById());
		rc.passwordLastSetById = userService.load(rc.user.getIntPasswordLastSetById());
=======
		rc.createdBy = userService.load(rc.user.getIntCreatedById());
		rc.lastModifiedBy = userService.load(rc.user.getIntModifiedById());
		rc.passwordLastSetBy = userService.load(rc.user.getIntPasswordLastSetBy());
>>>>>>> develop
		prc.formatterService = formatterService;
		prc.groups = groupService.getAllGroups();
		prc.groupsJSON = groupService.getAllGroupsJSON();

		prc.xeh.viewUserUpdate = "userManagement/viewUserUpdate";
		prc.xeh.viewUserDetail = "userManagement/viewUserDetail";
		prc.xeh.viewChangePassword = "main/viewChangePassword";
		prc.xeh.processUserExpirePassword = "userManagement/processUserExpirePassword";
		prc.xeh.processUserDeactivate = "userManagement/processUserDeactivate";
		prc.xeh.processUserActivate = "userManagement/processUserActivate";
		prc.xeh.processUserRemove = "userManagement/processUserRemove";
		prc.xeh.ajaxRemoveUserFromGroup = "userManagement/ajaxRemoveUserFromGroup";
		prc.xeh.ajaxAddUserToGroup = "userManagement/ajaxAddUserToGroup";
		event.setView("userManagement/userDetail");
	}

	function processUserRemove (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if (isNull(rc.userID) || !isNumeric(rc.userID)) {
			relocate(event="main/index");
		}

		rc.user = userService.load(rc.userID);
		if (rc.user.getIntUserID() != rc.userID) {
			relocate(event="main/index");
		}

		if (rc.user.btIsProtected()) {
			session.messenger.addAlert(
				messageType="SUCCESS"
					, message="Protected users cannot be removed."
					, messageDetail=""
					, field="");

			relocate(uri="/userManagement/viewUserDetail/#rc.userID#");
		}

		rc.user.setBtIsRemoved(true);
		rc.user.setIntModifiedById(session.user.getIntUserID());
		rc.user.setDtModifiedOn(now());

		rc.user = userService.save(rc.user);

		relocate(event="userManagement/viewUserList");
	}

	function viewUpdateAccount (event,rc,prc) {
		prc.isAccountDetail = true;
		rc.user = session.user;
		prc.statesArray = ref_stateService.getAllStatesJSONforAutocomplete();
		prc.formatterService = formatterService;

		prc.xeh.viewUserDetail = "userManagement/viewUserDetail";
		prc.xeh.viewUserUpdate = "userManagement/viewUserUpdate";
		prc.xeh.processUserUpdate = "userManagement/processUserUpdate";
		prc.xeh.ajaxIsEmailAvailable = "userManagement/ajaxIsEmailAvailable";

		prc.hideMenu = true;
		event.setView("userManagement/userUpdate");
	}

	function processUserExpirePassword (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if (!structKeyExists(rc, "userID") || !isNumeric(rc.userID)) {
			relocate(event="main/index");
		}

		rc.user = userService.load(rc.userID);
		if ( !rc.user.getIntUserID() ) {
			relocate(event="main/index");
		}

		rc.user.setBtIsPasswordExpired(true);
		rc.user = userService.save(rc.user);

		session.messenger.addAlert(
			messageType="SUCCESS"
			, message="The user will now be required to change their password the next time they log in."
			, messageDetail=""
			, field="");

		relocate(uri="/userManagement/viewUserDetail/#rc.user.getIntUserID()#");
	}

	function processUserDeactivate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if (!structKeyExists(rc, "userID") || !isNumeric(rc.userID)) {
			relocate(event="main/index");
		}

		rc.user = userService.load(rc.userID);
		if ( !rc.user.getIntUserID() ) {
			relocate(event="main/index");
		}

		rc.user.setBtIsActive(false);
		rc.user = userService.save(rc.user);

		session.messenger.addAlert(
			messageType="SUCCESS"
				, message="The user is now deactivated."
				, messageDetail=""
				, field="");

		relocate(uri="/userManagement/viewUserDetail/#rc.user.getIntUserID()#");
	}

	function processUserActivate(event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if (!structKeyExists(rc, "userID") || !isNumeric(rc.userID)) {
			relocate(event="main/index");
		}

		rc.user = userService.load(rc.userID);
		if ( !rc.user.getIntUserID() ) {
			relocate(event="main/index");
		}

		rc.user.setBtIsActive(true);
		rc.user = userService.save(rc.user);

		session.messenger.addAlert(
			messageType="SUCCESS"
				, message="The user is now active."
				, messageDetail=""
				, field="");

		relocate(uri="/userManagement/viewUserDetail/#rc.user.getIntUserID()#");
	}

	function viewUserUpdate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if (!structKeyExists(rc, "userID") || !isNumeric(rc.userID)) {
			relocate(event="main/index");
		}

		param name="rc.user" default=userService.load(rc.userID);

		if (!rc.user.getIntUserID()) {
			relocate(event="main/index");
		}

		prc.isAccountDetail = false;
		prc.statesArray = ref_stateService.getAllStatesJSONforAutocomplete();
		prc.formatterService = formatterService;

		prc.xeh.viewUserDetail = "userManagement/viewUserDetail";
		prc.xeh.viewUserUpdate = "userManagement/viewUserUpdate";
		prc.xeh.processUserUpdate = "userManagement/processUserUpdate";
		prc.xeh.ajaxIsEmailAvailable = "userManagement/ajaxIsEmailAvailable";
		event.setView("userManagement/userUpdate");
	}

	function processUserUpdate (event,rc,prc) {
		rc.intModifiedById = session.user.getIntUserID();

		if (!structKeyExists(rc, "userID") || !isNumeric(rc.userID)) {
			relocate(event="main/index");
		}

		rc.user = userService.load(rc.userID);
		if (!rc.user.getIntUserID()) {
			relocate(event="main/index");
		}

		//if the user is trying to update another user and is not in the USERMANAGE group
		if (rc.user.getIntUserID() != session.user.getIntUserID() && !session.user.isUserInGroup("USERMANAGE")) {
			relocate(event="main/index");
		}

		rc.dtModifiedOn = now();
<<<<<<< HEAD
		rc.vcModifiedByIP = cgi.remote_addr;
=======
		rc.vcLastModifiedByIP = cgi.remote_addr;
>>>>>>> develop

		var hasError = userService.validateUpdate(rc, session.messenger);

		populateModel(rc.user);

		rc.userID = rc.user.getIntUserID();

		//redirectCustomURL( string uri, string preserve = 'none', statusCode = '302' )
		if ( hasError ) {
			flash.put(name="user", value=rc.user);

			if (rc.referringAction == "userManagement/viewUserUpdate") {
				relocate(uri="/userManagement/viewUserUpdate/#rc.user.getIntUserID()#");
			} else {
				relocate(uri="/userManagement/viewUpdateAccount/#rc.user.getIntUserID()#");
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
				populateModel(session.user);
				relocate(event="userManagement/viewAccountDetail");
			} else {
				relocate(uri="/userManagement/viewUserDetail/#rc.userID#");
			}
		}
	}

	function ajaxIsUsernameAvailable (event,rc,prc) output=false renderdata="json" {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if( !structKeyExists(rc, "userID") || !isNumeric(rc.userID) ||
			!structKeyExists(rc, "username") || !len(rc.username)) {

			return false;
		}

		var userByUsername = userService.loadByUsername(rc.username);

		if ( userByUsername.getIntUserID() && userByUsername.getIntUserID() != rc.userID) {
			return false;
		}

		return true;
	}

	function ajaxIsEmailAvailable (event,rc,prc) output=false renderdata="json"{
		// IWB - 2015/02/11
		// I'm not going to limit this to only users in USERMANAGE because
		// we need this for the updateAccount() event which can be used by any user.

		if( !structKeyExists(rc, "userID") || !isNumeric(rc.userID) ||
			!structKeyExists(rc, "email") || !len(rc.email)) {
			return false;
		}

		var userByEmail = userService.loadByEmail(rc.email);

		if ( userByEmail.getIntUserID() && userByEmail.getIntUserID() != rc.userID) {
			return false;
		}

		return true;
	}

	function ajaxAddUserToGroup (event,rc,prc) output=false renderdata="json"{
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if (isNull(rc.userID) || !isNumeric(rc.userID) || isNull(rc.groupID) || !isNumeric(rc.groupID)){
			return false;
		}

		userService.addUserToGroup(rc.userID, rc.groupID);

		return true;
	}

	function ajaxRemoveUserFromGroup (event,rc,prc)output=false renderdata="json" {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if (isNull(rc.userID) || !isNumeric(rc.userID) || isNull(rc.groupID) || !isNumeric(rc.groupID)){
			return false;
		}

		userService.removeUserFromGroup(rc.userID, rc.groupID);

		return true;
	}

	function viewGroupList (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		prc.groups = groupService.getAllGroups();

		prc.xeh.viewGroupDetail = "userManagement/viewGroupDetail";
		prc.xeh.viewGroupCreate = "userManagement/viewGroupCreate";
		event.setView("userManagement/groupList");
	}

	function viewGroupDetail (event,rc,prc) {
		if (!session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if (!structKeyExists(rc, "groupID") || !isNumeric(rc.groupID)) {
			relocate(event="userManagement/viewGroupList");
		}

		rc.group = groupService.load(rc.groupID);
		if (!rc.group.getIntGroupID()) {
			relocate(event="userManagement/viewGroupList");
		}

<<<<<<< HEAD
		rc.createdById = userService.load(rc.group.getIntCreatedById());
		rc.modifiedById = userService.load(rc.group.getIntModifiedById());
=======
		rc.createdBy = userService.load(rc.group.getIntCreatedById());
		rc.lastModifiedBy = userService.load(rc.group.getIntModifiedById());
>>>>>>> develop

		if (rc.group.getIntGroupID() != rc.groupID) {
			relocate(event="userManagement/viewGroupList");
		}

		prc.formatterService = formatterService;

		prc.xeh.viewGroupDetail = "userManagement/viewGroupDetail";
		prc.xeh.viewGroupUpdate = "userManagement/viewGroupUpdate";
		prc.xeh.processGroupRemove = "userManagement/processGroupRemove";
		event.setView("userManagement/groupDetail");
	}

    function processGroupRemove (event,rc,prc) {
        if ( !session.user.isUserInGroup("USERMANAGE") ) {
            relocate(event="main/index");
        }

        if (isNull(rc.groupID) || !isNumeric(rc.groupID)) {
            relocate(event="main/index");
        }

        rc.group = groupService.load(rc.groupID);
        if (rc.group.getIntGroupID() != rc.groupID) {
            relocate(event="main/index");
        }

        if (rc.group.btIsProtected()) {
            session.messenger.addAlert(
                messageType="SUCCESS"
                    , message="Protected groups cannot be removed."
                    , messageDetail=""
                    , field="");

            relocate(uri="/userManagement/viewGroupDetail/#rc.groupID#");
        }

        rc.group.setBtIsRemoved(true);
        rc.group.setIntModifiedById(session.user.getIntUserID());
        rc.group.setDtModifiedOn(now());

        rc.group = groupService.save(rc.group);

        relocate(event="userManagement/viewGroupList");
    }

	function viewGroupCreate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		param name="rc.group" default=groupService.load(0);

		prc.xeh.viewGroupDetail = "userManagement/viewGroupDetail";
		prc.xeh.viewGroupCreate = "userManagement/viewGroupCreate";
		prc.xeh.processGroupCreate = "userManagement/processGroupCreate";
		prc.xeh.ajaxIsGroupNameAvailable = "userManagement/ajaxIsGroupNameAvailable";
		prc.xeh.ajaxIsGroupAbbrAvailable = "userManagement/ajaxIsGroupAbbrAvailable";
		event.setView("userManagement/groupCreate");
	}

	function ajaxIsGroupNameAvailable(event,rc,prc) output=false renderdata="json" {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			return false;
		}

		if( !structKeyExists(rc, "vcGroupName") ||
			!len(rc.vcGroupName)) {

			return false;
		}

		var groupByName = groupService.loadByName(rc.vcGroupName);

		if ( groupByName.getIntGroupID()) {
			return false;
		}

		return true;
	}

	function ajaxIsGroupAbbrAvailable(event,rc,prc) output=false renderdata="json" {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			return false;
		}

		if( !structKeyExists(rc, "vcGroupAbbr") || !len(rc.vcGroupAbbr)) {

			return false;
		}

		var groupByAbbr = groupService.loadByAbbr(rc.vcGroupAbbr);

		if ( groupByAbbr.getIntGroupID()) {
			return false;
		}

		return true;
	}

	function processGroupCreate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		rc.intCreatedById = session.user.getIntUserID();
		rc.dtCreatedOn = now();

		var hasError = groupService.validateCreate(rc, session.messenger);

		rc.group = groupService.getEmptyDomain();
		populateModel(rc.group);

		if ( hasError ) {
			flash.put(name="group", value=rc.group);
			relocate(event="userManagement/viewGroupCreate");
		}

		rc.group = groupService.save(rc.group);

		relocate(uri="/userManagement/viewGroupDetail/#rc.group.getIntGroupID()#");

	}

	function viewGroupUpdate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if (!structKeyExists(rc, "groupID") ||
			!isNumeric(rc.groupID)) {
			relocate(event="userManagement/groupList");
		}

		param name="rc.group" default=groupService.load(rc.groupID);

		if (!rc.group.getIntGroupID()) {
			relocate(event="userManagement/groupList");
		}

		prc.xeh.viewGroupDetail = "userManagement/viewGroupDetail";
		prc.xeh.viewGroupUpdate = "userManagement/viewGroupUpdate";
		prc.xeh.processGroupUpdate = "userManagement/processGroupUpdate";
		event.setView("userManagement/groupUpdate");
	}

	function processGroupUpdate (event,rc,prc) {
		if ( !session.user.isUserInGroup("USERMANAGE") ) {
			relocate(event="main/index");
		}

		if (!structKeyExists(rc, "groupID") || !isNumeric(rc.groupID)) {
			relocate(event="userManagement/viewGroupList");
		}

		rc.group = groupService.load(rc.groupID);
		if (!rc.group.getIntGroupID()) {
			relocate(event="userManagement/viewGroupList");
		}

		rc.intModifiedById = session.user.getIntUserID();
		rc.dtModifiedOn = now();

		var hasError = groupService.validateUpdate(rc, session.messenger);

		populateModel(rc.group);

		if ( hasError ) {
			flash.put(name="group", value=rc.group);
			relocate(uri="/userManagement/viewGroupUpdate/#rc.group.getIntGroupID()#");
		}

		rc.group = groupService.save(rc.group);

		relocate(uri="/userManagement/viewGroupDetail/#rc.group.getIntGroupID()#");
	}

}