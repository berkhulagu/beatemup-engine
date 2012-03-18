package org.bh.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bh.robotlegs.mvc.model.components.statemachine.IBehaviour;
	
	public class AddCharacterBehaviour implements IBehaviour
	{
		private var _enemyId:String;
		private var _enemyType:String
		private var _posX:int
		private var _posY:int
		private var _stateManagerId:int;
		private var _initialState:int;
		
		public function AddCharacterBehaviour(tEnemyId:String, tEnemyType:String, tStateManagerId:int, tInitialState:int, tDistanceX:int, tDistanceY:int)
		{
			_enemyId   = tEnemyId
			_enemyType = tEnemyType
			_stateManagerId = tStateManagerId
			_initialState = tInitialState	
			_posX = tDistanceX
			_posY = tDistanceY		
			
		}
		
		public function get posY():int
		{
			return _posY;
		}

		public function set posY(value:int):void
		{
			_posY = value;
		}

		public function get posX():int
		{
			return _posX;
		}

		public function set posX(value:int):void
		{
			_posX = value;
		}

		public function get enemyId():String
		{
			return _enemyId;
		}
		
		public function set enemyId(value:String):void
		{
			_enemyId = value;
		}
		
		
		public function get stateManagerId():int
		{
			return _stateManagerId;
		}
		
		public function get initialState():int
		{
			return _initialState;
		}
		
		
		
		public function set initialState(value:int):void
		{
			_initialState = value;
		}
		
		public function set stateManagerId(value:int):void
		{
			_stateManagerId = value;
		}
		
		public function get enemyType():String
		{
			return _enemyType;
		}
		
		public function set enemyType(value:String):void
		{
			_enemyType = value;
		}
		
	}
}