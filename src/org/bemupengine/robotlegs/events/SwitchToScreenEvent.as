package org.bemupengine.robotlegs.events
{
	import flash.events.Event;

	public class SwitchToScreenEvent extends Event
	{
		/** screen id to switch, 
		 * @see class ScreenConsts 
		 * */
		private var _screenId : int;
		public static const SWITCH : String = "stse.switch";

		public function SwitchToScreenEvent( type : String, tScreenId : int, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			screenId = tScreenId;

			super( type, bubbles, cancelable );
		}

		public function get screenId() : int
		{
			return _screenId;
		}

		public function set screenId( value : int ) : void
		{
			_screenId = value;
		}

		override public function clone() : Event
		{
			return new SwitchToScreenEvent( type, screenId, bubbles, cancelable );
		}
	}
}