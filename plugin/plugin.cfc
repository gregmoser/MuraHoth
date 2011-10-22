<!---

This file is part of muraFW1
(c) Stephen J. Withington, Jr. | www.stephenwithington.com

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

		Document:	plugin/plugin.cfc
		Author:		Steve Withington | www.stephenwithington.com
		Modified:	2011.02.04

--->
<cfcomponent output="false" extends="mura.plugin.plugincfc">

	<cfset variables.config = '' />

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="config"  type="any" default="" />
		
		<cfset variables.config = arguments.config />
	</cffunction>
	
	<cffunction name="install" access="public" returntype="void" output="false">
		<cfset application.appInitialized = false />
		<cfif structKeyExists(application, "HothTracker")>
			<cfset structDelete(application, "HothTracker") />
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfset application.appInitialized = false />
		<cfif structKeyExists(application, "HothTracker")>
			<cfset structDelete(application, "HothTracker") />
		</cfif>
	</cffunction>
	
	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfset application.appInitialized = false />
		<cfif structKeyExists(application, "HothTracker")>
			<cfset structDelete(application, "HothTracker") />
		</cfif>
	</cffunction>

</cfcomponent>