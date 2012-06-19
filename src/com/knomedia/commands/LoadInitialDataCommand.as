package com.knomedia.commands
{
	import com.knomedia.cache.SessionCache;
	import com.knomedia.models.SessionCollection;
	import com.knomedia.services.RegistrationService;
	
	import org.swizframework.utils.commands.ICommand;
	
	public class LoadInitialDataCommand implements ICommand
	{
		[Inject]
		public var sessionCache:SessionCache;
		
		[Inject]
		public var sessionCollection:SessionCollection;
		
		[Inject]
		public var regService:RegistrationService;
		
		public function LoadInitialDataCommand()
		{
		}
		
		public function execute():void
		{
			trace("LoadInitialDataCommand.execute()");
			
			//Load all cached values
			sessionCollection.allSessions = sessionCache.getAllSessions();
			
			//Load possible updates from services
			regService.getAllPresentationData();
			
			
			/* Consider a tactic that pushes all news and session data to a SharedObjectBean
				You would always pull first from that local data, and then in the background update the cache (and views)
				with updates pulled back from the server. Include a 'last synced' value, and an option to manually sync data 
				from server when desired.
			
				Would create a faster view to the user, and doesn't worry about a non-connected state.
			
			*/
		}
	}
}