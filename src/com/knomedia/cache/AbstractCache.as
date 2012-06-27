package com.knomedia.cache
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.swizframework.storage.ISharedObjectBean;
	import org.swizframework.storage.SharedObjectBean;
	
	public class AbstractCache extends EventDispatcher
	{
		
		[Inject]
		public var so:ISharedObjectBean;
		
		public function AbstractCache(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		[PostConstruct]
		public function onConstruct():void
		{
			so.name = "AELCompassStorage";
			/*so.clear();
			trace("so is cleared");*/
		}
		
		
	}
}