package com.knomedia.views.presentationModels
{
	
	import com.knomedia.cache.SessionCache;
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.events.RegistrationServiceEvent;
	import com.knomedia.events.SettingsEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import spark.components.BusyIndicator;
	import spark.components.Label;
	
	public class SettingsViewPM extends EventDispatcher
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var userCache:UserDataCache;
		
		[Inject (bind="true")]
		public var sessionCache:SessionCache;
		
		
		private var _userTF:Label;
		private var _syncTF:Label;
		private var registered:Boolean = false;
		private var injected:Boolean = false;
		private var _bi:BusyIndicator;
		
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
				var fmtDate:String = date.toString();
				var array:Array = fmtDate.split(" ");
				array = array.slice(0, array.length - 2);
				fmtDate = array.join(" ");
				return fmtDate;
			}else {
				return "Never";
			}
			
		}
		
		private function writeLabels():void
		{
			_syncTF.text = "Last Sync: " + formatSyncDate( sessionCache.lastUpdated );
			_userTF.text = "Logged in as: " + userCache.userData.first_name + " " +userCache.userData.last_name;
		}
		
		public function register( syncTF:Label, userTF:Label, bi:BusyIndicator ):void
		{
			_syncTF = syncTF;
			_userTF = userTF;
			_bi = bi;
			registered = true;
			if (injected)
			{
				writeLabels();
			}
		}
		[EventHandler(event="SessionCacheEvent.UPDATED")]
		public function onSessionDataUpdate():void
		{
			if ( registered && injected )
			{
				writeLabels();
			}
			if (_bi)
			{
				_bi.visible = false;
			}
		}
		
		public function refreshData():void
		{
			_bi.visible = true;
			dispatcher.dispatchEvent( new SettingsEvent( SettingsEvent.REFRESH ) );
		}
		
		public function logOut():void
		{
			dispatcher.dispatchEvent( new SettingsEvent( SettingsEvent.LOGOUT ) );			
		}
		
	}
}