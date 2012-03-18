package org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.IBehaviour;

	public class UpdateCharacterState implements IBehaviour
	{
		private var _characterid : String;
		private var _state : int;

		public function UpdateCharacterState( characterId : String, state : int )
		{
			_characterid = characterId;
			_state = state;
		}

		public function get state() : int
		{
			return _state;
		}

		public function get characterid() : String
		{
			return _characterid;
		}
	}
}