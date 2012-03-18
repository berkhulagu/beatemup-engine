package org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.IBehaviour;

	public class AddConversationListenerBehaviour implements IBehaviour
	{
		private var _conversationId : String;
		private var _characterId : String;
		private var _state : int;

		public function AddConversationListenerBehaviour( tConversationId : String, tCharacterId : String, tState : int )
		{
			conversationId = tConversationId;
			characterId = tCharacterId;
			state = tState;
		}

		public function get state() : int
		{
			return _state;
		}

		public function set state( value : int ) : void
		{
			_state = value;
		}

		public function get characterId() : String
		{
			return _characterId;
		}

		public function set characterId( value : String ) : void
		{
			_characterId = value;
		}

		public function get conversationId() : String
		{
			return _conversationId;
		}

		public function set conversationId( value : String ) : void
		{
			_conversationId = value;
		}
	}
}