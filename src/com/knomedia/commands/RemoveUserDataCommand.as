package com.knomedia.commands
{
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.AppEvent;
	
	import flash.events.IEventDispatcher;
	
	import org.swizframework.utils.commands.ICommand;
	
	public class RemoveUserDataCommand implements ICommand
	{
		[Inject]
		public var userCache:UserDataCache;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		public function RemoveUserDataCommand()
		{
		}
		
		public function execute():void
		{
			userCache.userData = null;
			userCache.registrationId = "";
			
			dispatcher.dispatchEvent( new AppEvent( AppEvent.INIT ) );	
		}
	}
}