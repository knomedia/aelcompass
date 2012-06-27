package com.knomedia.events
{
	import flash.events.Event;

	public class AppEvent extends Event
	{
		public static const INIT:String = "init";
		public static const AUTH_NEEDED:String = "authNeeded";
		public static const REQUEST_AUTH:String = "requestAuth";
		public static const OKAY_TO_LOAD:String = "okayToLoad";
		
		private var _data:Object;

		public function AppEvent(type:String, data:Object = null)
		{
			super(type,true,true);

			this._data = data;
		}

		public function get data():Object
		{
			return _data;
		}

		public override function clone():Event
		{
			return new AppEvent(type,data);
		}

		public override function toString():String
		{
			return formatToString("AppEvent","data");
		}
	}
}