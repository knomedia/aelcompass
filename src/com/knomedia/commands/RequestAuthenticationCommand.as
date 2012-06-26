package com.knomedia.commands
{
	import com.knomedia.events.AppEvent;
	import com.knomedia.services.RegistrationService;
	
	import flash.events.Event;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class RequestAuthenticationCommand implements IEventAwareCommand
	{
		[Inject]
		public var regService:RegistrationService;
		
		private var _regId:String;
		
		public function RequestAuthenticationCommand()
		{
		}
		
		public function set event(value:Event):void
		{
			_regId = AppEvent( value ).data as String;
		}
		
		public function execute():void
		{
			regService.authenticateUser( _regId );
		}
	}
}