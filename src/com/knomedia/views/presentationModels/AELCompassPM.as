package com.knomedia.views.presentationModels
{
	import com.knomedia.events.AppEvent;
	import com.knomedia.views.AuthenticationView;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import spark.components.TabbedViewNavigator;
	import spark.components.ViewNavigator;
	
	public class AELCompassPM extends EventDispatcher
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		private var _appNav:TabbedViewNavigator;
		private var _pushedViewNav:ViewNavigator;
		
		public function AELCompassPM(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function register( viewNavigator:TabbedViewNavigator ):void
		{
			_appNav = viewNavigator;
			dispatcher.dispatchEvent( new AppEvent( AppEvent.INIT ) );
		}
		
		private function getSelectedNav():ViewNavigator
		{
			return _appNav.selectedNavigator as ViewNavigator;
		}
		
		public function showLogin():void
		{
			_pushedViewNav = getSelectedNav();
			_pushedViewNav.pushView( AuthenticationView );
		}
		public function hideLogin():void
		{
			_pushedViewNav.popToFirstView();
		}
	}
}