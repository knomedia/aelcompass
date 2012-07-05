package com.knomedia.services
{
	import flash.events.Event;

	public class NewsServiceEvent extends Event
	{
		public static const LOADED:String = "loaded";

		private var _newsItems:Array;

		public function NewsServiceEvent(type:String, newsItems:Array)
		{
			super(type,true,true);

			this._newsItems = newsItems;
		}

		public function get newsItems():Array
		{
			return _newsItems;
		}

		public override function clone():Event
		{
			return new NewsServiceEvent(type,newsItems);
		}

		public override function toString():String
		{
			return formatToString("NewsServiceEvent","newsItems");
		}
	}
}