package org.bh.robotlegs.events
{
	import flash.events.Event;
	
	import org.bh.robotlegs.mvc.model.components.character.CharacterBean;
	
	public class CharacterAnimationEvent extends Event
	{
		private var _characterBean:CharacterBean
		private var _param:String
		
		public static const SET_ANIMATION:String = "CharacterAnimationEvent.setAnimation"
		public static const LISTEN:String = "CharacterAnimationEvent.listen"
		
		public function CharacterAnimationEvent(type:String, tCharacterBean:CharacterBean, tParam:String = "", tbubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_characterBean = tCharacterBean
			_param = tParam
		}

		
		public function get param():String
		{
			return _param;
		}

		public function get characterBean():CharacterBean
		{
			return _characterBean;
		}

		override public function clone():Event {
			return new CharacterAnimationEvent(type, _characterBean, _param, bubbles, cancelable)
		}

	}
}