package org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.IBehaviour;

	public class SetConversationBehaviour implements IBehaviour
	{
		private var _characterId : String;
		private var _conversationId : String;

		public function SetConversationBehaviour( characterId : String, conversationId : String )
		{
			_characterId = characterId;
			_conversationId = conversationId;
		}

		public function get conversationId() : String
		{
			return _conversationId;
		}

		public function get characterId() : String
		{
			return _characterId;
		}
	}
}