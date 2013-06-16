<cfoutput>
<plugin>
	<name>Mura Hoth</name>
	<package>Hoth</package>
	<directoryFormat>packageOnly</directoryFormat>
	<loadPriority>5</loadPriority>
	<version>0.8</version>
	<provider>Greg Moser</provider>
	<providerURL>http://www.gregmoser.com</providerURL>
	<category>Utility</category>
	<settings>
		<setting>
			<name>EmailNewExceptions</name>
			<label>Email New Exceptions</label>
			<hint></hint>
			<type>RadioGroup</type>
			<required>true</required>
			<validation></validation>
			<regex></regex>
			<message></message>
			<defaultvalue>true</defaultvalue>
			<optionlist>false^true</optionlist>
			<optionlabellist>No^Yes</optionlabellist>
		</setting>
		<setting>
			<name>EmailNewExceptionsTo</name>
			<label>Email New Exceptions To</label>
			<hint></hint>
			<type>text</type>
			<required>false</required>
			<validation></validation>
			<regex></regex>
			<message></message>
			<defaultvalue></defaultvalue>
			<optionlist></optionlist>
			<optionlabellist></optionlabellist>
		</setting>
		<setting>
			<name>EmailNewExceptionsFrom</name>
			<label>Email New Exceptions From</label>
			<hint></hint>
			<type>text</type>
			<required>false</required>
			<validation></validation>
			<regex></regex>
			<message></message>
			<defaultvalue></defaultvalue>
			<optionlist></optionlist>
			<optionlabellist></optionlabellist>
		</setting>
		<setting>
			<name>EmailNewExceptionsFile</name>
			<label>Include Exception File with New Exception Emails</label>
			<hint></hint>
			<type>RadioGroup</type>
			<required>true</required>
			<validation></validation>
			<regex></regex>
			<message></message>
			<defaultvalue>false</defaultvalue>
			<optionlist>false^true</optionlist>
			<optionlabellist>No^Yes</optionlabellist>
		</setting>
		<setting>
			<name>EmailExceptionsAsHTML</name>
			<label>Email Exceptions As HTML</label>
			<hint></hint>
			<type>RadioGroup</type>
			<required>true</required>
			<validation></validation>
			<regex></regex>
			<message></message>
			<defaultvalue>false</defaultvalue>
			<optionlist>false^true</optionlist>
			<optionlabellist>No^Yes</optionlabellist>
		</setting>
	</settings>
	<eventHandlers>
		<eventHandler event="onApplicationLoad" component="plugin.eventHandler" persist="false" />
	</eventHandlers>
	<displayobjects location="global">
		<!---<displayobject name="muraFW1" displaymethod="renderApp" component="pluginEventHandler" persist="false" />--->
	</displayobjects>
</plugin>
</cfoutput>
