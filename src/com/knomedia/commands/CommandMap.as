package com.knomedia.commands
{
	import com.knomedia.events.AppEvent;
	import com.knomedia.events.CacheEvent;
	import com.knomedia.events.RegistrationServiceEvent;
	import com.knomedia.events.SessionRequestEvent;
	import com.knomedia.events.SessionSwapEvent;
	import com.knomedia.events.SettingsEvent;
	import com.knomedia.services.NewsService;
	import com.knomedia.services.NewsServiceEvent;
	
	import mx.events.Request;
	
	import org.swizframework.utils.commands.CommandMap;
	
	public class CommandMap extends org.swizframework.utils.commands.CommandMap
	{
		public function CommandMap()
		{
			super();
		}
		
		override protected function mapCommands():void
		{
			super.mapCommands();
			
			mapCommand( AppEvent.INIT, VerifyUserDataCommand, AppEvent, false );
			mapCommand( AppEvent.OKAY_TO_LOAD, LoadInitialDataCommand, AppEvent, false );
			mapCommand( AppEvent.REQUEST_AUTH, RequestAuthenticationCommand, AppEvent, false );
			mapCommand( RegistrationServiceEvent.AUTHENTICATION_COMPLETE, SaveUserDataCommand, RegistrationServiceEvent, false );
			mapCommand( RegistrationServiceEvent.ALL_SESSIONS_LOADED, UpdateSessionDataCommand, RegistrationServiceEvent, false );
			mapCommand( RegistrationServiceEvent.ALL_SESSIONS_LOADED, LoadLatestNewsCommand, RegistrationServiceEvent, false );
			mapCommand( RegistrationServiceEvent.SERVICE_ERROR, NotifyServiceErrorCommand, RegistrationServiceEvent, false );
			
			mapCommand( SettingsEvent.LOGOUT, RemoveUserDataCommand, SettingsEvent, false );
			mapCommand( SettingsEvent.REFRESH, RefreshDataCommand, SettingsEvent, false );
			
			mapCommand( NewsServiceEvent.LOADED, UpdateNewsCommand, NewsServiceEvent, false );
			mapCommand( SessionRequestEvent.ADD, AddSessionRequestCommand, SessionRequestEvent, false );
			mapCommand( SessionRequestEvent.REMOVE, RemoveSessionRequestCommand, SessionRequestEvent, false );
			
			mapCommand( SessionSwapEvent.SWAP_SESSIONS, ConfirmSessionSwapCommand, SessionSwapEvent, false );
			
			
		}
	}
}