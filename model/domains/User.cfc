component name="User" accessors=true extends="BaseDomain" {
	property type="Numeric" name="intUserID" getter=true;
	property type="String" name="vcUsername" getter=true;
	property type="String" name="vcEmail" getter=true;
	property type="String" name="vcFirstName" getter=true;
	property type="String" name="vcMiddleName" getter=true;
	property type="String" name="vcLastName" getter=true;
	property type="String" name="vcNamePrefix" getter=true;
	property type="String" name="vcNameSuffix" getter=true;
	property type="String" name="vcPassword" getter=true;
	property type="boolean" name="btIsPasswordExpired" getter=true;
	property type="date" name="dtPasswordLastSetOn" getter=true;
	property type="Numeric" name="intPasswordLastSetById" getter=true;
	property type="String" name="vcPasswordLastSetByIP" getter=true;
	property type="date" name="dtLastLoggedInOn" getter=true;
	property type="String" name="vcAddress1" getter=true;
	property type="String" name="vcAddress2" getter=true;
	property type="String" name="vcAddress3" getter=true;
	property type="String" name="vcCity" getter=true;
	property type="String" name="vcState" getter=true;
	property type="String" name="vcPostalCode" getter=true;
	property type="String" name="vcZip4" getter=true;
	property type="String" name="vcPhone1" getter=true;
	property type="String" name="vcPhone2" getter=true;
	property type="boolean" name="btIsActive" getter=true;
	property type="boolean" name="btIsProtected" getter=true;
	property type="boolean" name="btIsRemoved" getter=true;
	property type="date" name="dtCreatedOn" getter=true;
	property type="Numeric" name="intCreatedById" getter=true;
	property type="String" name="vcCreatedByIP" getter=true;
	property type="date" name="dtModifiedOn" getter=true;
	property type="Numeric" name="intModifiedById" getter=true;
	property type="String" name="vcModifiedByIP" getter=true;
	property ApiAccessKey AuthenticationKey;

	property boolean isLoggedIn;
	property array userGroups;

	public any function init () {

		setIDField("intUserID");

		setIntUserID(0);
		setVcUsername("");
		setVcEmail("");
		setVcFirstName("");
		setVcMiddleName("");
		setVcLastName("");
		setVcNamePrefix("");
		setVcNameSuffix("");
		setVcPassword("");
		setBtIsPasswordExpired(false);
		setDtPasswordLastSetOn(variables.instance.never);
		setIntPasswordLastSetById(0);
		setVcPasswordLastSetByIP("");
		setDtLastLoggedInOn(variables.instance.never);
		setVcAddress1("");
		setVcAddress2("");
		setVcAddress3("");
		setVcCity("");
		setVcState("");
		setVcPostalCode("");
		setVcZip4("");
		setVcPhone1("");
		setVcPhone2("");
		setBtIsActive(false);
		setBtIsProtected(false);
		setBtIsRemoved(false);
		setDtCreatedOn(variables.instance.never);
		setIntCreatedById(0);
		setVcCreatedByIP("");
		setDtModifiedOn(variables.instance.never);
		setIntModifiedById(0);
		setVcModifiedByIP("");

		variables.userGroups = [];
		setIsLoggedIn(false);
		variables.instance.isAdmin = false;

		return this;
	}

	public boolean function isLoggedIn() {
		return variables.isLoggedIn;
	}

	public boolean function btIsPasswordExpired() {
		return variables.btIsPasswordExpired;
	}

	public boolean function btIsActive() {
		return variables.btIsActive;
	}

	public boolean function btIsProtected() {
		return variables.btIsProtected;
	}

	public boolean function btIsRemoved() {
		return variables.btIsRemoved;
	}

	public array function getUserGroups () {
		return duplicate(variables.userGroups);
	}

	public void function addUserGroup ( required any group ) {
		arrayAppend(variables.userGroups, group);

		if (group.getVcGroupAbbr() == "ADMIN" ) {
			variables.instance.isAdmin = true;
		}
	}

	public boolean function isUserInGroup ( required string groupAbbr ) {
		if (variables.instance.isAdmin) {
			return true;
		}

		for (var group in variables.userGroups) {
			if (group.getVcGroupAbbr() == groupAbbr) {
				return true;
			}
		}

		return false;
	}

	public string function getAddressDisplay () {
		var br = "<br />";
		var sb = createObject("java", "java.lang.StringBuffer").init(getVcAddress1() & br);

		if (len(trim(getVcAddress2()))) {
			sb.append(getVcAddress2() & br);
		}
		if (len(trim(getVcAddress3()))) {
			sb.append(getVcAddress3() & br);
		}
		sb.append(getVcCity());
		if (len(trim(getVcCity())) && len(trim(getVcState()))) {
			sb.append(",");
		}
		sb.append(getVcState());
		if (len(trim(getVcState())) && len(trim(getVcPostalCode()))) {
			sb.append(" ");
		}
		sb.append(getVcPostalCode());
		if (len(trim(getVcZip4()))) {
			sb.append("-" & getVcZip4());
		}

		return sb.toString();
	}

	public string function getNameDisplay() {
		var sb = createObject("java", "java.lang.StringBuffer").init("");

		if (len(trim(getVcNamePrefix()))){
			sb.append(getVcNamePrefix() & " ");
		}
		if (len(trim(getVcFirstName()))){
			sb.append(getVcFirstName() & " ");
		}
		if (len(trim(getVcMiddleName()))){
			sb.append(getVcMiddleName() & " ");
		}
		if (len(trim(getVcLastName()))){
			sb.append(getVcLastName() & " ");
		}
		if (len(trim(getVcNameSuffix()))){
			sb.append(getVcNameSuffix() & " ");
		}

		return trim(sb.toString());
	}

	public string function toJSON() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intUserID":' & getIntUserID());
		sb.append(', "vcUsername":' & serializeJSON(getVcUsername()));
		sb.append(', "vcEmail":' & serializeJSON(getVcEmail()));
		sb.append(', "vcFirstName":' & serializeJSON(getVcFirstName()));
		sb.append(', "vcMiddleName":' & serializeJSON(getVcMiddleName()));
		sb.append(', "vcLastName":' & serializeJSON(getVcLastName()));
		sb.append(', "vcNamePrefix":' & serializeJSON(getVcNamePrefix()));
		sb.append(', "vcNameSuffix":' & serializeJSON(getVcNameSuffix()));
		sb.append(', "vcPassword":' & serializeJSON(getVcPassword()));
		sb.append(', "btIsPasswordExpired":' & (getBtIsPasswordExpired() ? 'true' : 'false'));
		sb.append(', "dtPasswordLastSetOn":"' & serializeJSON(getDtPasswordLastSetOn()));
		sb.append(', "intPasswordLastSetById":' & getIntPasswordLastSetById());
		sb.append(', "vcPasswordLastSetByIP":' & serializeJSON(getVcPasswordLastSetByIP()));
		sb.append(', "dtLastLoggedInOn":"' & serializeJSON(getDtLastLoggedInOn()));
		sb.append(', "vcAddress1":' & serializeJSON(getVcAddress1()));
		sb.append(', "vcAddress2":' & serializeJSON(getVcAddress2()));
		sb.append(', "vcAddress3":' & serializeJSON(getVcAddress3()));
		sb.append(', "vcCity":' & serializeJSON(getVcCity()));
		sb.append(', "vcState":' & serializeJSON(getVcState()));
		sb.append(', "vcPostalCode":' & serializeJSON(getVcPostalCode()));
		sb.append(', "vcZip4":' & serializeJSON(getVcZip4()));
		sb.append(', "vcPhone1":' & serializeJSON(getVcPhone1()));
		sb.append(', "vcPhone2":' & serializeJSON(getVcPhone2()));
		sb.append(', "btIsActive":' & (getBtIsActive() ? 'true' : 'false'));
		sb.append(', "btIsProtected":' & (getBtIsProtected() ? 'true' : 'false'));
		sb.append(', "btIsRemoved":' & (getBtIsRemoved() ? 'true' : 'false'));
		sb.append(', "dtCreatedOn":"' & serializeJSON(getDtCreatedOn()));
		sb.append(', "intCreatedById":' & getIntCreatedById());
		sb.append(', "vcCreatedByIP":' & serializeJSON(getVcCreatedByIP()));
		sb.append(', "dtModifiedOn":"' & serializeJSON(getDtModifiedOn()));
		sb.append(', "intModifiedById":' & getIntModifiedById());
		sb.append(', "vcModifiedByIP":' & serializeJSON(getVcModifiedByIP()));
		sb.append(', "groups":[');
		var i = 0;
		for (var group in variables.userGroups) {
			if (++i > 1) {
				sb.append(",");
			}
			sb.append(group.toJSONSimple());
		}
		sb.append("]");
		if (!isNull(getAuthenticationKey())) {
			sb.append(', "authKey":' & getAuthenticationKey().toJson());
		}

		sb.append("}");
		return sb.toString();
	}

	public string function toJSONSimple() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intUserID":' & getIntUserID());
		sb.append(', "vcUsername":' & serializeJSON(getVcUsername()));
		sb.append(', "vcEmail":' & serializeJSON(getVcEmail()));
		sb.append(', "vcFirstName":' & serializeJSON(getVcFirstName()));
		sb.append(', "vcMiddleName":' & serializeJSON(getVcMiddleName()));
		sb.append(', "vcLastName":' & serializeJSON(getVcLastName()));
		sb.append(', "vcNamePrefix":' & serializeJSON(getVcNamePrefix()));
		sb.append(', "vcNameSuffix":' & serializeJSON(getVcNameSuffix()));
		sb.append(', "vcPassword":' & serializeJSON(getVcPassword()));
		sb.append(', "btIsPasswordExpired":' & (getBtIsPasswordExpired() ? 'true' : 'false'));
		sb.append(', "dtPasswordLastSetOn":' & serializeJSON(getDtPasswordLastSetOn()));
		sb.append(', "intPasswordLastSetById":' & getIntPasswordLastSetById());
		sb.append(', "vcPasswordLastSetByIP":' & serializeJSON(getVcPasswordLastSetByIP()));
		sb.append(', "dtLastLoggedInOn":' & serializeJSON(getDtLastLoggedInOn()));
		sb.append(', "vcAddress1":' & serializeJSON(getVcAddress1()));
		sb.append(', "vcAddress2":' & serializeJSON(getVcAddress2()));
		sb.append(', "vcAddress3":' & serializeJSON(getVcAddress3()));
		sb.append(', "vcCity":' & serializeJSON(getVcCity()));
		sb.append(', "vcState":' & serializeJSON(getVcState()));
		sb.append(', "vcPostalCode":' & serializeJSON(getVcPostalCode()));
		sb.append(', "vcZip4":' & serializeJSON(getVcZip4()));
		sb.append(', "vcPhone1":' & serializeJSON(getVcPhone1()));
		sb.append(', "vcPhone2":' & serializeJSON(getVcPhone2()));
		sb.append(', "btIsActive":' & (getBtIsActive() ? 'true' : 'false'));
		sb.append(', "btIsProtected":' & (getBtIsProtected() ? 'true' : 'false'));
		sb.append(', "btIsRemoved":' & (getBtIsRemoved() ? 'true' : 'false'));
		sb.append(', "dtCreatedOn":' & serializeJSON(getDtCreatedOn()));
		sb.append(', "intCreatedById":' & getIntCreatedById());
		sb.append(', "vcCreatedByIP":' & serializeJSON(getVcCreatedByIP()));
		sb.append(', "dtModifiedOn":' & serializeJSON(getDtModifiedOn()));
		sb.append(', "intModifiedById":' & getIntModifiedById());
		sb.append(', "vcModifiedByIP":' & serializeJSON(getVcModifiedByIP()));
		sb.append(', "groups":[');
		var i = 0;
		for (var group in variables.userGroups) {
			if (++i > 1) {
				sb.append(",");
			}
			sb.append(group.toJSONSimple());
		}
		sb.append("]");
		if (!isNull(getAuthenticationKey())) {
			sb.append(', "authKey":' & getAuthenticationKey().toJson());
		}

		sb.append("}");
		return sb.toString();
	}

}
