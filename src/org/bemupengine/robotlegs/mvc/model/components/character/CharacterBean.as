package org.bemupengine.robotlegs.mvc.model.components.character
{
	import org.bemupengine.robotlegs.utils.Coord2D;

	public class CharacterBean
	{
		// unique id
		private var _id : String;
		// character type, required for animations.
		private var _type : String;
		// state related stuff
		private var _stateManagerId : int;
		private var _currentState : int;
		// position of the charater
		private var _posX : Number;
		private var _posY : Number;
		// the name of the animation thats currently displayed
		private var _currentAnimation : String;
		// need this?
		private var _randomFrameFriendly : Boolean;
		// current speed of the character
		private var _speed : Number;
		// last time the state changed
		private var _lastStateChangeAt : Number ;
		// health of the character
		private var _health : int;
		// where the character is facing in radians
		private var _facing : Number = 0;
		// need this? maybe return isFacingRight/Left() for isMovingRight/Left()?
		private var _isMovingLeft : Boolean;
		// if that character is following another one...
		private var _targetCharacter : CharacterBean;
		private var _targetOffset : Coord2D;
		private var _stop : Boolean = false;
		// if the guy will talk to you when you interact, what will he say
		private var _conversationId : String;

		public function CharacterBean( tId : String, tType : String, tStateManagerId : int, tInitialState : int, tPosX : Number, tPosY : Number, tCurrentAnimation : String, tSpeed : int, tRandomFrameFriendly : Boolean = true )
		{
			id = tId;
			type = tType;
			stateManagerId = tStateManagerId;

			posX = tPosX;
			posY = tPosY;
			currentAnimation = tCurrentAnimation;
			randomFrameFriendly = tRandomFrameFriendly;
			currentState = tInitialState;
			_speed = tSpeed;
			_health = 3;
		}

		public function get conversationId() : String
		{
			return _conversationId;
		}

		public function set conversationId( value : String ) : void
		{
			_conversationId = value;
		}

		public function get stopped() : Boolean
		{
			return _stop;
		}

		public function set stopped( value : Boolean ) : void
		{
			_stop = value;
		}

		public function get isMovingLeft() : Boolean
		{
			return _isMovingLeft;
		}

		public function set isMovingLeft( value : Boolean ) : void
		{
			_isMovingLeft = value;
		}

		public function get isFacingRight() : Boolean
		{
			// if((facing < Math.PI/2 && facing >=  0) || (facing > 3*Math.PI/2 || facing <=2*Math.PI)) {

			if (facing < Math.PI / 2 || facing > 3 * Math.PI / 2)
			{
				return true;
			}
			else return false;
		}

		public function get isFacingLeft() : Boolean
		{
			if (facing > Math.PI / 2 && facing < 3 * Math.PI / 2)
			{
				return true;
			}
			else return false;
		}

		public function get speed() : Number
		{
			if (stopped) return 0;
			else return _speed;
		}

		public function set speed( value : Number ) : void
		{
			_speed = value;
		}

		public function get facing() : Number
		{
			return _facing;
		}

		public function set facing( value : Number ) : void
		{
			_facing = value;
			while (_facing >= 2 * Math.PI)
				_facing -= 2 * Math.PI;

			if (_facing > Math.PI / 2 && _facing < 3 * Math.PI / 2)
			{
				isMovingLeft = true;
			}
			if (_facing < Math.PI / 2 || _facing > 3 * Math.PI / 2)
				isMovingLeft = false;
		}

		public function get stateManagerId() : int
		{
			return _stateManagerId;
		}

		public function get health() : int
		{
			return _health;
		}

		public function set health( value : int ) : void
		{
			_health = value;

			if (_health < 0 )
				_health = 0;
		}

		public function set stateManagerId( value : int ) : void
		{
			_stateManagerId = value;
		}

		public function get lastStateChangeAt() : Number
		{
			return _lastStateChangeAt;
		}

		public function set lastStateChangeAt( value : Number ) : void
		{
			_lastStateChangeAt = value;
		}

		public function get posY() : Number
		{
			return _posY;
		}

		public function set posY( value : Number ) : void
		{
			_posY = value;
		}

		public function get posX() : Number
		{
			return _posX;
		}

		public function set posX( value : Number ) : void
		{
			_posX = value;
		}

		public function get currentState() : int
		{
			return _currentState;
		}

		public function set currentState( value : int ) : void
		{
			_currentState = value;
		}

		public function get randomFrameFriendly() : Boolean
		{
			return _randomFrameFriendly;
		}

		public function set randomFrameFriendly( value : Boolean ) : void
		{
			_randomFrameFriendly = value;
		}

		public function get currentAnimation() : String
		{
			return _currentAnimation;
		}

		public function set currentAnimation( value : String ) : void
		{
			_currentAnimation = value;
		}

		public function get type() : String
		{
			return _type;
		}

		public function set type( value : String ) : void
		{
			_type = value;
		}

		public function get id() : String
		{
			return _id;
		}

		public function set id( value : String ) : void
		{
			_id = value;
		}

		public function follow( tTargetCharacter : CharacterBean, tOffset : Coord2D ) : void
		{
			_targetCharacter = tTargetCharacter;
			_targetOffset = tOffset;
		}

		public function unfollow() : void
		{
			_targetCharacter = null;
			_targetOffset = null;
		}

		public function get isFollowingSomeone() : Boolean
		{
			if (_targetCharacter)
			{
				return true;
			}
			else return false;
		}

		public function calculateFollow() : void
		{
			var tTargetX : int = _targetCharacter.posX + _targetOffset.x;
			var tTargetY : int = _targetCharacter.posY + _targetOffset.y;

			var tDiffX : Number = tTargetX - posX;
			var tDiffY : Number = tTargetY - posY;

			if (_targetCharacter.posX > posX && isFacingLeft)
			{
				facing += Math.PI;
			}
			else if (_targetCharacter.posX < posX && isFacingRight)
			{
				facing += Math.PI;
			}

			if ( (_targetCharacter.posX > posX && _targetCharacter.posX < posX + Math.abs( _targetOffset.x )) || (_targetCharacter.posX < posX && _targetCharacter.posX > posX - Math.abs( _targetOffset.x )))
			{
				if (tTargetY < posY && tTargetY + _targetOffset.y > posY || tTargetY > posY && tTargetY - _targetOffset.y < posY)
				{
					_stop = true;
					return;
				}
				else
				{
					if (tTargetY < posY)
						if (isMovingLeft)
							facing = 3 * Math.PI / 2 - 0.00000001;
						else
							facing = 3 * Math.PI / 2 + 0.00000001;
					else if (isMovingLeft)
						facing = Math.PI / 2 + 0.000000001;
					else
						facing = Math.PI / 2 - 0.000000001;

					_stop = false;
					return;
				}
			}
			else
			{
				_stop = false;
			}

			var tAngle : Number = NaN;

			if (((_targetCharacter.posX - posX) > 0 && _targetOffset.x > 0) || ((_targetCharacter.posX - posX) < 0 && _targetOffset.x < 0) )
			{
				_targetOffset.x *= -1;
			}

			if (tDiffX != 0)
			{
				tAngle = Math.atan( tDiffY / tDiffX );

				if (tDiffX < 0)
					tAngle += Math.PI;
			}
			else
			{
				if (tDiffY > 0)
				{
					tAngle = 1 * Math.PI / 2;
				}
				else
				{
					tAngle = -1 * Math.PI / 2;
				}
			}

			facing = tAngle;
		}
	}
}