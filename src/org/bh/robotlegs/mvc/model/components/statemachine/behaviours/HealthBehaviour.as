package org.bh.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bh.robotlegs.mvc.model.components.statemachine.IBehaviour;
	
	public class HealthBehaviour implements IBehaviour
	{
		private var _health:int
		public function HealthBehaviour(tHealth:int)
		{
			health = tHealth
		}

		public function get health():int
		{
			return _health;
		}

		public function set health(value:int):void
		{
			_health = value;
		}

	}
}