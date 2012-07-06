package com.knomedia.commands
{
	import com.knomedia.cache.NewsCache;
	import com.knomedia.services.NewsServiceEvent;
	
	import flash.events.Event;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class UpdateNewsCommand implements IEventAwareCommand
	{
		private var newsItems:Array;
		
		[Inject]
		public var newsCache:NewsCache;
		
		public function UpdateNewsCommand()
		{
		}
		
		public function set event(value:Event):void
		{
			newsItems = NewsServiceEvent( value ).newsItems;
		}
		
		public function execute():void
		{
			if ( newsItems.length > 0 )
			{
				//newsCache.addRecentNewsItems( newsItems );
				newsCache.allNewsItems = newsItems;
				newsCache.lastNewsDate = new Date(); 
			} else {
				trace("UpdateNewsCommand.execute: no news updates to push");
			}
		}
	}
}