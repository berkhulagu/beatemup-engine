package org.bemupengine.robotlegs.mvc.model.components.camera
{
	import org.bemupengine.robotlegs.utils.Coord2D;

	public class CameraDecorator implements ICamera
	{
		protected var decoratedCamera : ICamera;

		public function CameraDecorator( decoratedCamera : ICamera )
		{
			this.decoratedCamera = decoratedCamera;
		}

		public function update( tCharacterPosX : int, tCharacterPosY : int ) : Coord2D
		{
			// trace("Update : CameraDecorator")
			return decoratedCamera.update( tCharacterPosX, tCharacterPosY );
		}

		public function getPrevCameraPosition() : Coord2D
		{
			return decoratedCamera.getPrevCameraPosition();
		}

		public function getNextCameraPosition() : Coord2D
		{
			return decoratedCamera.getNextCameraPosition();
		}

		public function getCharacterPosition() : Coord2D
		{
			return decoratedCamera.getCharacterPosition();
		}
	}
}