package org.bemupengine.robotlegs.events
{
	import flash.events.Event;

	public class ConversationEndedEvent extends Event
	{
		public function ConversationEndedEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
	}
}