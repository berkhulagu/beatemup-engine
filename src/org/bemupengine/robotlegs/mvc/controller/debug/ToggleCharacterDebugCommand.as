package org.bemupengine.robotlegs.mvc.controller.debug
{
	import org.bemupengine.robotlegs.events.DebugCharacterEvent;
	import org.bemupengine.robotlegs.mvc.model.DebugModel;
	import org.bemupengine.robotlegs.mvc.model.LevelModel;
	import org.bemupengine.robotlegs.mvc.model.components.character.CharacterBean;
	import org.robotlegs.mvcs.Command;

	public class ToggleCharacterDebugCommand extends Command
	{
		[Inject]
		public var event : DebugCharacterEvent;
		
		[Inject]
		public var debug : DebugModel;
		
		[Inject]
		public var level : LevelModel;

		override public function execute() : void
		{
			if (debug.getCharacterBean( event.characterId ) == null)
			{
				// get the character bean from level
				var tCharacterBean : CharacterBean = level.getCharacterBean( event.characterId );
				debug.addCharacterToBeDebugged( tCharacterBean );
			}
			else
			{
				// it s already in, remove it
				debug.removeCharacterToBeDebugged( event.characterId );
			}
		}
	}
}