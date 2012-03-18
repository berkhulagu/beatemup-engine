package org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.IBehaviour;
	
	public class AnimationBehaviour implements IBehaviour
	{
		private var _animationName:String;
		
		public function AnimationBehaviour(tAnimationName:String)
		{
			_animationName = tAnimationName;
		}

		public function get animationName():String
		{
			return _animationName;
		}

	}
}