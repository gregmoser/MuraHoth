component extends="mura.plugin.pluginGenericEventHandler" {

	public void function onApplicationLoad() {
		if(structKeyExists(application, "HothTracker")) {
			structDelete(application, "HothTracker");
		}
		variables.pluginConfig.addEventHandler(this);
	}
	
	public void function onGlobalError() {
		try {
			if(!structKeyExists(application, "HothTracker")) {
				var hothConfig = new Hoth.config.HothConfig();
				
				// Inject Settings From The Plugin Config
				hothConfig.setEmailNewExceptions( variables.pluginConfig.getSetting("EmailNewExceptions") );
				hothConfig.setEmailNewExceptionsTo( variables.pluginConfig.getSetting("EmailNewExceptionsTo") );
				hothConfig.setEmailNewExceptionsFrom( variables.pluginConfig.getSetting("EmailNewExceptionsFrom") );
				hothConfig.setEmailNewExceptionsFile( variables.pluginConfig.getSetting("EmailNewExceptionsFile") );
				hothConfig.setEmailExceptionsAsHTML( variables.pluginConfig.getSetting("EmailExceptionsAsHTML") );
				
				// Set Hoth Tracker in the application scope for future use
				application.HothTracker = new Hoth.HothTracker( hothConfig );
			}
			
			// Track Exception w/Hoth
			application.HothTracker.track(arguments.$.event('exception'));
		} catch(any e){}
	}

	public function onAdminModuleNav() {
		var newLinks = '';
		if (listFind(session.mura.memberships,'S2')){
			newLinks = '<li><a href="' & application.configBean.getContext() & '/plugins/Hoth">Exception Tracking</a></li>';
			}
		return newLinks;
	}
	
}