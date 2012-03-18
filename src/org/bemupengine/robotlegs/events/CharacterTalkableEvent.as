package org.bemupengine.robotlegs.events
{
	import flash.events.Event;
	import org.bemupengine.robotlegs.mvc.model.components.character.CharacterBean;


	public class CharacterTalkableEvent extends Event
	{
		public static const SHOW : String = "CTE.show";
		public static const HIDE : String = "CTE.hide";
		private var _characterBean : CharacterBean;

		public function CharacterTalkableEvent( type : String, characterBean : CharacterBean, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
			this.characterBean = characterBean;
		}

		override public function clone() : Event
		{
			return new CharacterTalkableEvent( type, characterBean, bubbles, cancelable );
		}

		public function get characterBean() : CharacterBean
		{
			return _characterBean;
		}

		public function set characterBean( value : CharacterBean ) : void
		{
			_characterBean = value;
		}
	}
}