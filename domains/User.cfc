component name="User" accessors="true" extends="BaseDomain" {
	property name="never" inject="coldbox:settings:never";

	property Numeric intUserID;
	property String vcUsername;
	property String vcEmail;
	property String vcFirstName;
	property String vcMiddleName;
	property String vcLastName;
	property String vcNamePrefix;
	property String vcNameSuffix;
	property String vcPassword;
	property boolean btIsPasswordExpired;
	property date dtPasswordLastSetOn;
	property Numeric intPasswordLastSetBy;
	property String vcPasswordLastSetByIP;
	property date dtLastLoggedInOn;
	property String vcAddress1;
	property String vcAddress2;
	property String vcAddress3;
	property String vcCity;
	property String vcState;
	property String vcPostalCode;
	property String vcZip4;
	property String vcPhone1;
	property String vcPhone2;
	property boolean btIsActive;
	property boolean btIsProtected;
	property boolean btIsLocked;
	property date dtCreatedOn;
	property Numeric intCreatedBy;
	property String vcCreatedByIP;
	property date dtLastModifiedOn;
	property Numeric intLastModifiedBy;
	property String vcLastModifiedByIP;
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
		setIntPasswordLastSetBy(0);
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
		setBtIsLocked(false);
		setDtCreatedOn(variables.instance.never);
		setIntCreatedBy(0);
		setVcCreatedByIP("");
		setDtLastModifiedOn(variables.instance.never);
		setIntLastModifiedBy(0);
		setVcLastModifiedByIP("");

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

	public boolean function btIsLocked() {
		return variables.btIsLocked;
	}

	public boolean function hasBeenModified () {
		return dateCompare(dtLastModifiedOn, never) != 0;
	}

	public boolean function hasLoggedIn () {
		return dateCompare(dtLastLoggedInOn, never) != 0;
	}

	public array function getUserGroups () {
		return duplicate(variables.userGroups);
	}

	public string function getFormattedPhone1() {
		formatterService.formatPhone(getVcPhone1());
	}

	public string function getFormattedPhone2() {
		formatterService.formatPhone(getVcPhone2());
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
		sb.append(', "dtPasswordLastSetOn":"' & formatterService.formatDateTime(getDtPasswordLastSetOn()) & '"');
		sb.append(', "intPasswordLastSetBy":' & getIntPasswordLastSetBy());
		sb.append(', "vcPasswordLastSetByIP":' & serializeJSON(getVcPasswordLastSetByIP()));
		sb.append(', "dtLastLoggedInOn":"' & formatterService.formatDateTime(getDtLastLoggedInOn()) & '"');
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
		sb.append(', "btIsLocked":' & (getBtIsLocked() ? 'true' : 'false'));
		sb.append(', "dtCreatedOn":"' & formatterService.formatDateTime(getDtCreatedOn()) & '"');
		sb.append(', "intCreatedBy":' & getIntCreatedBy());
		sb.append(', "vcCreatedByIP":' & serializeJSON(getVcCreatedByIP()));
		sb.append(', "dtLastModifiedOn":"' & formatterService.formatDateTime(getDtLastModifiedOn()) & '"');
		sb.append(', "intLastModifiedBy":' & getIntLastModifiedBy());
		sb.append(', "vcLastModifiedByIP":' & serializeJSON(getVcLastModifiedByIP()));
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
		sb.append(', "dtPasswordLastSetOn":"' & formatterService.formatDateTime(getDtPasswordLastSetOn()) & '"');
		sb.append(', "intPasswordLastSetBy":' & getIntPasswordLastSetBy());
		sb.append(', "vcPasswordLastSetByIP":' & serializeJSON(getVcPasswordLastSetByIP()));
		sb.append(', "dtLastLoggedInOn":"' & formatterService.formatDateTime(getDtLastLoggedInOn()) & '"');
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
		sb.append(', "btIsLocked":' & (getBtIsLocked() ? 'true' : 'false'));
		sb.append(', "dtCreatedOn":"' & formatterService.formatDateTime(getDtCreatedOn()) & '"');
		sb.append(', "intCreatedBy":' & getIntCreatedBy());
		sb.append(', "vcCreatedByIP":' & serializeJSON(getVcCreatedByIP()));
		sb.append(', "dtLastModifiedOn":"' & formatterService.formatDateTime(getDtLastModifiedOn()) & '"');
		sb.append(', "intLastModifiedBy":' & getIntLastModifiedBy());
		sb.append(', "vcLastModifiedByIP":' & serializeJSON(getVcLastModifiedByIP()));
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
