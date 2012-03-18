package org.bh.robotlegs.mvc.model.components.camera
{
	import org.bh.robotlegs.utils.Coord2D;

	public interface ICamera
	{
		function update(tCharacterPosX:int, tCharacterPosY:int):Coord2D
		function getPrevCameraPosition():Coord2D;
		function getNextCameraPosition():Coord2D;
		function getCharacterPosition():Coord2D;
		
	}
}