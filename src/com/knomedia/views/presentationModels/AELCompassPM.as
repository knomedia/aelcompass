package com.knomedia.views.presentationModels
{
	import com.knomedia.events.AppEvent;
	import com.knomedia.views.AuthenticationView;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import spark.components.TabbedViewNavigator;
	import spark.components.View;
	import spark.components.ViewNavigator;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.ViewTransitionBase;
	import spark.transitions.ViewTransitionDirection;
	
	public class AELCompassPM extends EventDispatcher
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		private var _appNav:TabbedViewNavigator;
		private var _pushedViewNav:ViewNavigator;
		
		public var inAuthentication:Boolean = false;
		
		private var _transition:SlideViewTransition;
		
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
		
		private function getTransition( intro:Boolean = true ):ViewTransitionBase
		{
			if ( !_transition )
			{
				_transition = new SlideViewTransition();
			}
			_transition.direction = ( intro )? ViewTransitionDirection.RIGHT : ViewTransitionDirection.LEFT;
			return _transition
		}
		
		[EventHandler(event="AppEvent.AUTH_NEEDED")]
		public function showLogin():void
		{
			
			_pushedViewNav = getSelectedNav();
			_pushedViewNav.pushView( AuthenticationView, null, null, getTransition() );
			inAuthentication = true;
		}
		[EventHandler(event="RegistrationServiceEvent.AUTHENTICATION_COMPLETE")]
		public function hideLogin():void
		{
			trace(" authentication was completed... closing auth window");
			inAuthentication = false;
			_pushedViewNav.popToFirstView(getTransition( false )  );
		}
		
		
	}
}