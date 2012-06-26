package com.knomedia.views.presentationModels
{
	import com.knomedia.events.AppEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Keyboard;
	
	public class AuthenticationViewPM extends EventDispatcher
	{
		private const REG_URL:String = "https://www.ce1.com/cgi-bin/form-proc4v2.cgi?client_id=ADOBE&event_id=Adobe%20Education%20Leader%20Institute%202012";
			
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
			
		public function AuthenticationViewPM(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		public function openRegPage():void
		{
			navigateToURL( new URLRequest( REG_URL ) );		
		}
		
		public function onActivate():void
		{
			NativeApplication.nativeApplication.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public function onDeactivate():void
		{
			NativeApplication.nativeApplication.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public function onKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.BACK)
			{
				event.preventDefault();
			}
		}
		
		public function onSubmit( registrationId:String ):void
		{
			dispatcher.dispatchEvent( new AppEvent( AppEvent.REQUEST_AUTH, registrationId ) );
		}
	}
}