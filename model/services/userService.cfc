component accessors=true extends="baseService" singleton=true {
	property name="userGateway" inject="userGateway";
	property name="groupService" inject="groupService";
	property name="formatterService" inject="formatterService";
	property name="cryptoService" inject="cryptoService";

	private any function create (required any user) {
		if (userGateway.getUserIDByUsername(user.getVcUsername())) {
			throw(type="DuplicateUsername", message="The username " & user.getVcUsername() & " is already taken by another user.");
		}

		if (userGateway.getUserIDByEmail(user.getVcEmail())) {
			throw(type="DuplicateEmail", message="The email " & user.getVcEmail() & " is already taken by another user.");
		}

		var userID = userGateway.create(user);

		return load(userID);
	}

	private any function update (required any user) {
		var emailCheck = userGateway.getUserIDByEmail(user.getVcEmail());

		if (emailCheck != 0 && emailCheck != user.getIntUserID()) {
			throw(type="DuplicateEmail", message="The email " & user.getVcEmail() & " is already taken by another user.");
		}

		userGateway.update(user);

		return load(user.getIntUserID());
	}

	function save (required any user) {
		
		if (user.getIntUserID()) {
			return update(user);
		}

		return create(user);
	}

	function getEmptyDomain() {
		return new model.domains.User();
	}

	public any function populate (required any user, required struct data ) {

		user.setIntUserID(data.intUserID);
		user.setVcUsername(data.vcUsername);
		user.setVcEmail(data.vcEmail);
		user.setVcFirstName(data.vcFirstName);
		user.setVcMiddleName(data.vcMiddleName);
		user.setVcLastName(data.vcLastName);
		user.setVcNamePrefix(data.vcNamePrefix);
		user.setVcNameSuffix(data.vcNameSuffix);
		user.setVcPassword(data.vcPassword);
		user.setBtIsPasswordExpired(data.btIsPasswordExpired);
		user.setDtPasswordLastSetOn(data.dtPasswordLastSetOn);
		user.setIntPasswordLastSetBy(data.intPasswordLastSetBy);
		user.setVcPasswordLastSetByIP(data.vcPasswordLastSetByIP);
		user.setDtLastLoggedInOn(data.dtLastLoggedInOn);
		user.setVcAddress1(data.vcAddress1);
		user.setVcAddress2(data.vcAddress2);
		user.setVcAddress3(data.vcAddress3);
		user.setVcCity(data.vcCity);
		user.setVcState(data.vcState);
		user.setVcPostalCode(data.vcPostalCode);
		user.setVcZip4(data.vcZip4);
		user.setVcPhone1(data.vcPhone1);
		user.setVcPhone2(data.vcPhone2);
		user.setBtIsActive(data.btIsActive);
		user.setBtIsProtected(data.btIsProtected);
		user.setBtIsLocked(data.btIsLocked);
		user.setDtCreatedOn(data.dtCreatedOn);
		user.setIntCreatedBy(data.intCreatedBy);
		user.setVcCreatedByIP(data.vcCreatedByIP);
		user.setDtLastModifiedOn(data.dtLastModifiedOn);
		user.setIntLastModifiedBy(data.intLastModifiedBy);
		user.setVcLastModifiedByIP(data.vcLastModifiedByIP);

		return user;
	}


	function load (required numeric userID) {

		var user = getEmptyDomain();

		if (userID == 0) {
			return user;
		}

		var qLoad = userGateway.load(userID);

		if (qLoad.recordCount) {
			populate(user, queryGetRow(qLoad, 1));
			var qGroups = userGateway.getGroupsForUser(userID);
			qGroups.each(function(row){
				user.addUserGroup(groupService.load(row.intGroupID));
			});
		}

		return user;
	}

	function authenticateUser (
			  required string username
			, required string password
			, required string ipAddress) {

		var qUser = userGateway.loadByUsernameOrEmail(username);

		var user = load(0);

		if (qUser.recordCount && qUser.btIsActive) {
			if (cryptoService.checkPassword(password, qUser.vcPassword)) {
				userGateway.updateLastLoggedIn(qUser.intUserID);
				user = load(qUser.intUserID);
				user.setIsLoggedIn(true);
			}
		}

		userGateway.logAuthenticationAttempt(username, user.isLoggedIn(), ipAddress);

		return user;
	}

	boolean function isNewPasswordDifferent (
			  required numeric userID
			, required string newPassword
			, required numeric passwordRotation) {

		var qUser = userGateway.getPreviousPasswords(userID, passwordRotation);

		return !qUser.some(function (row) {
			return cryptoService.checkPassword(newPassword, row.vcPassword);
		}, true);
	}

	boolean function changePassword (
			  required numeric intUserID
            , required string newPassword
            , required boolean isTempPassword
            , required boolean requireNewPassword
            , required numeric setBy
            , required string setByIP) {

		if (!requireNewPassword || isNewPasswordDifferent(intUserID, newPassword, passwordRotation)) {
			newPassword = cryptoService.hashPassword(newPassword);
			userGateway.changePassword(argumentCollection=arguments);

			return true;
		}

		return false;
    }

	void function addUserToGroup (required numeric userID, required numeric groupID) {
		userGateway.addUserToGroup(userID, groupID);
	}

	void function removeUserFromGroup (required numeric userID, required numeric groupID) {
		userGateway.removeUserFromGroup(userID, groupID);
	}

	string function usersQueryToJSON (required query qUsers) {
		var sb = createObject("java", "java.lang.StringBuffer").init('[');

		var rowIndex = 0;
		for (var user in qUsers) {
			if (++rowIndex != 1) {
				sb.append(",");
			}
			sb.append('{"userID":');
			sb.append(user.intUserID);
		    sb.append(',"username":"');
		    sb.append(user.vcUsername);
		    sb.append('","email":"');
		    sb.append(user.vcEmail);
		    sb.append('","name":"');
		    sb.append(user.vcFirstname);
			sb.append(' ');
			sb.append(user.vcLastname);
			sb.append('","isActive":');
			sb.append(user.btIsActive ? 'true' : 'false');
			sb.append(',"isPasswordExpired":');
			sb.append(user.btIsPasswordExpired ? 'true' : 'false');
			sb.append(',"isLocked":');
			sb.append(user.btIsLocked ? 'true' : 'false');
			sb.append(',"isProtected":');
			sb.append(user.btIsProtected ? 'true' : 'false');
			sb.append(',"passwordLastSetOn":"');
			sb.append(formatterService.formatDate(qUsers.dtPasswordLastSetOn));
			sb.append('","lastLoggedInOn":"');
			sb.append(formatterService.formatDate(qUsers.dtLastLoggedInOn));
			sb.append('"}');
		}

		sb.append("]");
		return sb.toString();
	}

	query function getAllUsers () {
		return userGateway.getAllUsers();
	}

	query function searchUsers (required string q) {
		return userGateway.searchUsers(q);
	}

	string function searchUsersJSON (required string q) {
		return usersQueryToJSON(searchUsers(q));
	}

	query function getUsersForGroup (required string groupAbbr) {
		return userGateway.getUsersForGroup(groupAbbr);
	}

	function loadByUsername (required string username) {
		return load(userGateway.getUserIDByUsername(username));
	}

	function loadByEmail (required string email) {
		return load(userGateway.getUserIDByEmail(email));
	}

	function loadByUsernameOrEmail (required string input) {
		return load(userGateway.getUserIDByUsernameOrEmail(input));
	}

	numeric function getUserIDByUsername (required string username) {
		return userGateway.getUserIDByUsername(username);
	}

	numeric function getUserIDByEmail (required string email) {
		return userGateway.getUserIDByEmail(email);
	}

	void function sendPasswordResetEmail (required any user) {
		var tempPassword = cryptoService.genPassword(minLength = 8, qtyNumbers = 2, qtyLowerCaseAlpha = 1, qtyOtherChars = 1);

		changePassword(
			  intUserID = user.getIntUserID()
			, newPassword = tempPassword
			, isTempPassword = true
			, requireNewPassword = true
			, setBy = user.getIntUserID()
			, setByIP = cgi.remote_addr);


		savecontent variable="local.body" {
			writeoutput("Your password has been reset.  Please use the following password the next time you login.  You will be required to change your password once you login.");
	        writeoutput("<br/>");
	        writeoutput("New Password: #tempPassword#<br/>");
		}

		var mail = new mail();
 		mail.setSubject("Your " & applicationDisplayName & " password has been reset");
 		mail.setFrom(getSetting("forgotPasswordEmailFrom"));
 		mail.setTo(user.getVcEmail());
 		mail.setType("html");
 		mail.setBody(local.body);
 		mail.send();
	}

	void function sendLoginInstructions (required any user, required string password) {
		savecontent variable="local.body" {
			writeoutput('
				Dear #user.getVcFirstname()# #user.getVcLastname()#,<br />
				Your account for #applicationDisplayName# has been created.  Click the link below and use the credentials supplied to log in.<br />
				<cfif user.isPasswordExpired()>You will be required to change your password once you login.<br /></cfif>
		        <br/>
				<a href="#loginURL#">#loginURL#</a><br />
		        Username: #user.getVcUsername()#<br />
				Password: #password#<br/>
			');
		}

		var mail = new mail();
 		mail.setSubject("Your " & applicationDisplayName & " account has been created");
 		mail.setFrom(loginInstructionsEmailFrom);
 		mail.setTo(user.getVcEmail());
 		mail.setType("html");
 		mail.setBody(local.body);
 		mail.send();
	}

	public boolean function validateCreate (required struct rc, required Messenger messenger) {

		assertExists(rc, "vcUsername");
		assertExists(rc, "vcEmail");
		assertExists(rc, "vcFirstName");
		assertExists(rc, "vcMiddleName");
		assertExists(rc, "vcLastName");
		assertExists(rc, "vcNamePrefix");
		assertExists(rc, "vcNameSuffix");
		assertExists(rc, "password");
		assertExists(rc, "vcAddress1");
		assertExists(rc, "vcAddress2");
		assertExists(rc, "vcCity");
		assertExists(rc, "vcState");
		assertExists(rc, "vcPostalCode");
		assertExists(rc, "vcPhone1");
		assertExists(rc, "vcPhone2");
		assertExists(rc, "intCreatedBy");
		assertExists(rc, "generatePassword");

		var createdBy = load(rc.intCreatedBy);

		if (!createdBy.getIntUserID()) {
			messenger.addAlert(messageType="ERROR",
								message="Created By is not valid",
								messageDetail="",
								field="intCreatedBy");
		}

		validateEmail(rc = rc
					, messenger = messenger
					, fieldName = "vcEmail"
					, friendlyName = "Email"
					, isRequired = true
					, minLength = 1
					, maxLength = 1024);

		var userByEmail = loadByEmail(rc.vcEmail);

		if (userByEmail.getIntUserID()) {
			messenger.addAlert(messageType="ERROR",
								message="The email address #rc.vcEmail# is already taken.",
								messageDetail="Please provide a different email address.",
								field="vcEmail");
		}


		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcNamePrefix"
					, friendlyName = "Prefix"
					, isRequired = false
					, maxLength = 25);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcFirstName"
					, friendlyName = "First Name"
					, isRequired = true
					, minLength = 1
					, maxLength = 200);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcMiddleName"
					, friendlyName = "Middle Name"
					, isRequired = false
					, maxLength = 200);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcLastName"
					, friendlyName = "Last Name"
					, isRequired = true
					, minLength = 1
					, maxLength = 200);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcNameSuffix"
					, friendlyName = "Suffix"
					, isRequired = false
					, maxLength = 25);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcAddress1"
					, friendlyName = "Address 1"
					, isRequired = false
					, maxLength = 200);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcAddress2"
					, friendlyName = "Address 2"
					, isRequired = false
					, maxLength = 200);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcCity"
					, friendlyName = "City"
					, isRequired = false
					, maxLength = 200);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcState"
					, friendlyName = "State"
					, isRequired = false
					, maxLength = 100);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcPostalCode"
					, friendlyName = "Postal Code"
					, isRequired = false
					, maxLength = 10);

		if (!rc.generatePassword) {
			var isPasswordLengthValid = validateLength(rc=rc
					, messenger = messenger
					, fieldName = "password"
					, friendlyName = "Password"
					, isRequired = true
					, maxLength = 100
					, minLength = 0);

			if (!local.isPasswordLengthValid){
				messenger.addAlert(messageType="ERROR"
								, message="You must provide a password."
								, messageDetail=""
								, field="password");
			}
		}



		//TODO: validatePhone(phone1)
		//TODO: validatePhone(phone2)


		return messenger.hasAlerts();
	}

	public boolean function validateUpdate (required struct rc, required Messenger messenger) {

		assertExists(rc, "userID");
		assertExists(rc, "vcEmail");
		assertExists(rc, "vcFirstName");
		assertExists(rc, "vcMiddleName");
		assertExists(rc, "vcLastName");
		assertExists(rc, "vcNamePrefix");
		assertExists(rc, "vcNameSuffix");
		assertExists(rc, "vcAddress1");
		assertExists(rc, "vcAddress2");
		assertExists(rc, "vcCity");
		assertExists(rc, "vcState");
		assertExists(rc, "vcPostalCode");
		assertExists(rc, "vcPhone1");
		assertExists(rc, "vcPhone2");
		assertExists(rc, "intLastModifiedBy");

		var lastModifiedBy = load(rc.intLastModifiedBy);

		if (!lastModifiedBy.getIntUserID()) {
			messenger.addAlert(messageType="ERROR",
								message="Last Modified By is not valid",
								messageDetail="",
								field="lastModifiedBy");
		}

		validateEmail(rc = rc
					, messenger = messenger
					, fieldName = "vcEmail"
					, friendlyName = "Email"
					, isRequired = true
					, minLength = 1
					, maxLength = 1024);

		var userByEmail = loadByEmail(rc.vcEmail);

		if (userByEmail.getIntUserID() && userByEmail.getIntUserID() != rc.userID) {
			messenger.addAlert(messageType="ERROR",
								message="The email address #rc.vcEmail# is already taken.",
								messageDetail="Please provide a different email address.",
								field="email");
		}


		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcNamePrefix"
					, friendlyName = "Prefix"
					, isRequired = false
					, maxLength = 25);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcFirstName"
					, friendlyName = "First Name"
					, isRequired = true
					, minLength = 1
					, maxLength = 250);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcMiddleName"
					, friendlyName = "Middle Name"
					, isRequired = false
					, maxLength = 250);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcLastName"
					, friendlyName = "Last Name"
					, isRequired = true
					, minLength = 1
					, maxLength = 250);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcNameSuffix"
					, friendlyName = "Suffix"
					, isRequired = false
					, maxLength = 25);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcAddress1"
					, friendlyName = "Address 1"
					, isRequired = false
					, maxLength = 250);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcAddress2"
					, friendlyName = "Address 2"
					, isRequired = false
					, maxLength = 250);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcCity"
					, friendlyName = "City"
					, isRequired = false
					, maxLength = 250);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcState"
					, friendlyName = "State"
					, isRequired = false
					, maxLength = 100);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcPostalCode"
					, friendlyName = "Postal Code"
					, isRequired = false
					, maxLength = 10);

		//TODO: validatePhone(phone1)
		//TODO: validatePhone(phone2)

		return messenger.hasAlerts();
	}

	boolean function validateChangePassword (required struct rc, required Messenger messenger) {

		assertExists(rc, "userID");
		assertExists(rc, "password");
		assertExists(rc, "password2");

		if (!load(rc.userID).getIntUserID()) {
			messenger.addAlert(messageType="ERROR",
								message="Invalid UserID: #rc.userID#",
								messageDetail="",
								field="userID");
			return true;
		}

		validateLength(rc=rc
						, messenger = messenger
						, fieldName = "password"
						, friendlyName = "Password"
						, isRequired = true
						, minLength = 3
						, maxLength = 250);

		validateLength(rc=rc
						, messenger = messenger
						, fieldName = "password2"
						, friendlyName = "Password Again"
						, isRequired = true
						, minLength = 0
						, maxLength = 250);

		if (compare(rc.password, rc.password2) != 0) {
			messenger.addAlert(messageType="ERROR",
								message="Provided passwords do not match",
								messageDetail="Please try again",
								field="password,password2");
		}

		if (/*load(rc.userID).getIsPasswordExpired() &&*/ !isNewPasswordDifferent(rc.userID, rc.password, passwordRotation)) {
			messenger.addAlert(messageType="ERROR",
								message="Password must not be same as a previous password",
								messageDetail="Please try again",
								field="");
		}

		return messenger.hasAlerts();
	}
}