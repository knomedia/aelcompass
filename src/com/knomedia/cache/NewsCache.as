package com.knomedia.cache
{
	import flash.events.IEventDispatcher;
	
	public class NewsCache extends AbstractCache
	{
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
		}
		
		public function addRecentNewsItems( items:Array ):void
		{
			var current:Array = this.allNewsItems;
			current.splice( -1, 0, items );
			allNewsItems = current;
		}
	}
}