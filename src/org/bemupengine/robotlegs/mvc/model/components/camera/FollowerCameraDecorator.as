package org.bemupengine.robotlegs.mvc.model.components.camera
{
	import org.bemupengine.robotlegs.utils.Coord2D;

	public class FollowerCameraDecorator extends CameraDecorator
	{
		private var _xMin : int;
		private var _xMax : int;
		private var _lastStillSceneAt : Number;
		private var _stillSceneInit : Boolean = false;
		private var _initialCamerePosition : Coord2D;

		public function FollowerCameraDecorator( decoratedCamera : ICamera, tXMin : int, tXMax : int )
		{
			super( decoratedCamera );
			xMin = tXMin;
			xMax = tXMax;
		}

		public function get xMax() : int
		{
			return _xMax;
		}

		public function set xMax( value : int ) : void
		{
			_xMax = value;
		}

		public function get xMin() : int
		{
			return _xMin;
		}

		public function set xMin( value : int ) : void
		{
			_xMin = value;
		}

		override public function update( tCharacterPosX : int, tCharacterPosY : int ) : Coord2D
		{
			// check x,y etc
			// trace("Update : RestrictedAreaCameraDecorator")

			if (xMax == xMin)
			{
				// set the time to current time
				_lastStillSceneAt = new Date().time;
				_stillSceneInit = true;
			}
			else if (tCharacterPosX < xMax && tCharacterPosX > xMin)
			{
				var tNow : Number = new Date().time;

				if (_lastStillSceneAt && tNow - _lastStillSceneAt < 3000)
				{
					if (_stillSceneInit)
					{
						_stillSceneInit = false;
						_initialCamerePosition = getNextCameraPosition();
					}
					if (tCharacterPosX - 400 - _initialCamerePosition.x > 0)
					{
						getNextCameraPosition().x = _initialCamerePosition.x + (tNow - _lastStillSceneAt) * (tCharacterPosX - 400 - _initialCamerePosition.x) / 3000;
						getNextCameraPosition().y = _initialCamerePosition.y + (tNow - _lastStillSceneAt) * (tCharacterPosX - _initialCamerePosition.y) / 3000;
					}
				}
				else
				{
					_lastStillSceneAt = NaN;
					getNextCameraPosition().x = tCharacterPosX - 400;
					getNextCameraPosition().y = tCharacterPosY;
				}
			}
			return  super.update( tCharacterPosX, tCharacterPosY );
		}
	}
}