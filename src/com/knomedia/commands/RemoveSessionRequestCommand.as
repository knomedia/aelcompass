package com.knomedia.commands
{
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.SessionRequestEvent;
	import com.knomedia.models.Session;
	import com.knomedia.services.RegistrationService;
	
	import flash.events.Event;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class RemoveSessionRequestCommand implements IEventAwareCommand
	{
		private var _session:Session;
		
		[Inject]
		public var userCache:UserDataCache;
		
		[Inject]
		public var regService:RegistrationService;
		
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
			var userData:Object = updateUserData( userCache.userData );
			regService.updateUserData( userData , userCache.registrationId);
		}
		
		private function updateUserData( data:Object ):Object
		{
			if (_session)
			{
				for (var prop:* in data)
				{
					if ( prop == _session.sessionId )
					{
						//data[prop] = "off";
						delete data[prop];
						trace("removing: " + prop );
					}
				}
			}
			return data;
		}
	}
}