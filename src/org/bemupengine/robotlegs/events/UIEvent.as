package org.bemupengine.robotlegs.events
{
	import flash.events.Event;

	public class UIEvent extends Event
	{
		public static const SET_SCORE : String = "UIEvent.setscore";
		public static const SET_HEALTH : String = "UIEvent.sethealth";
		public static const SET_DODGE : String = "UIEvent.setdodge";
		public static const PLAYER_DIED : String = "UIEvent.playerDied";
		public static const RETRY_CLICKED : String = "UIEvent.retry";
		private var _param : Object;

		public function UIEvent( type : String, tParam : Object, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			_param = tParam;
			super( type, bubbles, cancelable );
		}

		public function get param() : Object
		{
			return _param;
		}

		override public function clone() : Event
		{
			return new UIEvent( type, _param, bubbles, cancelable );
		}
	}
}