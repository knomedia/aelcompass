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
		
		private const REFRESH_THRESHOLD:Number = 15000; // 15 seconds
		public function RefreshDataCommand()
		{
		}
		
		public function execute():void
		{
			
			/*
				If user data is older than a few seconds, re-pull user data then all presentationData
				If user data is "recent" just pull presentationData
			*/
			var lastUpdateDiff:Number = (  new Date().getTime() - userCache.lastUpdate.getTime() );
			if ( lastUpdateDiff > REFRESH_THRESHOLD )
			{
				trace("RefreshDataCommand: over last user data load, reloading user data");
				regSrv.authenticateUser( userCache.registrationId );
			} else {
				trace("RefreshDataCommand: UNDER threshold for user data, loading up presentation data");
				regSrv.getAllPresentationData();
			}
		}
	}
}