<cfsavecontent variable="body">
	<style>
		
		div#list {
			float: left;
			width: 120px;
			font-size: 14px;
		}
		div#list ul {
			list-style:none;
		}
		div#detail {
			margin-left: 120px;
		}
		div#detail dl {
			font-family: monospace;
		}
		div#detail dl dt {
			font-weight: bold;
			margin: 5px 0 0px 5px;
			font-size: 12px;
			text-transform: uppercase;
			font-family: Arial, Helvetica, sans-serif;
		}
		div#detail dl dd {
			margin: 0;
			padding: 5px 10px 10px 10px;
			background-color: #fff;
		}
		div#detail dl dd div.mainline {
			padding: 2px 5px;
			border-bottom: 1px solid #ccc;
			font-weight: 700;
		}
		div#detail dl dd div.subline {
			font-size: 11px;
			padding: 2px 5px;
			color: #45454c;
		}
		div.linegroup {
			border-bottom: 3px solid #333;
			padding: 5px;
			margin-bottom: 5px;
		}
		div.linegroup:nth-child(odd) {
			
		}
	</style>
	<h2>Hoth: ColdFusion Exception Tracking</h2>
	<p>Visit the main site at <a href="http://aarongreenlee.com/hoth">http://aarongreenlee.com/hoth</a></p>
	<div id="hoth_container">
		<div id="list">
			<h3>Exceptions</h3>
			<div id="listing"><ul></ul></div>
		</div>
		<div id="detail">
			<h3>Details</h3>
			<div id="details">Click an exception from the list on the left.</div>
		</div>
	</div>
	<script type="text/javascript">
		var HOTH_REPORT_URI = '#application.configBean.getContext()#/plugins/Hoth/HothReportUI.cfc';
		
		jQuery().ready(function() {
			var Hoth = {
				Exceptions : {}
			};
			jQuery.ajax({
				url: HOTH_REPORT_URI + '?method=report&exception=all',
				cache: false,
				dataType: 'json',
				success: function(response){
					populatePage(response);
				}
			});
			
			var populatePage = function (ServerExceptions) {
				Hoth.Exceptions = ServerExceptions;
				// Prepare
				Hoth.ExceptionsByVolume = [];
				// Parse our exceptions sent by the server
				for (var e in Hoth.Exceptions)
				{
					var ex = Hoth.Exceptions[e];
					// Seperate JavaScript information from the data provided by
					// the server
					ex.js = {};
					ex.js.short = e.substring(0,8); // .toUpperCase()
					Hoth.ExceptionsByVolume.push(ex);
				}
				// Sort all of our exceptions by last date observed
				Hoth.ExceptionsByVolume.sort(compare);
	
				// Print the HTML links
				var exLinksHTML = '';
				for (var i in Hoth.ExceptionsByVolume)
				{
					if(!isNaN(i)){
						var ex = Hoth.ExceptionsByVolume[i];
						convertKeysToLowercase(ex);
						exLinksHTML += '<li><a href="#' + ex.filename + '" data-id="' + ex.filename + '">' +
						ex.js.short + '</a> (' + ex.incidentcount + ')</li>';
						jQuery('#listing ul').html(exLinksHTML);	
					}
				}
				
			}
	
			// -----------------------------------------------------------------
			jQuery('#listing a').live('click',function(){
				var id = jQuery(this).attr('data-id').toLowerCase();
				formatException(id);
			});	
			
			function formatException(id) {			
				jQuery.ajax(
					{
						 url: HOTH_REPORT_URI + '?method=report&exception='+ id
						,async : false
						,cache: false
						,dataType: "json"
						,success: function (ex)
						{
							var bar = '<div id="exceptionMenu">\
							<a href="' + HOTH_REPORT_URI + '?method=report&exception=' + id + '">View Raw JSON</a> | \
							<a href="#" class="deleteLink" rel="' + id + '">Delete Reports</a></div>';
							
							convertKeysToLowercase(ex);
							
							var detail = '<dl>'
							+ '<dt>URL</dt><dd>' + ex.url + '</dd>'
							+ '<dt>User Agent</dt><dd>' + ex.client + '</dd>'
							+ '<dt>Message</dt><dd>' + ex.message + '</dd>'
							+ '<dt>Detail</dt><dd>' + ex.detail + '</dd>'
							+ '<dt>Context</dt><dd>' + iterateExceptionContext(ex.context) + '</dd>'
							+ '<dt>Stack</dt><dd>' + ex.stack + '</dd>';
							
							jQuery('#details').html(bar + detail);
							
							
							jQuery('.deleteLink').click(function(e){
								e.preventDefault();
								
								jQuery.ajax({
									url: HOTH_REPORT_URI + '?method=delete&exception=' + jQuery(this).attr('rel'),
									cache: false,
									dataType: 'json',
									success: function(response){
										window.location = '/plugins/Hoth';
									}
								});
								
							});
						}
					}
				);		
			}
			// Print exceptions menu
			function iterateExceptionContext(context) {
				var output = [];
				for (var i in context) {
					var c = context[i];			
					convertKeysToLowercase(c);
					var mainline = c.template + '[' + c.line + ']';
					var subline = c.type + '(' + c.raw_trace + ')';
					output.push('<div class="linegroup"><div class="mainline">' + mainline + '</div><div class="subline">' + subline + '</div></div>');
				}			
				return output.join(""); 
			}
			// Parse the url hash for links
			// converting foobar.com/Hoth/#{uuid}.log into {uuid}.
			function parseExceptionString(s) {
				var r = s.replace('#','');
				return r.replace('.log','');
			}
			// Accept an JSON object and remap keys to lower case.
			function convertKeysToLowercase(o) {
				for (k in o)
				{
					if (o[k] !== 'object') {
						o[k.toLowerCase()] = o[k];
					}
				}
			}
			
			// Comarator to help sort exceptions by quantity.
			function compare(a,b) {
				convertKeysToLowercase(a); convertKeysToLowercase(b);
				if (a.incidentcount < b.incidentcount)
				{ return 1; }
	
				if (a.incidentcount > b.incidentcount)
				{ return -1; }
	
				return 0;
			}
		});
	</script>
</cfsavecontent>
<cfoutput>
#application.pluginManager.renderAdminTemplate(body=body,pageTitle="Mura Hoth")#
</cfoutput>