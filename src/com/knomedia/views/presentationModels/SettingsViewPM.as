package com.knomedia.views.presentationModels
{
	import com.knomedia.cache.SessionCache;
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.RegistrationServiceEvent;
	import com.knomedia.events.SettingsEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import spark.components.Label;
	
	public class SettingsViewPM extends EventDispatcher
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var userCache:UserDataCache;
		
		[Inject]
		public var sessionCache:SessionCache;
		
		
		private var _userTF:Label;
		private var _syncTF:Label;
		private var registered:Boolean = false;
		private var injected:Boolean = false;
		
		public function SettingsViewPM(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		[PostConstruct]
		public function onPostConstruct():void
		{
			injected = true;
			if (registered)
			{
				writeLabels();
			}
		}
		private function formatSyncDate( date:Date ):String
		{
			if (date)
			{
				var fmtDate:String = "";
				var sync:Number = date.getTime();
				var now:Number = new Date().getTime();
				
				return (now - sync) + "";
			}else {
				return "Never";
			}
			
		}
		
		private function writeLabels():void
		{
			_syncTF.text = "Last Sync: " + formatSyncDate( sessionCache.lastUpdated );
			_userTF.text = "Logged in as: " + userCache.userData.first_name + " " +userCache.userData.last_name;
		}
		
		public function register( syncTF:Label, userTF:Label ):void
		{
			_syncTF = syncTF;
			_userTF = userTF;
			registered = true;
			if (injected)
			{
				writeLabels();
			}
		}
		
		public function logOut():void
		{
			dispatcher.dispatchEvent( new SettingsEvent( SettingsEvent.LOGOUT ) );			
		}
		
	}
}