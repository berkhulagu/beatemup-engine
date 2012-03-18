package org.bh.robotlegs.mvc.model.components.level
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import org.bh.robotlegs.utils.Coord2D;

	public class LevelComponentMover 
	{
		private var componentsToBeMoved:Vector.<DisplayObject> // all components that will be moved
		
		private var indexOfComponentToBeMoved:int = 0; // next component to be moved
		
		private var _moveLimit:int // max number of times these components will be moved
		
		private var _triggerWidth:Number; 
		
		private var _offset:Coord2D
		
		private var _layer:String
		
		private var _isClonedAlreadyAChild:Boolean
		
		public function LevelComponentMover(tVecLevelComponents:Vector.<DisplayObject>, tMoveLimit:int, tWidth:Number, tOffset:Coord2D, tLayer:String, tIsToBeClonedAlreadyChild:Boolean)
		{
			componentsToBeMoved = tVecLevelComponents
			moveLimit = tMoveLimit
			triggerWidth = tWidth
			offset = tOffset
			layer = tLayer
			isClonedAlreadyAChild = tIsToBeClonedAlreadyChild
		}
		
		public function get offset():Coord2D
		{
			return _offset;
		}

		public function set offset(value:Coord2D):void
		{
			_offset = value;
		}

		public function get isClonedAlreadyAChild():Boolean
		{
			return _isClonedAlreadyAChild;
		}

		public function set isClonedAlreadyAChild(value:Boolean):void
		{
			_isClonedAlreadyAChild = value;
		}

		public function get layer():String
		{
			return _layer;
		}

		public function set layer(value:String):void
		{
			_layer = value;
		}

		public function get triggerWidth():Number
		{
			return _triggerWidth;
		}

		public function set triggerWidth(value:Number):void
		{
			_triggerWidth = value;
		}

		public function get moveLimit():int
		{
			return _moveLimit;
		}

		public function set moveLimit(value:int):void
		{
			_moveLimit = value;
		}

		/** is it still movable */
		public function get hasExceeded():Boolean {
			if(moveLimit == 0)
				return true
			else return false
		}
		
		/** get next-to-be-moveds last pixed that will be seen */
		public function getBlocksPosX(tIsPrevRequired:Boolean = false):Number {
			if(tIsPrevRequired)
				return triggerWidth*(indexOfComponentToBeMoved) + offset.x
			else
				return triggerWidth*(indexOfComponentToBeMoved +1) + offset.x
				
		}
		
		/** moves the current level component to its next position */
		public function moveNext(tOffSet:Number):void {
			var tLength:uint = componentsToBeMoved.length
				
			if(indexOfComponentToBeMoved < 0)
				indexOfComponentToBeMoved+= tLength
			
			if(indexOfComponentToBeMoved%tLength == 0) {
				componentsToBeMoved[0].x = componentsToBeMoved[tLength-1].x  + componentsToBeMoved[0].width
			} else
			{
				componentsToBeMoved[indexOfComponentToBeMoved%tLength].x = componentsToBeMoved[(indexOfComponentToBeMoved%tLength)-1].x + componentsToBeMoved[indexOfComponentToBeMoved%tLength].width	
			}
			
			indexOfComponentToBeMoved++
			moveLimit--
		}
		
		/** moves the next level component to its previous position */
		public function movePrev(tOffSet:Number):void {
			var tLength:uint = componentsToBeMoved.length
			if(indexOfComponentToBeMoved < 0)
				indexOfComponentToBeMoved+= tLength
					
			indexOfComponentToBeMoved++
			
			if(indexOfComponentToBeMoved%tLength == 0) {
				componentsToBeMoved[0].x = componentsToBeMoved[tLength-1].x  - componentsToBeMoved[0].width
			} else
			{
				componentsToBeMoved[indexOfComponentToBeMoved%tLength].x = componentsToBeMoved[(indexOfComponentToBeMoved%tLength)-1].x - componentsToBeMoved[indexOfComponentToBeMoved%tLength].width	
			}
			
			indexOfComponentToBeMoved-=2
			moveLimit++
		}
	}
}