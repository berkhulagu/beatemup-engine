package org.bemupengine.robotlegs.mvc.model.components.hotspots.actions
{
	import org.bemupengine.robotlegs.mvc.model.components.hotspots.IHotspot;

	public class AddEnemyAction extends AbstractAction
	{
		private var _enemyId : String;
		private var _enemyType : String;
		private var _distanceX : int;
		private var _distanceY : int;
		private var _stateManagerId : int;
		private var _initialState : int;

		public function AddEnemyAction( tParent : IHotspot, tEnemyId : String, tEnemyType : String, tStateManagerId : int, tInitialState : int, tDistanceX : int, tDistanceY : int )
		{
			super( tParent );
			_enemyId = tEnemyId;
			_enemyType = tEnemyType;
			_stateManagerId = tStateManagerId;
			_initialState = tInitialState	;
			_distanceX = tDistanceX;
			_distanceY = tDistanceY	;
		}

		public function get enemyId() : String
		{
			return _enemyId;
		}

		public function set enemyId( value : String ) : void
		{
			_enemyId = value;
		}

		public function get stateManagerId() : int
		{
			return _stateManagerId;
		}

		public function get initialState() : int
		{
			return _initialState;
		}

		override public function trigger() : void
		{
			trace( "Triggering AddEnemyAction!" );
		}

		public function get distanceY() : int
		{
			return _distanceY;
		}

		public function set distanceY( value : int ) : void
		{
			_distanceY = value;
		}

		public function get distanceX() : int
		{
			return _distanceX;
		}

		public function set distanceX( value : int ) : void
		{
			_distanceX = value;
		}

		public function set initialState( value : int ) : void
		{
			_initialState = value;
		}

		public function set stateManagerId( value : int ) : void
		{
			_stateManagerId = value;
		}

		public function get enemyType() : String
		{
			return _enemyType;
		}

		public function set enemyType( value : String ) : void
		{
			_enemyType = value;
		}
	}
}