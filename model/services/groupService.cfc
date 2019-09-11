component accessors=true extends="baseService" singleton=true {

	property name="groupGateway" inject="groupGateway";
	property name="userService" inject="userService";

	property name="never" inject="coldbox:setting:never";

	private any function create (required any group) {
		if (groupGateway.getGroupIDByGroupName(group.getVcGroupName())) {
			throw(type="GroupService.DuplicateGroupName", message="The groupName " & group.getVcGroupName() & " is already in use.");
		}

		if (groupGateway.getGroupIDByGroupAbbr(group.getVcGroupAbbr())) {
			throw(type="GroupService.DuplicateGroupAbbr", message="The groupAbbr " & group.getVcGroupAbbr() & " is already in use.");
		}

		var groupID = groupGateway.create(group);

		return load(groupID);
	}

	private any function update (required any group) {
		var groupNameCheck = groupGateway.getGroupIDByGroupName(group.getVcGroupName());
		var groupAbbrCheck = groupGateway.getGroupIDByGroupAbbr(group.getVcGroupAbbr());

		if (groupNameCheck && groupNameCheck != group.getIntGroupID()) {
			throw(type="GroupService.DuplicateGroupName", message="The groupName " & group.getVcGroupName() & " is already in use.");
		}

		if (groupAbbrCheck && groupAbbrCheck != group.getIntGroupID()) {
			throw(type="GroupService.DuplicateGroupAbbr", message="The groupAbbr " & group.getVcGroupAbbr() & " is already in use.");
		}

		groupGateway.update(group);

		return load(group.getIntGroupID());
	}

	function save (required any group) {
		if (group.getIntGroupID()) {
			return update(group);
		}

		return create(group);
	}

	function getEmptyDomain () {
		return new model.domains.Group();
	}

	public any function populate (required any group, required struct data ) {

		group.setIntGroupID(data.intGroupID);
		group.setVcGroupName(data.vcGroupName);
		group.setVcGroupAbbr(data.vcGroupAbbr);
		group.setVcGroupEmail(data.vcGroupEmail);
		group.setVcGroupDesc(data.vcGroupDesc);
		group.setBtIsProtected(data.btIsProtected);
		group.setBtIsRemoved(data.btIsRemoved);
		group.setDtCreatedOn(data.dtCreatedOn);
		group.setIntCreatedBy(data.intCreatedBy);
		group.setDtLastModifiedOn(data.dtLastModifiedOn);
		group.setIntLastModifiedBy(data.intLastModifiedBy);

		return group;
	}

	function load (required numeric groupID) {
		var group = getEmptyDomain();

		if (groupID == 0) {
			return group;
		}

		var qLoad = groupGateway.load(groupID);

		if (qLoad.recordCount) {
			populate(group, queryGetRow(qLoad, 1));
		}

		return group;
	}

	array function getAllGroups () {
		var qGroups = groupGateway.getAllGroups();

		return qGroups.reduce(function (acc, row) {
			acc.append(populate(getEmptyDomain(), row));
			return acc;
		}, []);
	}

	string function getAllGroupsJSON () {
		var groups = getAllGroups();
		var sb = createObject("java","java.lang.StringBuffer").init("[");
		sb = groups.reduce(function(sb, item, index) {
			if (index > 1) {
				sb.append(",");
			}
			sb.append(item.toJSONSimple());
			return sb;
		}, sb);
		sb.append("]");
		return sb.toString();
	}

	function loadByAbbr (required string groupAbbr) {
		return load(groupGateway.getGroupIDByGroupAbbr(groupAbbr));
	}

	function loadByName (required string groupName) {
		return load(groupGateway.getGroupIDByGroupName(groupName));
	}

	public boolean function validateCreate (required struct rc, required Messenger messenger) {

		assertExists(rc, "vcGroupName");
		assertExists(rc, "vcGroupAbbr");
		assertExists(rc, "vcGroupDesc");
		assertExists(rc, "vcGroupEmail");
		assertExists(rc, "intCreatedBy");
		assertExists(rc, "dtCreatedOn");

		/*var createdBy = userService.load(rc.intCreatedBy);

		if (!createdBy.getIntUserID()) {
			messenger.addAlert(messageType="ERROR",
								message="Created By is not valid",
								messageDetail="",
								field="intCreatedBy");
		}
*/
		if (groupGateway.getGroupIDByGroupName(rc.vcGroupName)) {
			messenger.addAlert(messageType="ERROR",
								message="Group Name is already taken",
								messageDetail="",
								field="vcGroupName");
		}

		if (groupGateway.getGroupIDByGroupAbbr(rc.vcGroupAbbr)) {
			messenger.addAlert(messageType="ERROR",
								message="Group Abbr is already taken",
								messageDetail="",
								field="vcGroupAbbr");
		}
		validateLength(rc=rc
				, messenger=messenger
				, fieldName="vcGroupName"
				, friendlyName="Group Name"
				, isRequired=true
				, maxLength=100);

		validateLength(rc=rc
				, messenger=messenger
				, fieldName="vcGroupAbbr"
				, friendlyName="Group Abbreviation"
				, isRequired=true
				, maxLength=25);

		validateLength(rc=rc
				, messenger=messenger
				, fieldName="vcGroupDesc"
				, friendlyName="Group Description"
				, isRequired=true
				, maxLength=2000);

		validateEmail(rc=rc
				, messenger=messenger
				, fieldName="vcGroupEmail"
				, friendlyName="Group Email"
				, isRequired=false
				, maxLength=256);

		return messenger.hasAlerts();
	}

	public boolean function validateUpdate (required struct rc, required Messenger messenger) {

		assertExists(rc, "groupID");
		assertExists(rc, "vcGroupDesc");
		assertExists(rc, "vcGroupEmail");
		assertExists(rc, "dtLastModifiedOn");
		assertExists(rc, "intLastModifiedBy");

		/*var lastModifiedBy = userService.load(rc.intLastModifiedBy);

		if (!lastModifiedBy.getIntUserID()) {
			messenger.addAlert(messageType="ERROR",
								message="Last Modified By is not valid",
								messageDetail="",
								field="lastModifiedBy");
		}*/

		validateLength(rc=rc
				, messenger=messenger
				, fieldName="vcGroupDesc"
				, friendlyName="Group Description"
				, isRequired=true
				, maxLength=2000);

		validateEmail(rc=rc
				, messenger=messenger
				, fieldName="vcGroupEmail"
				, friendlyName="Group Email"
				, isRequired=false
				, maxLength=256);


		return messenger.hasAlerts();
	}

}