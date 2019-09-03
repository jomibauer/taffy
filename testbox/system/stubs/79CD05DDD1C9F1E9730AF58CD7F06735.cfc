<cfcomponent output="false" hint="A MockBox awesome Component" implements="tests.resources.NestedInterface">
<cffunction name="testThisToo">
<cfargument required="true" name="greeting">
<cfargument required="false" name="name">
</cffunction>
<cffunction name="testThis">
<cfargument required="true" name="name">
<cfargument required="false" name="age">
</cffunction>
</cfcomponent>