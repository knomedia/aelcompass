package com.knomedia.commands
{
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.RegistrationServiceEvent;
	
	import flash.events.Event;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class SaveUserDataCommand implements IEventAwareCommand
	{
		[Inject]
		public var userCache:UserDataCache;
		
		private var userData:Object;
		public function SaveUserDataCommand()
		{
		}
		
		public function set event(value:Event):void
		{
			userData = RegistrationServiceEvent( value ).userData;
		}
		
		public function execute():void
		{
			userCache.userData = userData;
			
		}
	}
}