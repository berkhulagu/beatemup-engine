package org.bemupengine.robotlegs.mvc.model.components.camera
{
	import org.bemupengine.robotlegs.utils.Coord2D;

	public interface ICamera
	{
		function update( tCharacterPosX : int, tCharacterPosY : int ) : Coord2D

		function getPrevCameraPosition() : Coord2D;

		function getNextCameraPosition() : Coord2D;

		function getCharacterPosition() : Coord2D;
	}
}