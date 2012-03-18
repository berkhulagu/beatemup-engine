package org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.IBehaviour;
	
	public class FacingBehaviour implements IBehaviour
	{
		private var _facing:Number;
		
		public function FacingBehaviour(tFacingInDegree:int)
		{
			_facing = tFacingInDegree/180.0*Math.PI;
		}
		
		
		public function get facing():Number
		{
			return _facing;
		}

		public function set facing(value:Number):void
		{
			_facing = value;
		}

	}
}