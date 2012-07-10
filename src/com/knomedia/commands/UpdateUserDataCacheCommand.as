package com.knomedia.commands
{
	import com.knomedia.cache.SessionCache;
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.AppEvent;
	import com.knomedia.events.RegistrationServiceEvent;
	import com.knomedia.events.SettingsEvent;
	import com.knomedia.models.SessionCollection;
	import com.knomedia.utils.UserDataUtils;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class UpdateUserDataCacheCommand implements IEventAwareCommand
	{
		[Inject]
		public var sessionCache:SessionCache;
		
		[Inject]
		public var sessionCollection:SessionCollection;
		
		[Inject]
		public var userCache:UserDataCache;
		
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		private var userData:Object;
		private var regId:String;
		private var _sessionData:Array;
		
		public function UpdateUserDataCacheCommand()
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
			
			_sessionData = UserDataUtils.updateSessionsWithUserData( sessionCollection.allSessions , userCache );
			sessionCollection.allSessions = _sessionData;
			sessionCache.setAllSessions( _sessionData );
			sessionCache.lastUpdated = new Date();
			
			dispatcher.dispatchEvent( new SettingsEvent( SettingsEvent.REFRESH ) );
			
		}
	}
}