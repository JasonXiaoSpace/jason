package org.robotlegs.demos.helloflash.controller
{
	import flash.events.Event;
	
	public class HelloFlashEvent extends Event
	{
		public static const BALL_CLICKED:String = 'BALL_CLICKED';
		
		private var _body:*;
		
		public function HelloFlashEvent(type:String, body:* = null)
		{
			super(type);
			_body = body;
		}
		
		public function get body():*
		{
			return _body;
		}
		
		override public function clone():Event
		{
			return new HelloFlashEvent(type, body);
		}
	
	}
}