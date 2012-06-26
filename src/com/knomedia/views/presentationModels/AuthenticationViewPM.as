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
	
	import spark.components.Label;
	import spark.components.TextInput;
	
	public class AuthenticationViewPM extends EventDispatcher
	{
		private const REG_URL:String = "https://www.ce1.com/cgi-bin/form-proc4v2.cgi?client_id=ADOBE&event_id=Adobe%20Education%20Leader%20Institute%202012";
			
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		private var _errorLabel:Label;
		private var _registrationTF:TextInput;
			
		public function AuthenticationViewPM(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		public function openRegPage():void
		{
			navigateToURL( new URLRequest( REG_URL ) );		
		}
		
		public function onActivate( errorLabel:Label, registrationTF:TextInput ):void
		{
			_errorLabel = errorLabel;
			_registrationTF = registrationTF;
			NativeApplication.nativeApplication.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public function onDeactivate():void
		{
			_errorLabel.text = "";
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
			_errorLabel.text = "";
			_registrationTF.text = "";
			dispatcher.dispatchEvent( new AppEvent( AppEvent.REQUEST_AUTH, registrationId ) );
		}
		
		[EventHandler(event="RegistrationServiceEvent.AUTHENTICATION_FAILED")]
		public function showFailedAttempt():void
		{
			_errorLabel.text = "Doooh... Registration ID not found";
			
		}
	}
}