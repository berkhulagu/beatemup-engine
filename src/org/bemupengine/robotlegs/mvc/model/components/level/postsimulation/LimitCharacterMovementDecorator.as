package org.bemupengine.robotlegs.mvc.model.components.level.postsimulation
{
	import org.bemupengine.robotlegs.mvc.model.components.character.CharacterBean;

	public class LimitCharacterMovementDecorator extends PostSimulationDecorator
	{
		private var _avatarsCharacterBean : CharacterBean;
		private var _minX : int;
		private var _maxX : int;
		private var _minY : int;
		private var _maxY : int;

		public function LimitCharacterMovementDecorator( tDecoratedPostSimulation : IPostSimulation, tAvatarsCharacterBean : CharacterBean, tMinX : int, tMinY : int, tMaxX : int, tMaxY : int )
		{
			super( tDecoratedPostSimulation );

			_avatarsCharacterBean = tAvatarsCharacterBean;
			_minX = tMinX;
			_maxX = tMaxX;
			_minY = tMinY;
			_maxY = tMaxY;
		}

		override public function update() : void
		{
			if (_avatarsCharacterBean.posX < _minX )
			{
				_avatarsCharacterBean.posX = _minX;
				if (_avatarsCharacterBean.isFacingLeft)
					_avatarsCharacterBean.speed = 0;
			}

			if (_avatarsCharacterBean.posX > _maxX)
			{
				_avatarsCharacterBean.posX = _maxX;
				if (_avatarsCharacterBean.isFacingRight)
					_avatarsCharacterBean.speed = 0;
			}

			if (_avatarsCharacterBean.posY < _minY)
			{
				_avatarsCharacterBean.posY = _minY;

				if (_avatarsCharacterBean.isFacingLeft)
					_avatarsCharacterBean.facing = Math.PI;
				else if (_avatarsCharacterBean.isFacingRight)
					_avatarsCharacterBean.facing = 0;
			}
			if (_avatarsCharacterBean.posY > _maxY)
			{
				_avatarsCharacterBean.posY = _maxY;

				if (_avatarsCharacterBean.isFacingLeft)
					_avatarsCharacterBean.facing = Math.PI;
				else if (_avatarsCharacterBean.isFacingRight)
					_avatarsCharacterBean.facing = 0;
			}
		}
	}
}