package com.knomedia.commands
{
	import com.knomedia.events.AppEvent;
	import com.knomedia.events.RegistrationServiceEvent;
	
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
			
			mapCommand( AppEvent.INIT, VerifyUserDataCommand, AppEvent, true );
			mapCommand( RegistrationServiceEvent.ALL_SESSIONS_LOADED, UpdateSessionDataCommand, RegistrationServiceEvent, false );
		}
	}
}