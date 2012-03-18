package org.bemupengine.robotlegs.mvc.model.components.statemachine
{
	public class Rule
	{
		private var _nextState : int;
		private var _checks : Vector.<ICheck> = new Vector.<ICheck>;

		public function Rule( tNextState : int )
		{
			_nextState = tNextState;
		}

		public function get checks() : Vector.<ICheck>
		{
			return _checks;
		}

		public function set checks( value : Vector.<ICheck> ) : void
		{
			_checks = value;
		}

		public function get nextState() : int
		{
			return _nextState;
		}

		public function set nextState( value : int ) : void
		{
			_nextState = value;
		}
	}
}