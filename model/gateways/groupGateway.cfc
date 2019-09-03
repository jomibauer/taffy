<cfcomponent name="groupGateway" extends="baseGateway" output="false" singleton="true">

	<cffunction name="create" access="public" returntype="numeric" output="false">
		<cfargument name="group" type="any" required="true" />

		<cfquery name="local.qCreate" result="local.qCreateResult">
			INSERT INTO dbo.tblGroup
			(
				  vcGroupName		/*  - varchar(100)*/
				, vcGroupAbbr		/*  - varchar(25)*/
				, vcGroupEmail		/*  - varchar(200)*/
				, vcGroupDesc		/*  - varchar(2000)*/
				, btIsProtected		/*  - bit*/
				, btIsRemoved		/*  - bit*/
				, dtCreatedOn		/*  - datetime*/
				, intCreatedBy		/*  - int*/
				, dtLastModifiedOn	/*  - datetime*/
				, intLastModifiedBy	/*  - int*/
			)
			VALUES
			(
				  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.group.getVcGroupName()#"/>	/* vcGroupName - varchar (100) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.group.getVcGroupAbbr()#"/>	/* vcGroupAbbr - varchar (25) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.group.getVcGroupEmail()#"/>	/* vcGroupEmail - varchar (200) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.group.getVcGroupDesc()#"/>	/* vcGroupDesc - varchar (2000) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.group.getBtIsProtected()#"/>	/* btIsProtected - bit */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.group.getBtIsRemoved()#"/>	/* btIsRemoved - bit */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.group.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.group.getIntCreatedBy()#"/>	/* intCreatedBy - int */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.group.getDtLastModifiedOn()#"/>	/* dtLastModifiedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.group.getIntLastModifiedBy()#"/>	/* intLastModifiedBy - int */
			);
		</cfquery>

	<cfreturn local.qCreateResult.generatedKey />
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="group" type="any" required="true" />

		<cfquery name="local.qUpdate">
			UPDATE dbo.tblGroup
			SET
				  vcGroupName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.group.getVcGroupName()#"/>	/* vcGroupName - varchar (100) */
				, vcGroupAbbr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.group.getVcGroupAbbr()#"/>	/* vcGroupAbbr - varchar (25) */
				, vcGroupEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.group.getVcGroupEmail()#"/>	/* vcGroupEmail - varchar (200) */
				, vcGroupDesc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.group.getVcGroupDesc()#"/>	/* vcGroupDesc - varchar (2000) */
				, btIsProtected = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.group.getBtIsProtected()#"/>	/* btIsProtected - bit */
				, btIsRemoved = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.group.getBtIsRemoved()#"/>	/* btIsRemoved - bit */
				, dtCreatedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.group.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, intCreatedBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.group.getIntCreatedBy()#"/>	/* intCreatedBy - int */
				, dtLastModifiedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.group.getDtLastModifiedOn()#"/>	/* dtLastModifiedOn - datetime */
				, intLastModifiedBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.group.getIntLastModifiedBy()#"/>	/* intLastModifiedBy - int */
			WHERE intGroupID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.group.getIntGroupID()#"/>
		</cfquery>

	</cffunction>

	<cffunction name="load" access="public" returntype="query" output="false">
		<cfargument name="intGroupID" type="numeric" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				  tblGroup.intGroupID		/*  - int*/
				, tblGroup.vcGroupName		/*  - varchar(100)*/
				, tblGroup.vcGroupAbbr		/*  - varchar(25)*/
				, tblGroup.vcGroupEmail		/*  - varchar(200)*/
				, tblGroup.vcGroupDesc		/*  - varchar(2000)*/
				, tblGroup.btIsProtected		/*  - bit*/
				, tblGroup.btIsRemoved		/*  - bit*/
				, tblGroup.dtCreatedOn		/*  - datetime*/
				, tblGroup.intCreatedBy		/*  - int*/
				, tblGroup.dtLastModifiedOn	/*  - datetime*/
				, tblGroup.intLastModifiedBy	/*  - int*/
			FROM dbo.tblGroup
			WHERE tblGroup.intGroupID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intGroupID#"/>
		</cfquery>

	<cfreturn local.qLoad />
	</cffunction>

	<cffunction name="loadAll" access="public" returntype="query" output="false">

		<cfquery name="local.qLoadAll">
			SELECT
				  tblGroup.intGroupID		/*  - int*/
				, tblGroup.vcGroupName		/*  - varchar(100)*/
				, tblGroup.vcGroupAbbr		/*  - varchar(25)*/
				, tblGroup.vcGroupEmail		/*  - varchar(200)*/
				, tblGroup.vcGroupDesc		/*  - varchar(2000)*/
				, tblGroup.btIsProtected		/*  - bit*/
				, tblGroup.btIsRemoved		/*  - bit*/
				, tblGroup.dtCreatedOn		/*  - datetime*/
				, tblGroup.intCreatedBy		/*  - int*/
				, tblGroup.dtLastModifiedOn	/*  - datetime*/
				, tblGroup.intLastModifiedBy	/*  - int*/
			FROM dbo.tblGroup
			WHERE tblGroup.btIsRemoved = 0
			ORDER BY 1 ASC
		</cfquery>

	<cfreturn local.qLoadAll />
	</cffunction>

	<cffunction name="getAllGroups" access="public" returntype="query" output="false">

		<cfquery name="local.qLoadAll">
			SELECT
				  tblGroup.intGroupID		/*  - int*/
				, tblGroup.vcGroupName		/*  - varchar(100)*/
				, tblGroup.vcGroupAbbr		/*  - varchar(25)*/
				, tblGroup.vcGroupEmail		/*  - varchar(200)*/
				, tblGroup.vcGroupDesc		/*  - varchar(2000)*/
				, tblGroup.btIsProtected		/*  - bit*/
				, tblGroup.btIsRemoved		/*  - bit*/
				, tblGroup.dtCreatedOn		/*  - datetime*/
				, tblGroup.intCreatedBy		/*  - int*/
				, tblGroup.dtLastModifiedOn	/*  - datetime*/
				, tblGroup.intLastModifiedBy	/*  - int*/
			FROM dbo.tblGroup
			WHERE tblGroup.btIsRemoved = 0
			ORDER BY 1 ASC
		</cfquery>

	<cfreturn local.qLoadAll />
	</cffunction>

	<cffunction name="getGroupIDByGroupName" access="public" returntype="numeric" output="false">
		<cfargument name="vcGroupName" type="string" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				tblGroup.intGroupID
			FROM dbo.tblGroup
			WHERE
				tblGroup.vcGroupName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcGroupName#"/>
				AND tblGroup.btIsRemoved = 0
		</cfquery>

		<cfif local.qLoad.recordCount>
			<cfreturn local.qLoad.intGroupID />
		</cfif>

	<cfreturn 0 />
	</cffunction>

	<cffunction name="getGroupIDByGroupAbbr" access="public" returntype="numeric" output="false">
		<cfargument name="vcGroupAbbr" type="string" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				tblGroup.intGroupID
			FROM dbo.tblGroup
			WHERE
				tblGroup.vcGroupAbbr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcGroupAbbr#"/>
            	AND tblGroup.btIsRemoved = 0
		</cfquery>

		<cfif local.qLoad.recordCount>
			<cfreturn local.qLoad.intGroupID />
		</cfif>

	<cfreturn 0 />
	</cffunction>

</cfcomponent>