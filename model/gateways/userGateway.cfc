<cfcomponent name="userGateway" extends="baseGateway" output="true" singleton="true">

	<cffunction name="create" access="public" returntype="numeric" output="false">
		<cfargument name="user" type="any" required="true" />

		<cfquery name="local.qCreate" result="local.qCreateResult">
			INSERT INTO dbo.tblUser
			(
				  vcUsername		/*  - varchar(200)*/
				, vcEmail		/*  - varchar(200)*/
				, vcFirstName		/*  - varchar(200)*/
				, vcMiddleName		/*  - varchar(200)*/
				, vcLastName		/*  - varchar(200)*/
				, vcNamePrefix		/*  - varchar(25)*/
				, vcNameSuffix		/*  - varchar(25)*/
				, vcPassword		/*  - varchar(512)*/
				, btIsPasswordExpired	/*  - bit*/
				, dtPasswordLastSetOn	/*  - datetime*/
				, intPasswordLastSetBy	/*  - int*/
				, vcPasswordLastSetByIP	/*  - varchar(50)*/
				, dtLastLoggedInOn	/*  - datetime*/
				, vcAddress1		/*  - varchar(200)*/
				, vcAddress2		/*  - varchar(200)*/
				, vcAddress3		/*  - varchar(200)*/
				, vcCity		/*  - varchar(200)*/
				, vcState		/*  - varchar(100)*/
				, vcPostalCode		/*  - varchar(10)*/
				, vcZip4		/*  - varchar(4)*/
				, vcPhone1		/*  - varchar(25)*/
				, vcPhone2		/*  - varchar(25)*/
				, btIsActive		/*  - bit*/
				, btIsProtected		/*  - bit*/
				, btIsLocked		/*  - bit*/
				, dtCreatedOn		/*  - datetime*/
				, intCreatedBy		/*  - int*/
				, vcCreatedByIP		/*  - varchar(50)*/
				, dtLastModifiedOn	/*  - datetime*/
				, intLastModifiedBy	/*  - int*/
				, vcLastModifiedByIP	/*  - varchar(50)*/
			)
			VALUES
			(
				  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcUsername()#"/>	/* vcUsername - varchar (200) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcEmail()#"/>	/* vcEmail - varchar (200) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcFirstName()#"/>	/* vcFirstName - varchar (200) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcMiddleName()#"/>	/* vcMiddleName - varchar (200) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcLastName()#"/>	/* vcLastName - varchar (200) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcNamePrefix()#"/>	/* vcNamePrefix - varchar (25) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcNameSuffix()#"/>	/* vcNameSuffix - varchar (25) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcPassword()#"/>	/* vcPassword - varchar (512) */
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.user.getBtIsPasswordExpired()#"/>	/* btIsPasswordExpired - bit */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.user.getDtPasswordLastSetOn()#"/>	/* dtPasswordLastSetOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getIntPasswordLastSetBy()#"/>	/* intPasswordLastSetBy - int */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcPasswordLastSetByIP()#"/>	/* vcPasswordLastSetByIP - varchar (50) */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.user.getDtLastLoggedInOn()#"/>	/* dtLastLoggedInOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcAddress1()#"/>	/* vcAddress1 - varchar (200) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcAddress2()#"/>	/* vcAddress2 - varchar (200) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcAddress3()#"/>	/* vcAddress3 - varchar (200) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcCity()#"/>	/* vcCity - varchar (200) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcState()#"/>	/* vcState - varchar (100) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcPostalCode()#"/>	/* vcPostalCode - varchar (10) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcZip4()#"/>	/* vcZip4 - varchar (4) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcPhone1()#"/>	/* vcPhone1 - varchar (25) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcPhone2()#"/>	/* vcPhone2 - varchar (25) */
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.user.getBtIsActive()#"/>	/* btIsActive - bit */
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.user.getBtIsProtected()#"/>	/* btIsProtected - bit */
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.user.getBtIsLocked()#"/>	/* btIsLocked - bit */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.user.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getIntCreatedBy()#"/>	/* intCreatedBy - int */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcCreatedByIP()#"/>	/* vcCreatedByIP - varchar (50) */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.user.getDtLastModifiedOn()#"/>	/* dtLastModifiedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getIntLastModifiedBy()#"/>	/* intLastModifiedBy - int */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcLastModifiedByIP()#"/>	/* vcLastModifiedByIP - varchar (50) */
			);
		</cfquery>

	<cfreturn local.qCreateResult.generatedKey />
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="user" type="any" required="true" />

		<cfquery name="local.qUpdate">
			UPDATE dbo.tblUser
			SET
				  vcUsername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcUsername()#"/>	/* vcUsername - varchar (200) */
				, vcEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcEmail()#"/>	/* vcEmail - varchar (200) */
				, vcFirstName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcFirstName()#"/>	/* vcFirstName - varchar (200) */
				, vcMiddleName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcMiddleName()#"/>	/* vcMiddleName - varchar (200) */
				, vcLastName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcLastName()#"/>	/* vcLastName - varchar (200) */
				, vcNamePrefix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcNamePrefix()#"/>	/* vcNamePrefix - varchar (25) */
				, vcNameSuffix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcNameSuffix()#"/>	/* vcNameSuffix - varchar (25) */
				, vcPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcPassword()#"/>	/* vcPassword - varchar (512) */
				, btIsPasswordExpired = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.user.getBtIsPasswordExpired()#"/>	/* btIsPasswordExpired - bit */
				, dtPasswordLastSetOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.user.getDtPasswordLastSetOn()#"/>	/* dtPasswordLastSetOn - datetime */
				, intPasswordLastSetBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getIntPasswordLastSetBy()#"/>	/* intPasswordLastSetBy - int */
				, vcPasswordLastSetByIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcPasswordLastSetByIP()#"/>	/* vcPasswordLastSetByIP - varchar (50) */
				, dtLastLoggedInOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.user.getDtLastLoggedInOn()#"/>	/* dtLastLoggedInOn - datetime */
				, vcAddress1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcAddress1()#"/>	/* vcAddress1 - varchar (200) */
				, vcAddress2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcAddress2()#"/>	/* vcAddress2 - varchar (200) */
				, vcAddress3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcAddress3()#"/>	/* vcAddress3 - varchar (200) */
				, vcCity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcCity()#"/>	/* vcCity - varchar (200) */
				, vcState = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcState()#"/>	/* vcState - varchar (100) */
				, vcPostalCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcPostalCode()#"/>	/* vcPostalCode - varchar (10) */
				, vcZip4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcZip4()#"/>	/* vcZip4 - varchar (4) */
				, vcPhone1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcPhone1()#"/>	/* vcPhone1 - varchar (25) */
				, vcPhone2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcPhone2()#"/>	/* vcPhone2 - varchar (25) */
				, btIsActive = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.user.getBtIsActive()#"/>	/* btIsActive - bit */
				, btIsProtected = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.user.getBtIsProtected()#"/>	/* btIsProtected - bit */
				, btIsLocked = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.user.getBtIsLocked()#"/>	/* btIsLocked - bit */
				, dtCreatedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.user.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, intCreatedBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getIntCreatedBy()#"/>	/* intCreatedBy - int */
				, vcCreatedByIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcCreatedByIP()#"/>	/* vcCreatedByIP - varchar (50) */
				, dtLastModifiedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.user.getDtLastModifiedOn()#"/>	/* dtLastModifiedOn - datetime */
				, intLastModifiedBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getIntLastModifiedBy()#"/>	/* intLastModifiedBy - int */
				, vcLastModifiedByIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getVcLastModifiedByIP()#"/>	/* vcLastModifiedByIP - varchar (50) */
			WHERE intUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getIntUserID()#"/>
		</cfquery>

	</cffunction>

	<cffunction name="load" access="public" returntype="query" output="false">
		<cfargument name="intUserID" type="numeric" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				  tblUser.intUserID		/*  - int*/
				, tblUser.vcUsername		/*  - varchar(200)*/
				, tblUser.vcEmail		/*  - varchar(200)*/
				, tblUser.vcFirstName		/*  - varchar(200)*/
				, tblUser.vcMiddleName		/*  - varchar(200)*/
				, tblUser.vcLastName		/*  - varchar(200)*/
				, tblUser.vcNamePrefix		/*  - varchar(25)*/
				, tblUser.vcNameSuffix		/*  - varchar(25)*/
				, tblUser.vcPassword		/*  - varchar(512)*/
				, tblUser.btIsPasswordExpired	/*  - bit*/
				, tblUser.dtPasswordLastSetOn	/*  - datetime*/
				, tblUser.intPasswordLastSetBy	/*  - int*/
				, tblUser.vcPasswordLastSetByIP	/*  - varchar(50)*/
				, tblUser.dtLastLoggedInOn	/*  - datetime*/
				, tblUser.vcAddress1		/*  - varchar(200)*/
				, tblUser.vcAddress2		/*  - varchar(200)*/
				, tblUser.vcAddress3		/*  - varchar(200)*/
				, tblUser.vcCity		/*  - varchar(200)*/
				, tblUser.vcState		/*  - varchar(100)*/
				, tblUser.vcPostalCode		/*  - varchar(10)*/
				, tblUser.vcZip4		/*  - varchar(4)*/
				, tblUser.vcPhone1		/*  - varchar(25)*/
				, tblUser.vcPhone2		/*  - varchar(25)*/
				, tblUser.btIsActive		/*  - bit*/
				, tblUser.btIsProtected		/*  - bit*/
				, tblUser.btIsLocked		/*  - bit*/
				, tblUser.dtCreatedOn		/*  - datetime*/
				, tblUser.intCreatedBy		/*  - int*/
				, tblUser.vcCreatedByIP		/*  - varchar(50)*/
				, tblUser.dtLastModifiedOn	/*  - datetime*/
				, tblUser.intLastModifiedBy	/*  - int*/
				, tblUser.vcLastModifiedByIP	/*  - varchar(50)*/
			FROM dbo.tblUser
			WHERE tblUser.intUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intUserID#"/>
		</cfquery>

	<cfreturn local.qLoad />
	</cffunction>

	<cffunction name="loadAll" access="public" returntype="query" output="false">

		<cfquery name="local.qLoadAll">
			SELECT
				  tblUser.intUserID		/*  - int*/
				, tblUser.vcUsername		/*  - varchar(200)*/
				, tblUser.vcEmail		/*  - varchar(200)*/
				, tblUser.vcFirstName		/*  - varchar(200)*/
				, tblUser.vcMiddleName		/*  - varchar(200)*/
				, tblUser.vcLastName		/*  - varchar(200)*/
				, tblUser.vcNamePrefix		/*  - varchar(25)*/
				, tblUser.vcNameSuffix		/*  - varchar(25)*/
				, tblUser.vcPassword		/*  - varchar(512)*/
				, tblUser.btIsPasswordExpired	/*  - bit*/
				, tblUser.dtPasswordLastSetOn	/*  - datetime*/
				, tblUser.intPasswordLastSetBy	/*  - int*/
				, tblUser.vcPasswordLastSetByIP	/*  - varchar(50)*/
				, tblUser.dtLastLoggedInOn	/*  - datetime*/
				, tblUser.vcAddress1		/*  - varchar(200)*/
				, tblUser.vcAddress2		/*  - varchar(200)*/
				, tblUser.vcAddress3		/*  - varchar(200)*/
				, tblUser.vcCity		/*  - varchar(200)*/
				, tblUser.vcState		/*  - varchar(100)*/
				, tblUser.vcPostalCode		/*  - varchar(10)*/
				, tblUser.vcZip4		/*  - varchar(4)*/
				, tblUser.vcPhone1		/*  - varchar(25)*/
				, tblUser.vcPhone2		/*  - varchar(25)*/
				, tblUser.btIsActive		/*  - bit*/
				, tblUser.btIsProtected		/*  - bit*/
				, tblUser.btIsLocked		/*  - bit*/
				, tblUser.dtCreatedOn		/*  - datetime*/
				, tblUser.intCreatedBy		/*  - int*/
				, tblUser.vcCreatedByIP		/*  - varchar(50)*/
				, tblUser.dtLastModifiedOn	/*  - datetime*/
				, tblUser.intLastModifiedBy	/*  - int*/
				, tblUser.vcLastModifiedByIP	/*  - varchar(50)*/
			FROM dbo.tblUser
			ORDER BY 1 ASC
		</cfquery>

	<cfreturn local.qLoadAll />
	</cffunction>

	<cffunction name="changePassword" access="public" returntype="void" output="false">
		<cfargument name="intUserID" type="numeric" required="true" />
		<cfargument name="newPassword" type="string" required="true" />
		<cfargument name="isTempPassword" type="boolean" required="true" />
		<cfargument name="setBy" type="numeric" required="true" />
		<cfargument name="setByIP" type="string" required="true" />

		<cfquery name="qUpdate">
			UPDATE dbo.tblUser
			SET
				  tblUser.vcPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.newPassword#" />
				, tblUser.btIsPasswordExpired = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.isTempPassword#" />
				, tblUser.dtPasswordLastSetOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#" />
				, tblUser.intPasswordLastSetBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.setBy#" />
				, tblUser.vcPasswordLastSetByIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.setByIP#" />
			WHERE tblUser.intUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intUserID#" />
		</cfquery>

		<cfquery name="qLogPasswordChange">
			INSERT INTO
				dbo.tblUserPreviousPassword
			(
				 tblUserPreviousPassword.intUserID
				, tblUserPreviousPassword.vcPassword
				, tblUserPreviousPassword.btIsTempPassword
				, tblUserPreviousPassword.dtPasswordLastSetOn
				, tblUserPreviousPassword.intPasswordLastSetBy
				, tblUserPreviousPassword.vcPasswordLastSetByIP
			)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intUserID#" />
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.newPassword#" />
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.isTempPassword#" />
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#" />
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.setBy#" />
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.setByIP#" />
			)
		</cfquery>

	</cffunction>

	<cffunction name="updateLastLoggedIn" access="public" returntype="void" output="false">
		<cfargument name="intUserID" type="numeric" required="true" />

		<cfquery name="qUpdate">
			UPDATE dbo.tblUser
			SET tblUser.dtLastLoggedInOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#" />
			WHERE tblUser.intUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intUserID#" />
		</cfquery>

	</cffunction>

	<cffunction name="getAllUsers" access="public" returntype="query" output="false">

		<cfquery name="qGetAllUsers">
			SELECT
				  tblUser.intUserID		/*  - int*/
				, tblUser.vcUsername		/*  - varchar(200)*/
				, tblUser.vcEmail		/*  - varchar(200)*/
				, tblUser.vcFirstName		/*  - varchar(200)*/
				, tblUser.vcMiddleName		/*  - varchar(200)*/
				, tblUser.vcLastName		/*  - varchar(200)*/
				, tblUser.vcNamePrefix		/*  - varchar(25)*/
				, tblUser.vcNameSuffix		/*  - varchar(25)*/
				, tblUser.vcPassword		/*  - varchar(512)*/
				, tblUser.btIsPasswordExpired	/*  - bit*/
				, tblUser.dtPasswordLastSetOn	/*  - datetime*/
				, tblUser.intPasswordLastSetBy	/*  - int*/
				, tblUser.vcPasswordLastSetByIP	/*  - varchar(50)*/
				, tblUser.dtLastLoggedInOn	/*  - datetime*/
				, tblUser.vcAddress1		/*  - varchar(200)*/
				, tblUser.vcAddress2		/*  - varchar(200)*/
				, tblUser.vcAddress3		/*  - varchar(200)*/
				, tblUser.vcCity		/*  - varchar(200)*/
				, tblUser.vcState		/*  - varchar(100)*/
				, tblUser.vcPostalCode		/*  - varchar(10)*/
				, tblUser.vcZip4		/*  - varchar(4)*/
				, tblUser.vcPhone1		/*  - varchar(25)*/
				, tblUser.vcPhone2		/*  - varchar(25)*/
				, tblUser.btIsActive		/*  - bit*/
				, tblUser.btIsProtected		/*  - bit*/
				, tblUser.btIsLocked		/*  - bit*/
				, tblUser.dtCreatedOn		/*  - datetime*/
				, tblUser.intCreatedBy		/*  - int*/
				, tblUser.vcCreatedByIP		/*  - varchar(50)*/
				, tblUser.dtLastModifiedOn	/*  - datetime*/
				, tblUser.intLastModifiedBy	/*  - int*/
				, tblUser.vcLastModifiedByIP	/*  - varchar(50)*/
			FROM dbo.tblUser
			ORDER BY tblUser.vcUsername ASC
		</cfquery>

	<cfreturn qGetAllUsers />
	</cffunction>

	<cffunction name="searchUsers" access="public" returntype="query" output="false">
		<cfargument name="q" type="string" required="false" />

		<cfquery name="qSearch">
			SELECT
				  tblUser.intUserID
				, tblUser.vcUsername
				, tblUser.vcEmail
				, tblUser.vcFirstName
				--, tblUser.vcMiddleName
				, tblUser.vcLastName
				--, tblUser.vcNamePrefix
				--, tblUser.vcNameSuffix
				, tblUser.btIsPasswordExpired
				, tblUser.dtPasswordLastSetOn
				--, tblUser.intPasswordLastSetBy
				--, tblUser.vcPasswordLastSetByIP
				, tblUser.dtLastLoggedInOn
				--, tblUser.vcAddress1
				--, tblUser.vcAddress2
				--, tblUser.vcAddress3
				--, tblUser.vcCity
				--, tblUser.vcState
				--, tblUser.vcPostalCode
				--, tblUser.vcZip4
				--, tblUser.vcPhone1
				--, tblUser.vcPhone2
				, tblUser.btIsActive
				, tblUser.btIsProtected
				, tblUser.btIsLocked
				--, tblUser.dtCreatedOn
				--, tblUser.intCreatedBy
				--, tblUser.vcCreatedByIP
				--, tblUser.dtLastModifiedOn
				--, tblUser.intLastModifiedBy
				--, tblUser.vcLastModifiedByIP
			FROM dbo.tblUser
			WHERE
				(
					tblUser.vcFirstName LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.q#%" />
				OR
					tblUser.vcLastName LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.q#%" />
				OR
					tblUser.vcUsername LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.q#%" />
				OR
					tblUser.vcEmail LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.q#%" />
				)
			ORDER BY
				tblUser.vcUsername ASC
		</cfquery>

	<cfreturn qSearch />
	</cffunction>

	<cffunction name="loadByUsernameOrEmail" access="public" returntype="query" output="true">
		<cfargument name="input" type="string" required="true" />

		<cfquery name="qLoadByUsernameOrEmail">
			SELECT
				  tblUser.intUserID		/*  - int*/
				, tblUser.vcUsername		/*  - varchar(200)*/
				, tblUser.vcEmail		/*  - varchar(200)*/
				, tblUser.vcFirstName		/*  - varchar(200)*/
				, tblUser.vcMiddleName		/*  - varchar(200)*/
				, tblUser.vcLastName		/*  - varchar(200)*/
				, tblUser.vcNamePrefix		/*  - varchar(25)*/
				, tblUser.vcNameSuffix		/*  - varchar(25)*/
				, tblUser.vcPassword		/*  - varchar(512)*/
				, tblUser.btIsPasswordExpired	/*  - bit*/
				, tblUser.dtPasswordLastSetOn	/*  - datetime*/
				, tblUser.intPasswordLastSetBy	/*  - int*/
				, tblUser.vcPasswordLastSetByIP	/*  - varchar(50)*/
				, tblUser.dtLastLoggedInOn	/*  - datetime*/
				, tblUser.vcAddress1		/*  - varchar(200)*/
				, tblUser.vcAddress2		/*  - varchar(200)*/
				, tblUser.vcAddress3		/*  - varchar(200)*/
				, tblUser.vcCity		/*  - varchar(200)*/
				, tblUser.vcState		/*  - varchar(100)*/
				, tblUser.vcPostalCode		/*  - varchar(10)*/
				, tblUser.vcZip4		/*  - varchar(4)*/
				, tblUser.vcPhone1		/*  - varchar(25)*/
				, tblUser.vcPhone2		/*  - varchar(25)*/
				, tblUser.btIsActive		/*  - bit*/
				, tblUser.btIsProtected		/*  - bit*/
				, tblUser.btIsLocked		/*  - bit*/
				, tblUser.dtCreatedOn		/*  - datetime*/
				, tblUser.intCreatedBy		/*  - int*/
				, tblUser.vcCreatedByIP		/*  - varchar(50)*/
				, tblUser.dtLastModifiedOn	/*  - datetime*/
				, tblUser.intLastModifiedBy	/*  - int*/
				, tblUser.vcLastModifiedByIP	/*  - varchar(50)*/
			FROM dbo.tblUser
			WHERE
				1 = 1
			AND
				(
					tblUser.vcUsername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.input#" />
				OR
					tblUser.vcEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.input#" />
				)
		</cfquery>

	<cfreturn qLoadByUsernameOrEmail />
	</cffunction>

	<cffunction name="getUserIDByUsername" access="public" returntype="numeric" output="false">
		<cfargument name="vcUsername" type="string" required="true" />

		<cfquery name="qGetUserID">
			SELECT
				tblUser.intUserID
			FROM dbo.tblUser
			WHERE tblUser.vcUsername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcUsername#" />
		</cfquery>

		<cfif qGetUserID.recordCount>
			<cfreturn qGetuserID.intUserID />
		</cfif>

	<cfreturn 0 />
	</cffunction>

	<cffunction name="getUserIDByEmail" access="public" returntype="numeric" output="false">
		<cfargument name="vcEmail" type="string" required="true" />

		<cfquery name="qGetUserID">
			SELECT
				 tblUser.intUserID
			FROM dbo.tblUser
			WHERE tblUser.vcEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcEmail#" />
		</cfquery>

		<cfif qGetUserID.recordCount>
			<cfreturn qGetuserID.intUserID />
		</cfif>

	<cfreturn 0 />
	</cffunction>

	<cffunction name="getUserIDByUsernameOrEmail" access="public" returntype="numeric" output="false">
		<cfargument name="input" type="string" required="true" />

		<cfquery name="qGetUserID">
			SELECT
				 tblUser.intUserID
			FROM dbo.tblUser
			WHERE
				(
					tblUser.vcEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.input#" />
				OR
					tblUser.vcUsername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.input#" />
				)
		</cfquery>

		<cfif qGetUserID.recordCount>
			<cfreturn qGetuserID />
		</cfif>

	<cfreturn 0 />
	</cffunction>

	<cffunction name="getCurrentPassword" access="public" returntype="query" output="false">
		<cfargument name="intUserID" type="numeric" required="true" />

		<cfquery name="qGetCurrentPassword">
			SELECT
				  tblUser.vcPassword
				, tblUser.btIsPasswordExpired
				, tblUser.dtPasswordLastSetOn
				, tblUser.intPasswordLastSetBy
				, tblUser.vcPasswordLastSetByIP
				, tblUser.dtLastLoggedInOn
			FROM dbo.tblUser
			WHERE
				tblUser.intUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intUserID#" />
		</cfquery>

	<cfreturn qGetCurrentPassword />
	</cffunction>

	<cffunction name="getPreviousPasswords" access="public" returntype="query" output="false">
		<cfargument name="intUserID" type="numeric" required="true" />
		<cfargument name="previousPasswordCount" type="numeric" required="true" />

		<cfquery name="qGetPrevious">
			WITH data AS (
			    SELECT
			      tblUserPreviousPassword.intUserPreviousPasswordID
			    , tblUserPreviousPassword.intUserID
			    , tblUserPreviousPassword.vcPassword
			    , tblUserPreviousPassword.btIsTempPassword
			    , tblUserPreviousPassword.dtPasswordLastSetOn
			    , tblUserPreviousPassword.intPasswordLastSetBy
			    , tblUserPreviousPassword.vcPasswordLastSetByIP
			    , rank() over (PARTITION BY tblUserPreviousPassword.btIsTempPassword ORDER BY tblUserPreviousPassword.dtPasswordLastSetOn DESC) rnkByTemp
			    , rank() over (ORDER BY tblUserPreviousPassword.dtPasswordLastSetOn DESC) rnkOverall
			    FROM dbo.tblUserPreviousPassword
			    WHERE
			        tblUserPreviousPassword.intUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intUserID#" />
			)
			SELECT
				data.*
			FROM
				data
			WHERE
				rnkByTemp <= <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.previousPasswordCount#" />
			AND
				data.btIsTempPassword = 0

			UNION

			SELECT
				data.*
			FROM
				data
			WHERE
				rnkOverall = 1
		</cfquery>

	<cfreturn qGetPrevious />
	</cffunction>

	<cffunction name="logAuthenticationAttempt" access="public" returntype="void" output="false">
		<cfargument name="vcUsername" type="string" required="true" />
		<cfargument name="btWasSuccessful" type="boolean" required="true" />
		<cfargument name="ipAddress" type="string" required="true" />

		<cfquery>
			INSERT INTO dbo.tblAuthenticationAttempt
			(
				  vcUsername		/*  - varchar(200)*/
				, btWasSuccessful	/*  - bit*/
				, dtAttemptedOn		/*  - datetime*/
				, vcAttemptedIP		/*  - varchar(50)*/
			)
			VALUES
			(
				  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcUsername#"/>	/* vcUsername - varchar (200) */
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.btWasSuccessful#"/>	/* btWasSuccessful - bit */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#"/>	/* dtAttemptedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ipAddress#"/>	/* vcAttemptedIP - varchar (50) */
			);
		</cfquery>

	</cffunction>

	<cffunction name="addUserToGroup" access="public" returntype="void" output="false">
		<cfargument name="intUserID" type="numeric" required="true" />
		<cfargument name="intGroupID" type="numeric" required="true" />

		<cfquery name="qCheck">
			SELECT 1
			FROM dbo.tblUser_Group
			WHERE intUserID = <cfqueryparam  value="#arguments.intUserID#" cfsqltype="cf_sql_integer" />
				AND intGroupID = <cfqueryparam value="#arguments.intGroupID#" cfsqltype="cf_sql_integer" />
		</cfquery>

		<cfif !qCheck.recordCount>
			<cfquery>
				INSERT INTO dbo.tblUser_Group
				(
					  tblUser_Group.intUserID
					, tblUser_Group.intGroupID
				)
				VALUES
				(
					  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intUserID#" />
					, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intGroupID#" />
				)

			</cfquery>
		</cfif>

	</cffunction>

	<cffunction name="removeUserFromGroup" access="public" returntype="void" output="false">
		<cfargument name="intUserID" type="numeric" required="true" />
		<cfargument name="intGroupID" type="numeric" required="true" />

		<cfquery>
			DELETE
			FROM dbo.tblUser_Group
			WHERE tblUser_Group.intUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intUserID#" />
			AND tblUser_Group.intGroupID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intGroupID#" />
		</cfquery>

	</cffunction>

	<cffunction name="getGroupsForUser" access="public" returntype="query" output="false">
		<cfargument name="intUserID" type="numeric" required="true" />

		<cfquery name="qGetGroupsForUser">
			SELECT tblUser_Group.intGroupID
			FROM dbo.tblUser_Group
			WHERE tblUser_Group.intUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intUserID#" />
		</cfquery>

	<cfreturn qGetGroupsForUser />
	</cffunction>

	<cffunction name="getUsersForGroupAbbr" access="public" returntype="query" output="false">
		<cfargument name="vcGroupAbbr" type="string" required="true" />

		<cfquery name="qGetUsersForGroupAbbr">
			SELECT
				  tblUser.intUserID
				, tblUser.vcUsername
				, tblUser.vcFirstName
				, tblUser.vcLastName
				, tblUser.vcEmail
			FROM dbo.tblGroup
			INNER JOIN dbo.tblUser_Group
				ON tblGroup.intGroupID = tblUser_Group.intGroupID
			INNER JOIN dbo.tbluser
				ON tblUser_Group.intUserID = tblUser.intUserID
			WHERE tblGroup.vcGroupAbbr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcGroupAbbr#" />
			ORDER BY tblUser.vcUsername ASC
		</cfquery>

	<cfreturn qGetUsersForGroupAbbr />
	</cffunction>

</cfcomponent>