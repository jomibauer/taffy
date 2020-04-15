<cfcomponent name="mailService" accessors="true" extends="baseService" output="false" singleton="true">

	<cfproperty name="maintenanceConfig" inject="coldbox:setting:maintenanceConfig" />
	<cfproperty name="appName" inject="coldbox:configSettings:appName" />

	<cffunction name="sendError" returntype="void" output="false">
		<cfargument name="event" type="string" required="true" />
		<cfargument name="exception" type="any" required="true" />
		<cfargument name="environment" type="string" required="true" />

		<cfif dateCompare(now(), maintenanceConfig.endDate) LT 1>
			<cfmail
				to="#maintenanceConfig.emailTo#"
				from="#maintenanceConfig.emailFrom#"
				server="#maintenanceConfig.server#"
				port="#maintenanceConfig.port#"
				subject="#arguments.environment# - An exception has occurred in #appName#"
				type="text/html">
				<cfprocessingdirective suppressWhitespace="true">
					<h3>An Unhandled Exception Occurred</h3>
					<table>
						<tr>
							<td colspan="2">An unhandled exception has occurred. Please look at the diagnostic information below:</td>
						</tr>
						<tr>
							<td valign="top"><strong>Environment</strong></td>
							<td valign="top">#arguments.environment#-#CGI.server_name#</td>
						</tr>
						<tr>
							<td valign="top"><strong>Handler/Event</strong></td>
							<td valign="top">#arguments.event#</td>
						</tr>
						<tr>
							<td valign="top"><strong>User Agent</strong></td>
							<td valign="top">#CGI.HTTP_USER_AGENT#</td>
						</tr>
						<tr>
							<td valign="top"><strong>Type</strong></td>
							<td valign="top">#arguments.exception.getType()#</td>
						</tr>
						<tr>
							<td valign="top"><strong>Message</strong></td>
							<td valign="top">#arguments.exception.getMessage()#</td>
						</tr>
						<tr>
							<td valign="top"><strong>Detail</strong></td>
							<td valign="top">#arguments.exception.getDetail()#</td>
						</tr>
						<tr>
							<td valign="top"><strong>Extended Info</strong></td>
							<td valign="top">#arguments.exception.getExtendedInfo()#</td>
						</tr>
						<tr>
							<td valign="top"><strong>Stack Trace</strong></td>
							<td valign="top">#arguments.exception.getStackTrace()#</td>
						</tr>
						<tr>
							<td valign="top"><strong>Tag Context</strong></td>
							<td valign="top">
								<cfloop array="#arguments.exception.getTagContext()#" index="tagContext">
									<table>
										<cfloop collection="#tagContext#" item="key">
											<tr>
												<td style='vertical-align:top;border:1px solid ##ccc;'>#key#</td>
												<td style='border:1px solid ##ccc;'>#tagContext[key]#</td>
											</tr>
										</cfloop>
									</table>
								</cfloop>
							</td>
						</tr>
						<tr>
							<td valign="top"><strong>CGI</strong></td>
							<td valign="top">
								<table>
									<cfloop item="i" collection="#cgi#">
										<tr>
											<td style='vertical-align:top;border:1px solid ##ccc;'>#i#</td>
											<td style='border:1px solid ##ccc;'>#cgi[i]#</td>
										</tr>
									</cfloop>
								</table>
							</td>
						</tr>
						<tr>
							<td valign="top"><strong>Maintenance End Date</strong></td>
							<td valign="top">#maintenanceConfig.endDate#</td>
						</tr>
					</table>
				</cfprocessingdirective>
			</cfmail>
		</cfif>
	</cffunction>

</cfcomponent>