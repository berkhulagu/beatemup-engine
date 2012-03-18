package org.bh.robotlegs.events
{
	import flash.events.Event;
	
	public class DebugCharacterEvent extends Event
	{
		public static const TOGGLE_CHARACTER_DEBUG:String = "toggleCharacterDebug"
		
		private var _characterId:String
		public function DebugCharacterEvent(type:String, tCharacterId:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_characterId = tCharacterId
			super(type, bubbles, cancelable);
		}

		public function get characterId():String
		{
			return _characterId;
		}

		public function set characterId(value:String):void
		{
			_characterId = value;
		}
		
		override public function clone():Event {
			return new DebugCharacterEvent(type, characterId, bubbles, cancelable)
		}

	}
}