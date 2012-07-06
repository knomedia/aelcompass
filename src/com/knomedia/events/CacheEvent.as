package com.knomedia.events
{
	import flash.events.Event;

	public class CacheEvent extends Event
	{
		public static const NEWS_UPDATED:String = "newsUpdated";
		public static const SESSIONS_UPDATED:String = "sessionsUpdated";
		public static const USER_UPDATED:String = "userUpdated";

		public function CacheEvent(type:String)
		{
			super(type,true,true);
		}

		public override function clone():Event
		{
			return new CacheEvent(type);
		}

		public override function toString():String
		{
			return formatToString("CacheEvent");
		}
	}
}