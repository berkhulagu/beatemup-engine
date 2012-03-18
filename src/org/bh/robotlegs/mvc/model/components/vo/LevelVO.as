package org.bh.robotlegs.mvc.model.components.vo
{
	import org.bh.robotlegs.mvc.model.components.character.CharacterBean;
	import org.bh.robotlegs.mvc.model.components.hotspots.Hotspot;
	import org.bh.robotlegs.mvc.model.components.hotspots.IHotspot;
	import org.bh.robotlegs.mvc.model.components.level.CloneInfo;
	import org.bh.robotlegs.mvc.model.components.level.LayerInfo;
	import org.bh.robotlegs.utils.Coord2D;

	public class LevelVO
	{
		// from level config file 
		private var _levelId:int;
		private var _requiredCharacterTypes:Vector.<String>
		private var _clones:Vector.<CloneInfo>
		private var _layers:Vector.<LayerInfo>
		private var _hotspots:Vector.<IHotspot>
		// ~from level config file
		
		// used in simulation, updated frequently
		private var _playerPosition:Coord2D
		private var _enemyPositions:Vector.<Coord2D> = new Vector.<Coord2D>
		// ~used in simulation, updated frequently
							
		public function LevelVO()
		{
		}
		
		public function cleanup():void {
			
			_levelId = 0
			if(_requiredCharacterTypes)
				_requiredCharacterTypes.splice(0, _requiredCharacterTypes.length-1)
			if(_clones)
				_clones.splice(0, _clones.length-1)
			if(_layers)
				_layers.splice(0, _layers.length-1)
			if(_hotspots)
			_hotspots.splice(0, _hotspots.length-1)
			// ~from level config file
			
			// used in simulation, updated frequently
			_playerPosition = new Coord2D(0,0)
			_enemyPositions.splice(0, _enemyPositions.length-1)
			// ~used in simulation, updated frequently
		}
		
		public function get hotspots():Vector.<IHotspot>
		{
			return _hotspots;
		}

		public function set hotspots(value:Vector.<IHotspot>):void
		{
			_hotspots = value;
		}

		public function get layers():Vector.<LayerInfo>
		{
			return _layers;
		}

		public function set layers(value:Vector.<LayerInfo>):void
		{
			_layers = value;
		}

		public function get clones():Vector.<CloneInfo>
		{
			return _clones;
		}

		public function set clones(value:Vector.<CloneInfo>):void
		{
			_clones = value;
		}

		public function get enemyPositions():Vector.<Coord2D>
		{
			return _enemyPositions;
		}

		public function set enemyPositions(value:Vector.<Coord2D>):void
		{
			_enemyPositions = value;
		}

		public function setLevelInfo(tLevelId:int, tRequiredCharacters:Vector.<String>, tCharacters:Vector.<CharacterBean>, tClones:Vector.<CloneInfo>, tLayers:Vector.<LayerInfo>, tHotspots:Vector.<IHotspot>):void {
			levelId = tLevelId
			requiredCharacterTypes = tRequiredCharacters
			clones = tClones
			layers = tLayers				
			hotspots  = tHotspots
		}


		public function get requiredCharacterTypes():Vector.<String>
		{
			return _requiredCharacterTypes;
		}

		public function set requiredCharacterTypes(value:Vector.<String>):void
		{
			_requiredCharacterTypes = value;
		}

	
		public function get levelId():int
		{
			return _levelId;
		}

		public function set levelId(value:int):void
		{
			_levelId = value;
		}

		public function get playerPosition():Coord2D
		{
			return _playerPosition;
		}

		public function set playerPosition(value:Coord2D):void
		{
			_playerPosition = value;
		}

	}
}