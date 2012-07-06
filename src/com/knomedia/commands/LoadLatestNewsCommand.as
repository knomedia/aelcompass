package com.knomedia.commands
{
	import com.knomedia.cache.NewsCache;
	import com.knomedia.services.NewsService;
	
	import org.swizframework.utils.commands.ICommand;
	
	public class LoadLatestNewsCommand implements ICommand
	{
		
		[Inject]
		public var newsCache:NewsCache;
		
		[Inject]
		public var newsSrv:NewsService;
		
		public function LoadLatestNewsCommand()
		{
		}
		
		public function execute():void
		{
			//newsSrv.getNewsFromDate( newsCache.lastNewsDate );
			
			newsSrv.getNewsFromDate( new Date(0) );
			
			/*trace("wiping old news items");
			newsCache.allNewsItems = [];
			newsCache.lastNewsDate = new Date( 0 );*/
		}
	}
}