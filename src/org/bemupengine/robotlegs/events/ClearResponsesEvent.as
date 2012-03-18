package org.bemupengine.robotlegs.events
{
	import flash.events.Event;

	public class ClearResponsesEvent extends Event
	{
		public static const CLEAR : String = "CRE.clear";

		public function ClearResponsesEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
	}
}