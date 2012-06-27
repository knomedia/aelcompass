package com.knomedia.commands
{
	import com.knomedia.events.AppEvent;
	import com.knomedia.events.RegistrationServiceEvent;
	import com.knomedia.events.SettingsEvent;
	
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
			mapCommand( AppEvent.REQUEST_AUTH, RequestAuthenticationCommand, AppEvent, false );
			mapCommand( RegistrationServiceEvent.AUTHENTICATION_COMPLETE, SaveUserDataCommand, RegistrationServiceEvent, false );
			
			mapCommand( RegistrationServiceEvent.ALL_SESSIONS_LOADED, UpdateSessionDataCommand, RegistrationServiceEvent, false );
			
			mapCommand( SettingsEvent.LOGOUT, RemoveUserDataCommand, SettingsEvent, false );
		}
	}
}