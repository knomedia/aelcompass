package com.knomedia.models
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import spark.components.TabbedViewNavigator;
	import spark.components.ViewNavigator;
	
	public class NavModel extends EventDispatcher
	{
		public var navigator:TabbedViewNavigator;
		
		public function NavModel(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function hide():void
		{
			if ( navigator )
			{
				navigator.hideTabBar( false );
			}
		}
		
		public function show():void
		{
			if ( navigator ) {
				navigator.showTabBar( false );
			}
		}
	}
}