package org.bh.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bh.robotlegs.mvc.model.components.statemachine.IBehaviour;
	
	public class SpeedBehaviour implements IBehaviour
	{
		private var _speed:Number;
		
		public function SpeedBehaviour(tSpeed:Number)
		{
			_speed = tSpeed
		}


		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(value:Number):void
		{
			_speed = value;
		}

	}
}