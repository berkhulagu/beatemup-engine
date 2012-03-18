package org.bemupengine.robotlegs.mvc.model.components.vo
{
	public class ConfigurationVO
	{
		private var _musicVolume : int;
		private var _soundVolume : int;
		private var _quality : int;

		public function ConfigurationVO()
		{
		}

		public function get quality() : int
		{
			return _quality;
		}

		public function set quality( value : int ) : void
		{
			_quality = value;
		}

		public function get soundVolume() : int
		{
			return _soundVolume;
		}

		public function set soundVolume( value : int ) : void
		{
			_soundVolume = value;
		}

		public function get musicVolume() : int
		{
			return _musicVolume;
		}

		public function set musicVolume( value : int ) : void
		{
			_musicVolume = value;
		}
	}
}