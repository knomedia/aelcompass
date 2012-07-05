package com.knomedia.services
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	
	public class NewsService extends EventDispatcher
	{
		private var _srv:HTTPService;
		private const GATEWAY:String = "http://localhost/aelcompass/news";
		
		public function NewsService(target:IEventDispatcher=null)
		{
			super(target);
			_srv = new HTTPService();
			_srv.url = GATEWAY;
			_srv.resultFormat = "text";
			_srv.addEventListener(ResultEvent.RESULT, onResult);
			_srv.addEventListener(FaultEvent.FAULT, onFault);
			
		}

		private function onFault(event:FaultEvent):void
		{
			trace( "What that What... Error on news service");
		}

		private function onResult(event:ResultEvent):void
		{
			trace("new is back: " + event.result );
			var newsItems:Object = JSON.parse( event.result as String );
		}
		
		public function getNewsFromDate( date:Date ):void
		{
			var params:Object = {};
			params.lastDate = date.getDate();
			
			_srv.send( params );
		}
	}
}