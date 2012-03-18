package org.bemupengine.robotlegs.events
{
	import flash.events.Event;

	public class ClearSubtitleEvent extends Event
	{
		public static const CLEAR : String = "CSE.clear";

		public function ClearSubtitleEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
	}
}