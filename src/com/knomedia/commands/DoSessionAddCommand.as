package com.knomedia.commands
{
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.SessionSwapEvent;
	import com.knomedia.models.Session;
	import com.knomedia.services.RegistrationService;
	
	import flash.events.Event;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class DoSessionAddCommand implements IEventAwareCommand
	{
		private var _sessionAdd:Session;
		
		[Inject]
		public var regService:RegistrationService;
		
		[Inject]
		public var userCache:UserDataCache;
		
		public function DoSessionAddCommand()
		{
		}
		
		public function set event(value:Event):void
		{
			_sessionAdd = SessionSwapEvent( value ).sessionToAdd;
		}
		
		public function execute():void
		{
			var userData:Object = updateUserData( userCache.userData );
			regService.updateUserData( userData , userCache.registrationId);
		}
		
		private function updateUserData( data:Object ):Object
		{
			
			// add new session
			data[_sessionAdd.sessionId] = "on";
			trace("adding: " + _sessionAdd.sessionId )
			return data;
		}
	}
}