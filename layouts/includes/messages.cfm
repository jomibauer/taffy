<cfoutput>
	<cfset v = variables />

	<cfif session.messenger.hasAlerts()>
		<cfset session.messenger.sort() />
		<cfloop array="#session.messenger.getAlerts()#" index="v.alert">
			<div class="row noBorder" id="alertsContainer">
				<div class="col-md-offset-1 col-md-10">
					<cfswitch expression="#v.alert.messageType#">
						<cfcase value="SUCCESS">
							<div class="alert alert-success">
								#v.alert.message#
								<cfif len(trim(v.alert.messageDetail))>
									<br />
									#v.alert.messageDetail#
								</cfif>
							</div>
						</cfcase>
						<cfcase value="INFO">
							<div class="alert alert-info">
								#v.alert.message#
								<cfif len(trim(v.alert.messageDetail))>
									<br />
									#v.alert.messageDetail#
								</cfif>
							</div>
						</cfcase>
						<cfcase value="ERROR">
							<div class="alert alert-danger">
								<strong>Error!</strong> #v.alert.message#
								<cfif len(trim(v.alert.messageDetail))>
									<br />
									#v.alert.messageDetail#
								</cfif>
							</div>
						</cfcase>
						<cfcase value="WARNING">
							<div class="alert alert-warning">
								<strong>Warning!</strong> #v.alert.message#
								<cfif len(trim(v.alert.messageDetail))>
									<br />
									#v.alert.messageDetail#
								</cfif>
							</div>
						</cfcase>
					</cfswitch>
				</div>
			</div>
		</cfloop>
	</cfif>
</cfoutput>