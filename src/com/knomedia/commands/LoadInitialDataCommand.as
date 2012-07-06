package com.knomedia.commands
{
	import com.knomedia.cache.SessionCache;
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.SettingsEvent;
	import com.knomedia.models.SessionCollection;
	import com.knomedia.services.RegistrationService;
	
	import flash.events.IEventDispatcher;
	
	import org.swizframework.utils.commands.ICommand;
	
	public class LoadInitialDataCommand implements ICommand
	{
		[Inject]
		public var sessionCache:SessionCache;
		
		[Inject]
		public var sessionCollection:SessionCollection;
		
		[Inject]
		public var regService:RegistrationService;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		
		
		public function LoadInitialDataCommand()
		{
		}
		
		public function execute():void
		{
			
			//Load all cached values
			sessionCollection.allSessions = sessionCache.getAllSessions();
			dispatcher.dispatchEvent( new SettingsEvent( SettingsEvent.REFRESH ) );			
			

		}
	}
}