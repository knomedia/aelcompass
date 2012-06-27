package com.knomedia.events
{
	import flash.events.Event;

	public class SettingsEvent extends Event
	{
		public static const LOGOUT:String = "logout";
		public static const REFRESH:String = "refresh";

		public function SettingsEvent(type:String)
		{
			super(type,true,true);
		}

		public override function clone():Event
		{
			return new SettingsEvent(type);
		}

		public override function toString():String
		{
			return formatToString("SettingsEvent");
		}
	}
}