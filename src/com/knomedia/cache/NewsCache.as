package com.knomedia.cache
{
	import com.knomedia.events.CacheEvent;
	
	import flash.events.IEventDispatcher;
	
	
	
	public class NewsCache extends AbstractCache
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		public function NewsCache(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function set lastNewsDate( date:Date ):void
		{
			so.setValue( "lastNewsDate", date );
		}
		public function get lastNewsDate():Date
		{
			return so.getValue( "lastNewsDate", new Date(0) );
		}
		
		public function get allNewsItems():Array
		{
			return so.getValue( "allNewsItems", [] );
		}
		public function set allNewsItems( value:Array ):void
		{
			so.setValue( "allNewsItems", value );
			notifyUpdate();
		}
		
		
		public function addRecentNewsItems( items:Array ):void
		{
			items.reverse();
			allNewsItems = items.concat( allNewsItems );
			
			notifyUpdate();
		}
		
		private function notifyUpdate():void
		{
			dispatcher.dispatchEvent( new CacheEvent(CacheEvent.NEWS_UPDATED) );
		}
	}
}