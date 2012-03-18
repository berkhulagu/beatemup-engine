package org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.IBehaviour;
	import org.bemupengine.robotlegs.utils.Coord2D;

	public class FollowBehaviour implements IBehaviour
	{
		private var _sourceCharacterId : String;
		private var _targetCharacterId : String;
		private var _offset : Coord2D;

		public function FollowBehaviour( tSourceCharacterId : String, tTargetCharacterId : String, tOffset : Coord2D )
		{
			sourceCharacterId = tSourceCharacterId;
			targetCharacterId = tTargetCharacterId;
			offset = tOffset;
		}

		public function get sourceCharacterId() : String
		{
			return _sourceCharacterId;
		}

		public function set sourceCharacterId( value : String ) : void
		{
			_sourceCharacterId = value;
		}

		public function get offset() : Coord2D
		{
			return _offset;
		}

		public function set offset( value : Coord2D ) : void
		{
			_offset = value;
		}

		public function get targetCharacterId() : String
		{
			return _targetCharacterId;
		}

		public function set targetCharacterId( value : String ) : void
		{
			_targetCharacterId = value;
		}
	}
}