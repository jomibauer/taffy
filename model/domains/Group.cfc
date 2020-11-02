component name="Group" accessors=true extends="BaseDomain" {

	property type="Numeric" name="intGroupID" getter=true;
	property type="String" name="vcGroupName" getter=true;
	property type="String" name="vcGroupAbbr" getter=true;
	property type="String" name="vcGroupEmail" getter=true;
	property type="String" name="vcGroupDesc" getter=true;
	property type="boolean" name="btIsProtected" getter=true;
	property type="boolean" name="btIsRemoved" getter=true;
	property type="date" name="dtCreatedOn" getter=true;
	property type="Numeric" name="intCreatedBy" getter=true;
	property type="date" name="dtLastModifiedOn" getter=true;
	property type="Numeric" name="intLastModifiedBy" getter=true;

	public any function init () {

		setIDField("intGroupID");

		setIntGroupID(0);
		setVcGroupName("");
		setVcGroupAbbr("");
		setVcGroupEmail("");
		setVcGroupDesc("");
		setBtIsProtected(false);
		setBtIsRemoved(false);
		setDtCreatedOn(variables.instance.never);
		setIntCreatedBy(0);
		setDtLastModifiedOn(variables.instance.never);
		setIntLastModifiedBy(0);

		return this;
	}

	public boolean function btIsProtected() {
		return variables.btIsProtected;
	}

	public boolean function btIsRemoved() {
		return variables.btIsRemoved;
	}

	public string function toJSON() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intGroupID":' & getIntGroupID());
		sb.append(', "vcGroupName":' & serializeJSON(getVcGroupName()));
		sb.append(', "vcGroupAbbr":' & serializeJSON(getVcGroupAbbr()));
		sb.append(', "vcGroupEmail":' & serializeJSON(getVcGroupEmail()));
		sb.append(', "vcGroupDesc":' & serializeJSON(getVcGroupDesc()));
		sb.append(', "btIsProtected":' & serializeJSON(getBtIsProtected()));
		sb.append(', "btIsRemoved":' & serializeJSON(getBtIsRemoved()));
		sb.append(', "dtCreatedOn":' & serializeJSON(getDtCreatedOn()));
		sb.append(', "intCreatedBy":' & getIntCreatedBy());
		sb.append(', "dtLastModifiedOn":' & serializeJSON(getDtLastModifiedOn()));
		sb.append(', "intLastModifiedBy":' & getIntLastModifiedBy());
		sb.append("}");
		return sb.toString();
	}

	public string function toJSONSimple() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intGroupID":' & getIntGroupID());
		sb.append(', "vcGroupName":' & serializeJSON(getVcGroupName()));
		sb.append(', "vcGroupAbbr":' & serializeJSON(getVcGroupAbbr()));
		sb.append(', "vcGroupEmail":' & serializeJSON(getVcGroupEmail()));
		sb.append(', "vcGroupDesc":' & serializeJSON(getVcGroupDesc()));
		sb.append(', "btIsProtected":' & serializeJSON(getBtIsProtected()));
		sb.append(', "btIsRemoved":' & serializeJSON(getBtIsRemoved()));
		sb.append(', "dtCreatedOn":' & serializeJSON(getDtCreatedOn()));
		sb.append(', "intCreatedBy":' & getIntCreatedBy());
		sb.append(', "dtLastModifiedOn":' & serializeJSON(getDtLastModifiedOn()));
		sb.append(', "intLastModifiedBy":' & getIntLastModifiedBy());
		sb.append("}");
		return sb.toString();
	}

}

