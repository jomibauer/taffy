<cfcomponent name="spreadSheetService" accessors="true" extends="baseService" output="false" singleton="true">

	<cfproperty name="importUploadService" inject="importUploadService"/>

	<cffunction name="uploadImportExcelFile" access="public" returntype="any" output="False">
		<cfargument name="filePath" type="any" required="true" />
		<cfargument name="importValidator" type="any" required="true" />

		<cfset output = {} />
		<cfset hasError = false>
		<cfspreadsheet
			action="read"
			src="#arguments.filePath#"
			query="importRow"
			headerrow="1"
			excludeHeaderRow="true" />

		<cfset importRowData = "#serializeJSON(importRow)#">
		<cfset importRowData = "#deserializeJSON(importRowData)#">
		<cfset importRowHeader = "#importRowData.columns#">
		<cfset importRowData = "#importRowData.data#">

		<cfset rowDataWithHeader = [] />
		<cfloop index="currentRowDataIndex" item="currentRowData" array="#importRowData#">
			<cfset rowDataStruct = {} />
			<cfloop index="currentRowIndex" item="currentRowItem" array="#currentRowData#">
				<cfset rowData = { '#importRowHeader[currentRowIndex]#' : currentRowItem }>
				<cfset structAppend(rowDataStruct, rowData)>
			</cfloop>
			<cfset arrayAppend(rowDataWithHeader, rowDataStruct)>
		</cfloop>

		<cfloop index="importRowHeaderIndex" item="importRowHeaderItem" array="#rowDataWithHeader#">
			<cfset systemNote = ''>
			<cfloop key="importRowHeaderItemKey" collection="#importRowHeaderItem#">
				<cfif structKeyExists(importValidator, importRowHeaderItemKey)>
					<!--- validateRequired(key, data) --->
					<cfif findNoCase("required", importValidator[importRowHeaderItemKey])>
						<cfset systemNote = systemNote & importUploadService.validateRequired(importRowHeaderItemKey, importRowHeaderItem[importRowHeaderItemKey] )>
					</cfif>
					<!--- validateLength(key, data, length) --->
					<cfif findNoCase("length", importValidator[importRowHeaderItemKey])>
						<cfset systemNote =  systemNote & importUploadService.validateLength(importRowHeaderItemKey, importRowHeaderItem[importRowHeaderItemKey], 150)>
					</cfif>
					<!--- validateEmail(key, data) --->
					<cfif findNoCase("email", importValidator[importRowHeaderItemKey])>
						<cfset systemNote = systemNote & importUploadService.validateEmail(importRowHeaderItemKey, importRowHeaderItem[importRowHeaderItemKey])>
					</cfif>
					<!--- validatePhone(key, data) --->
					<cfif findNoCase("phone", importValidator[importRowHeaderItemKey])>
						<cfset systemNote = systemNote & importUploadService.validatePhone(importRowHeaderItemKey, importRowHeaderItem[importRowHeaderItemKey])>
					</cfif>
				</cfif>
			</cfloop>
			<cfset importRowHeaderItem['System Note'] = systemNote>
			<cfif len(importRowHeaderItem['System Note'])>
				<cfset hasError = true>
			</cfif>
		</cfloop>
		<cfset structAppend(output, {"data" : rowDataWithHeader})>
		<cfset structAppend(output, {"hasError" : hasError})>

		<cfreturn output />
	</cffunction>

   <cffunction name="downloadImportUploadExcelFile" access="public" returntype="any" output="False">
		<cfargument name="importUpload" type="array" required="true" />

		<cfset excelFileName = '#dateFormat(now(), 'yyyymmdd')#_#createUUID()#'>
		<cfset excelFilePath = replace(CGI.cf_template_path, "index.cfm", "") & '/temp/importUpload/#excelFileName#.xlsx'>

		<cfif !directoryExists(replace(CGI.cf_template_path, "index.cfm", "") & '/temp/importUpload/') >
			<cfset directoryCreate(replace(CGI.cf_template_path, "index.cfm", "") & '/temp/importUpload/')>
		</cfif>

		<cfset queryHeader = "">
		<cfset queryHeaderType = "">
		<cfloop index="rowDataIndex" item="rowData" array="#importUpload#">
			<cfloop key="rowDataKey" collection="#rowData#">
				<cfset queryHeader = queryHeader & "#trim(rowDataKey)#,">
				<cfset queryHeaderType = queryHeaderType & "varchar,">
			</cfloop>
			<cfbreak>
		</cfloop>

		<cfset importUploadQuery = queryNew(queryHeader, queryHeaderType)>
		<Cfset arr = []>
		<cfloop index="rowDataIndex" item="rowData" array="#importUpload#">
			<cfset queryAddRow(importUploadQuery)>
			<cfloop key="rowDataKey" collection="#rowData#">
				<cfset querySetCell(importUploadQuery, "#trim(rowDataKey)#", "#rowData[rowDataKey]#")>
				<cfif trim(rowDataKey) == 'System Note'>
				</cfif>
			</cfloop>
		</cfloop>
		<cfset importUploadQueryObj = spreadsheetNew("Import Upload Records", true)>
		<cfset spreadsheetAddRow(importUploadQueryObj, queryHeader)>
		<cfset spreadsheetAddRows(importUploadQueryObj, importUploadQuery)>
		<cfset spreadsheetWrite(importUploadQueryObj, excelFilePath, true)>
		<cfset spreadsheetwrite('#importUploadQueryObj#', '#excelFilePath#', true)>

		<cfreturn excelFileName />
	</cffunction>

</cfcomponent>