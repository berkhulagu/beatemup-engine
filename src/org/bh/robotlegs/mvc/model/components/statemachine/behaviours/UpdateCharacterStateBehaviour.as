package org.bh.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bh.robotlegs.mvc.model.components.statemachine.IBehaviour;
	
	public class UpdateCharacterStateBehaviour implements IBehaviour
	{
		private var _characterId:String
		private var _state:int
		
		public function UpdateCharacterStateBehaviour(characterId:String, state:int)
		{
			this.characterId = characterId
			this.state = state
		}

		public function get state():int
		{
			return _state;
		}

		public function set state(value:int):void
		{
			_state = value;
		}

		public function get characterId():String
		{
			return _characterId;
		}

		public function set characterId(value:String):void
		{
			_characterId = value;
		}

	}
}