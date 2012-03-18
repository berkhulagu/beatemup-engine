package org.bemupengine.robotlegs.mvc.view.components
{
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import org.bemupengine.robotlegs.mvc.model.components.camera.ICamera;
	import org.bemupengine.robotlegs.mvc.model.components.character.CharacterBean;


	public class LevelView extends MovieClip
	{
		private var _levelGraphics : MovieClip;
		private var _camera : ICamera;
		private var _characterHolder : Dictionary = new Dictionary();

		public function LevelView()
		{
			super();
		}

		public function get levelGraphics() : MovieClip
		{
			return _levelGraphics;
		}

		public function updateCameraInfo( tCamera : ICamera ) : void
		{
			_camera = tCamera;
		}

		public function setLevelGraphics( tLevelGraphics : MovieClip ) : void
		{
			if (_levelGraphics)
				_levelGraphics = null;

			_levelGraphics = tLevelGraphics;
			_levelGraphics.name = "level";
			_levelGraphics.y = 600;

			this.addChild( _levelGraphics );
		}

		public function updatePosition( tCharacterBean : CharacterBean ) : void
		{
			if (tCharacterBean)
			{
				var tCharacterHolder : MovieClip = _characterHolder[tCharacterBean.id];
				if (tCharacterHolder)
				{
					tCharacterHolder.x = tCharacterBean.posX - _camera.getNextCameraPosition().x;
					tCharacterHolder.y = tCharacterBean.posY;
				}

				if (tCharacterBean.speed != 0)
				{
					if (tCharacterBean.facing >= Math.PI / 2 && tCharacterBean.facing <= 3 * Math.PI / 2 && tCharacterBean.isMovingLeft )
					{
						tCharacterHolder.rotationY = 180;
					}
					else
					{
						tCharacterHolder.rotationY = 0;
					}
				}
			}
		}

		/** sets the animation */
		public function setCharacterAnimation( tCharacterBean : CharacterBean, tAnimationMC : MovieClip ) : MovieClip
		{
			var tCharacterHolder : MovieClip = _characterHolder[tCharacterBean.id];

			if (tCharacterHolder == null)
			{
				trace( "Character holder created for " + tCharacterBean.id );
				tCharacterHolder = new MovieClip();
				if (tCharacterBean.id == null)
					trace( "wft!" );
				tCharacterHolder.name = tCharacterBean.id;
				tCharacterHolder.scaleX = 0.3;
				tCharacterHolder.scaleY = 0.3;
				tCharacterHolder.x = tCharacterBean.posX - _camera.getNextCameraPosition().x;
				tCharacterHolder.y = tCharacterBean.posY;
				_characterHolder[tCharacterBean.id] = tCharacterHolder;
				_levelGraphics.addChild( tCharacterHolder );
			}

			var tCharacterAnimation : MovieClip = tCharacterHolder.getChildByName( "animation" ) as MovieClip;

			if (tCharacterAnimation)
			{
				tCharacterHolder.removeChild( tCharacterAnimation );
			}

			// if there is no such animation, do nothing else
			if (tAnimationMC == null)
			{
				return tCharacterAnimation;
			}
			else
			{
				tAnimationMC.name = "animation";
				tCharacterHolder.addChild( tAnimationMC );

				// choose a random frame, eyecandy
				tAnimationMC = (tAnimationMC.getChildAt( 0 ) as MovieClip);
				var tRand : int = int( Math.random() * 100 );
				var tTotalFrames : int = tAnimationMC.totalFrames;

				var tRandom : int = tRand % tTotalFrames;
				tAnimationMC.gotoAndPlay( tRandom );
			}

			return tCharacterAnimation;
		}

		public function getLevelComponent( tName : String ) : MovieClip
		{
			return _levelGraphics.getChildByName( tName ) as MovieClip;
		}

		public function performZSorting() : void
		{
			for each (var tMC1:MovieClip in _characterHolder)
			{
				for each (var tMC2:MovieClip in _characterHolder)
				{
					if (tMC1.y > tMC2.y && (_levelGraphics.getChildIndex( tMC1 ) < _levelGraphics.getChildIndex( tMC2 )))
						_levelGraphics.swapChildren( tMC1, tMC2 );
				}
			}
		}

		public function attachToCharacterHolder( characterBean : CharacterBean, tExclMark : MovieClip ) : void
		{
			var tHolder : MovieClip = _characterHolder[characterBean.id] as MovieClip;
			tExclMark.y -= tHolder.height * 3;
			tHolder.addChild( tExclMark );
		}

		public function removeFromCharacterHolder( characterBean : CharacterBean, tName : String ) : void
		{
			var tHolder : MovieClip = _characterHolder[characterBean.id] as MovieClip;
			var tRemove : MovieClip = tHolder.getChildByName( tName ) as MovieClip;

			if (tRemove)
				tHolder.removeChild( tHolder.getChildByName( tName ) );
		}
	}
}