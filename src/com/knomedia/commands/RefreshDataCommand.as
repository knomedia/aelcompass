package com.knomedia.commands
{
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.services.RegistrationService;
	
	import org.swizframework.utils.commands.ICommand;
	
	public class RefreshDataCommand implements ICommand
	{
		
		[Inject]
		public var regSrv:RegistrationService;
		
		[Inject]
		public var userCache:UserDataCache;
		
		
		public function RefreshDataCommand()
		{
		}
		
		public function execute():void
		{
			regSrv.getAllPresentationData();
			
			// Determine a way to pull user data again
			// after the previous async call is complete
			//regSrv.authenticateUser( userCache.registrationId );
		}
	}
}