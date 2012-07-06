package com.knomedia.commands
{
	import com.knomedia.events.SessionRequestEvent;
	import com.knomedia.models.Session;
	
	import flash.events.Event;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class RemoveSessionRequestCommand implements IEventAwareCommand
	{
		private var _session:Session;
		
		public function RemoveSessionRequestCommand()
		{
		}
		
		public function set event(value:Event):void
		{
			_session = SessionRequestEvent( value ).session;
			trace("about to remove: " + _session.name );
		}
		
		public function execute():void
		{
		}
	}
}