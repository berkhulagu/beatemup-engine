package org.bh.robotlegs.events
{
	import flash.events.Event;
	
	public class MenuEvent extends Event
	{
		public static const CLICKED:String = "MenuEvent.clicked"
			
		private var _itemName:String
		
		public function MenuEvent(type:String, tItemName:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_itemName = tItemName;
			
			super(type, bubbles, cancelable);
		}
		
		public function get itemName():String
		{
			return _itemName;
		}

		public function set itemName(value:String):void
		{
			_itemName = value;
		}
		
		override public function clone():Event {
			return new MenuEvent(type, itemName, bubbles, cancelable)
		}

	}
}