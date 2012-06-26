package com.knomedia.commands
{
	import com.knomedia.cache.UserDataCache;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class VerifyUserDataCommand implements IEventAwareCommand
	{
		[Inject]
		public var userData:UserDataCache;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		public function VerifyUserDataCommand()
		{
		}
		
		public function set event(value:Event):void
		{
		}
		
		public function execute():void
		{
			if ( userData.registrationId == "" || userData.userData == null )
			{
				// show auth view and get user id	
			} else {
				// All good. Show cached data, and load from server in BG
				
			}
		}
	}
}