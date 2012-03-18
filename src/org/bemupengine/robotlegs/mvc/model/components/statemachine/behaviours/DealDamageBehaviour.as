package org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.IBehaviour;

	public class DealDamageBehaviour implements IBehaviour
	{
		private var _damageAmount : int;

		public function DealDamageBehaviour( tDamageAmount : int )
		{
			damageAmount = tDamageAmount;
		}

		public function get damageAmount() : int
		{
			return _damageAmount;
		}

		public function set damageAmount( value : int ) : void
		{
			_damageAmount = value;
		}
	}
}