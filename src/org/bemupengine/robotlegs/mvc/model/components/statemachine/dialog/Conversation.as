package org.bemupengine.robotlegs.mvc.model.components.statemachine.dialog
{
	public class Conversation
	{
		private var _id : String;
		private var _speeches : Vector.<Speech> = new Vector.<Speech>;
		private var _responses : Vector.<Response> = new Vector.<Response>;

		public function Conversation( id : String )
		{
			this.id = id;
		}

		public function get responses() : Vector.<Response>
		{
			return _responses;
		}

		public function get speeches() : Vector.<Speech>
		{
			return _speeches;
		}

		public function addSpeech( tSpeech : Speech ) : void
		{
			_speeches.push( tSpeech );
		}

		public function addResponse( tResponse : Response ) : void
		{
			_responses.push( tResponse );
		}

		public function get id() : String
		{
			return _id;
		}

		public function set id( value : String ) : void
		{
			_id = value;
		}
	}
}