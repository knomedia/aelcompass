package com.knomedia.views.presentationModels
{
	import com.knomedia.events.AppEvent;
	import com.knomedia.views.AuthenticationView;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
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
		private var view:ViewNavigator;
		private var _timer:Timer;
		
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
				_transition.duration = 300;
			}
			_transition.direction = ( intro )? ViewTransitionDirection.RIGHT : ViewTransitionDirection.LEFT;
			return _transition
		}
		
		private function getTimer():Timer
		{
			if (!_timer)
			{
				_timer = new Timer( 600, 1 );
			}
			return _timer;
		}
		
		[EventHandler(event="AppEvent.AUTH_NEEDED")]
		public function showLogin():void
		{

			var tm:Timer = getTimer();
			tm.addEventListener(TimerEvent.TIMER_COMPLETE, delayedLoginPush );
			tm.start();
			_pushedViewNav = getSelectedNav();
			_pushedViewNav.pushView( AuthenticationView, null, null, getTransition() );
			inAuthentication = true;
			_appNav.enabled = false;
		}
		private function delayedLoginPush( event:TimerEvent ):void
		{
			_appNav.hideTabBar( true );
			_appNav.enabled = true;
			var tm:Timer = Timer(event.target);
			tm.removeEventListener(TimerEvent.TIMER_COMPLETE, delayedLoginPush );
		}
		private function delayedLoginHide(event:TimerEvent):void
		{
			_appNav.showTabBar( true );
			var tm:Timer = Timer(event.target);
			tm.removeEventListener(TimerEvent.TIMER_COMPLETE, delayedLoginPush );
		}
		[EventHandler(event="RegistrationServiceEvent.AUTHENTICATION_COMPLETE")]
		public function hideLogin():void
		{
			var tm:Timer = getTimer();
			tm.addEventListener(TimerEvent.TIMER_COMPLETE, delayedLoginHide );
			tm.start();
			inAuthentication = false;
			if (_pushedViewNav )
			{
				_pushedViewNav.popToFirstView( getTransition( false )  );
			}
			
		}
		
		
	}
}