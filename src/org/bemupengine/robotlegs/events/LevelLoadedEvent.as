package org.bemupengine.robotlegs.events
{
	import flash.events.Event;

	public class LevelLoadedEvent extends Event
	{
		public static const LOADED : String = "LLE.loaded";
		private var _levelId : int;

		public function LevelLoadedEvent( type : String, tLevelId : int, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			_levelId = tLevelId;

			super( type, bubbles, cancelable );
		}

		public function get levelId() : int
		{
			return _levelId;
		}

		override public function clone() : Event
		{
			return new LevelLoadedEvent( type, levelId, bubbles, cancelable );
		}
	}
}