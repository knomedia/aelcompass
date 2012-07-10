package com.knomedia.commands
{
	import com.knomedia.cache.NewsCache;
	import com.knomedia.cache.SessionCache;
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.AppEvent;
	import com.knomedia.models.SessionCollection;
	
	import flash.events.IEventDispatcher;
	
	import org.swizframework.utils.commands.ICommand;
	
	public class RemoveUserDataCommand implements ICommand
	{
		[Inject]
		public var userCache:UserDataCache;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var sessionCache:SessionCache;
		
		[Inject]
		public var sessionCollection:SessionCollection;
		
		[Inject]
		public var newsCache:NewsCache;
		
		public function RemoveUserDataCommand()
		{
		}
		
		public function execute():void
		{
			userCache.userData = null;
			userCache.registrationId = "";
			
			newsCache.allNewsItems = [];
			newsCache.lastNewsDate = new Date( 0 );
			
			sessionCache.lastUpdated = new Date( 0 );
			sessionCache.setAllSessions( [] );
			
			sessionCollection.allSessions = [];
			
			sessionCache.resetData();
			
			dispatcher.dispatchEvent( new AppEvent( AppEvent.INIT ) );	
		}
	}
}