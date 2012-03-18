package org.bemupengine.robotlegs.events
{
	import flash.events.Event;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.dialog.Conversation;


	public class SpeechEvent extends Event
	{
		public static const SPEECH : String = "SpeechEvent.Speech";
		private var _who : String;
		private var _says : String;
		private var _conversation : Conversation;
		private var _speechIndex : int;

		public function SpeechEvent( type : String, who : String, says : String, conversation : Conversation, speechIndex : int, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
			this.who = who;
			this.says = says;
			this.speechIndex = speechIndex;
			this.conversation = conversation;
		}

		public function get conversation() : Conversation
		{
			return _conversation;
		}

		public function set conversation( tConversation : Conversation ) : void
		{
			_conversation = tConversation;
		}

		public function get speechIndex() : int
		{
			return _speechIndex;
		}

		public function set speechIndex( value : int ) : void
		{
			_speechIndex = value;
		}

		override public function clone() : Event
		{
			return new SpeechEvent( type, who, says, conversation, speechIndex, bubbles, cancelable );
		}

		public function get says() : String
		{
			return _says;
		}

		public function set says( value : String ) : void
		{
			_says = value;
		}

		public function get who() : String
		{
			return _who;
		}

		public function set who( value : String ) : void
		{
			_who = value;
		}
	}
}