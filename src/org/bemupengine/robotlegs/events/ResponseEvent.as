package org.bemupengine.robotlegs.events
{
	import flash.events.Event;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.dialog.Response;


	public class ResponseEvent extends Event
	{
		public static const ASK : String = "RE.ask";
		private var _responses : Vector.<Response>;

		public function ResponseEvent( type : String, responses : Vector.<Response>, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			this.responses = responses;
			super( type, bubbles, cancelable );
		}

		override public function clone() : Event
		{
			return new ResponseEvent( type, responses, bubbles, cancelable );
		}

		public function get responses() : Vector.<Response>
		{
			return _responses;
		}

		public function set responses( value : Vector.<Response> ) : void
		{
			_responses = value;
		}
	}
}