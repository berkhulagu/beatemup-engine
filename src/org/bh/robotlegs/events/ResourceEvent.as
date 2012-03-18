package org.bh.robotlegs.events
{
	import flash.events.Event;
	
	public class ResourceEvent extends Event
	{
		public static const LOADED:String = "ResourceEvent.Loaded"
			
		private var _batchName:String
		
		public function get batchName():String {
			return _batchName
		}
		
		public function ResourceEvent(type:String, tBatchName:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_batchName = tBatchName
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ResourceEvent(type, _batchName, bubbles, cancelable)
		}

	}
}