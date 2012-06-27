package com.knomedia.commands
{
	import com.knomedia.cache.SessionCache;
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.RegistrationServiceEvent;
	import com.knomedia.events.SessionCacheEvent;
	import com.knomedia.models.Session;
	import com.knomedia.models.SessionCollection;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class UpdateSessionDataCommand implements IEventAwareCommand
	{
		[Inject]
		public var sessionCache:SessionCache;
		
		[Inject]
		public var sessionCollection:SessionCollection;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var userCache:UserDataCache;
		
		private var _sessionData:Array;
		
		public function UpdateSessionDataCommand()
		{
		}
		
		public function set event(value:Event):void
		{
			_sessionData = RegistrationServiceEvent(value).sessionData;
		}
		
		public function execute():void
		{
			// do something to determine if the data is actually different
			// no need to do all this if the data hasn't been updated
			
			_sessionData = updateSessionsWithUserData( _sessionData );
			sessionCollection.allSessions = _sessionData;
			sessionCache.setAllSessions( _sessionData );
			sessionCache.lastUpdated = new Date();
			trace("UpdateSessionDataCommand: updated session data at " + sessionCache.lastUpdated );
			dispatcher.dispatchEvent( new SessionCacheEvent( SessionCacheEvent.UPDATED ) );
			//need to apply user data to the sessions ! ie which sessions are they signed up for
		}
		
		private function updateSessionsWithUserData( sessions:Array ):Array
		{
			var ids:Array = createIdArray();
			for each( var session:Session in sessions)
			{
				var index:int = ids.indexOf( session.sessionId );
				if (index != -1)
				{
					session.userAttending = true;
					//trace("Attending: " + session.day + " " + session.start + " " + session.name );
				}
			}
			return sessions;
		}
		
		private function createIdArray():Array
		{
			var ids:Array = [];
			for( var prop:* in userCache.userData)
			{
				if (userCache.userData[ prop ] =="on" )
				{
					ids.push( prop )
				}
			}
			return ids;
		}
	}
}