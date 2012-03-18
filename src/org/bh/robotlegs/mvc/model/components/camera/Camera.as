package org.bh.robotlegs.mvc.model.components.camera
{
	import flash.geom.Point;
	
	import org.bh.robotlegs.utils.Coord2D;

	public class Camera implements ICamera
	{
		protected var characterPosition:Coord2D = new Coord2D(0,0);
		protected var nextCameraPosition:Coord2D 	= new Coord2D(0,0);
		protected var prevCameraPosition:Coord2D 	= new Coord2D(0,0);
		
		
		public function Camera(tCharacterPosition:Coord2D)
		{
			characterPosition = tCharacterPosition
			
		}
		
		/** characters position is provided and in return, cameras position is received */
		public function update(tCharacterPosX:int, tCharacterPosY:int):Coord2D
		{
			//trace("Update : Camera");
			characterPosition.x = tCharacterPosX
			characterPosition.y = tCharacterPosY
			
				
			var tDiff:Coord2D = new Coord2D( nextCameraPosition.x - prevCameraPosition.x, nextCameraPosition.y - prevCameraPosition.y);
			
			prevCameraPosition.x = nextCameraPosition.x
			prevCameraPosition.y = nextCameraPosition.y
					
			return tDiff;
				
		}
		
		public function getPrevCameraPosition():Coord2D {
			return prevCameraPosition
		}

		public function getNextCameraPosition():Coord2D {
			return nextCameraPosition
		}
		
		public function getCharacterPosition():Coord2D {
			return characterPosition
		}
	}
}