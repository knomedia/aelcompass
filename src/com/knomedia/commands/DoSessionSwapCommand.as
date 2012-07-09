package com.knomedia.commands
{
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.SessionSwapEvent;
	import com.knomedia.models.Session;
	import com.knomedia.services.RegistrationService;
	
	import flash.events.Event;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class DoSessionSwapCommand implements IEventAwareCommand
	{
		[Inject]
		public var userCache:UserDataCache;
		
		[Inject]
		public var regService:RegistrationService;
		
		private var _addSession:Session;
		private var _removeSession:Session;
		
		
		public function DoSessionSwapCommand()
		{
		}
		
		public function set event(value:Event):void
		{
			var evt:SessionSwapEvent = SessionSwapEvent( value );
			_addSession = evt.sessionToAdd;
			_removeSession = evt.sessionToRemove;
		}
		
		public function execute():void
		{
			var userData:Object = updateUserData( userCache.userData );
			regService.updateUserData( userData , userCache.registrationId);
		}
		
		private function updateUserData( data:Object ):Object
		{
			
			// remove old session id
			for (var prop:* in data)
			{
				if ( prop == _removeSession.sessionId )
				{
					data[prop] = "off";
					break;
				}
			}
			// add new session
			data[_addSession.sessionId] = "on";
			return data;
		}
	}
}