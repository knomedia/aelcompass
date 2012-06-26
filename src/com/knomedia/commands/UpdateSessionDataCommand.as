package com.knomedia.commands
{
	import com.knomedia.cache.SessionCache;
	import com.knomedia.events.RegistrationServiceEvent;
	import com.knomedia.models.SessionCollection;
	
	import flash.events.Event;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class UpdateSessionDataCommand implements IEventAwareCommand
	{
		[Inject]
		public var sessionCache:SessionCache;
		
		[Inject]
		public var sessionCollection:SessionCollection;
		
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
			sessionCollection.allSessions = _sessionData;
			sessionCache.setAllSessions( _sessionData );
			sessionCache.lastUpdated = new Date();
			trace("UpdateSessionDataCommand... sessionCollection updated");
		}
	}
}