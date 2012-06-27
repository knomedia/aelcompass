package com.knomedia.commands
{
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.AppEvent;
	import com.knomedia.events.RegistrationServiceEvent;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class SaveUserDataCommand implements IEventAwareCommand
	{
		[Inject]
		public var userCache:UserDataCache;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		private var userData:Object;
		private var regId:String;
		public function SaveUserDataCommand()
		{
		}
		
		public function set event(value:Event):void
		{
			userData = RegistrationServiceEvent( value ).userData;
			regId = RegistrationServiceEvent( value ).registrationId;
		}
		
		public function execute():void
		{
			userCache.userData = userData;
			userCache.registrationId = regId;
			userCache.lastUpdate = new Date();
			trace("SaveUserDataCommand: updated user data at: " + userCache.lastUpdate );
			dispatcher.dispatchEvent( new AppEvent( AppEvent.OKAY_TO_LOAD) );
		}
	}
}