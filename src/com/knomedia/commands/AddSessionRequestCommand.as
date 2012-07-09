package com.knomedia.commands
{
	import com.knomedia.cache.SessionCache;
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.SessionRequestEvent;
	import com.knomedia.events.SessionSwapEvent;
	import com.knomedia.models.Session;
	import com.knomedia.models.SessionCollection;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import flashx.textLayout.elements.BreakElement;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class AddSessionRequestCommand implements IEventAwareCommand
	{
		private var _session:Session;
		
		
		[Inject]
		public var sessionCollection:SessionCollection;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		public function AddSessionRequestCommand()
		{
		}
		
		public function set event(value:Event):void
		{
			_session = SessionRequestEvent( value ).session;
			trace("About to add " + _session.name );
		}
		
		public function execute():void
		{
			var existingTimeBlockSession:Session = findSession();
			var evt:SessionSwapEvent;
			if ( existingTimeBlockSession )
			{
				evt = new SessionSwapEvent( SessionSwapEvent.SWAP_SESSIONS, _session, existingTimeBlockSession );
			} else {
				evt = new SessionSwapEvent( SessionSwapEvent.SINGLE_ADD, _session );
			}
			
			dispatcher.dispatchEvent( evt );
			
		}
		
		private function findSession():Session
		{
			var existing:Session;
			var day:String = _session.day;
			var time:String = _session.start;
			for each( var sess:Session in sessionCollection.allSessions )
			{
				if ( sess.day == day && sess.start == time && sess.userAttending == true )
				{
					existing = sess;
					break;
				}
			}
			return existing;
		}
	}
}