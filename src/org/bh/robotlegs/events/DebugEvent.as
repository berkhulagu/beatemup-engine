package org.bh.robotlegs.events
{
	import flash.events.Event;
	
	public class DebugEvent extends Event
	{
		public static const WRITE:String = "DE.write";
		public static const APPEND:String = "DE.append";
		public static const TOGGLE_SHOW:String = "DE.toggle"
		
		private var _text:String
		
		public function DebugEvent(type:String, tText:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_text = tText;
			super(type, bubbles, cancelable);
		}

		public function get text():String
		{
			return _text;
		}
		
		override public function clone():Event {
			return new DebugEvent(type, text, bubbles, cancelable);
		}

	}
}