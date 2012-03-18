package org.bh.robotlegs.mvc.model.components.animations
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	
	import org.bh.robotlegs.utils.Coord2D;

	public class AnimationsHolder
	{
		private var _characterType:String;
		
		/** the list of animations that this game item can play */
		private var _animations:Dictionary = new Dictionary()
		
		public function AnimationsHolder()
		{
		}
		

		/** who do these animations belong to */
		public function get characterType():String
		{
			return _characterType;
		}

		/**
		 * @private
		 */
		public function set characterType(value:String):void
		{
			_characterType = value;
		}

		/** adds an animation to the character */
		public function addAnimation(tAnimation:Animation):void {
			_animations[tAnimation.name] = tAnimation
		}
									 
		/** play an animation */
		public function getAnimation(tAnimationName:String):Animation {
			return _animations[tAnimationName]
		}
		

		
									 
									 
	}
}