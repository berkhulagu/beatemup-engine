package org.bemupengine.robotlegs.mvc.model
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import org.bemupengine.robotlegs.consts.ResourceConsts;
	import org.bemupengine.robotlegs.events.LevelLoadedEvent;
	import org.bemupengine.robotlegs.events.ResourceEvent;
	import org.bemupengine.robotlegs.mvc.model.components.animations.AnimationsHolder;
	import org.bemupengine.robotlegs.mvc.model.components.resource.ResourceLoader;
	import org.bemupengine.robotlegs.mvc.model.components.vo.RequestedLibraryVO;
	import org.robotlegs.mvcs.Actor;


	public class ResourceModel extends Actor
	{
		[Inject]
		public var level : LevelModel;
		[Inject]
		public var stateMachine : StateMachineModel;
		/** it handles loading of resources */
		private var resourceLoader : ResourceLoader;
		private var _config : XML;
		/** total characters to load */
		private var totalCharactersToBeLoaded : int = 0;

		/** main config data */
		public function get config() : XML
		{
			return _config;
		}

		/**
		 * @private
		 */
		public function set config( value : XML ) : void
		{
			_config = value;
		}

		/** initializes resource model */
		public function initialize() : void
		{
			resourceLoader = new ResourceLoader();
		}

		/** loads the main config file */
		public function loadConfig() : void
		{
			// get the data of the application
			resourceLoader.loadXMLData( ResourceConsts.PATH_BASE_CONFIG + ResourceConsts.PATH_MAINCONFIG, processMainConfigData );
		}

		/** processes main config data */
		private function processMainConfigData( evt : Event ) : void
		{
			config = new XML( evt.target.data );

			// load the state machines too
			loadStateMachines();
		}

		/** load state machines */
		private function loadStateMachines() : void
		{
			resourceLoader.loadXMLData( ResourceConsts.PATH_BASE_CONFIG + ResourceConsts.PATH_BASE_CHARACTERS + ResourceConsts.PATH_STATEMACHINES, onStateMachinesLoaded );
		}

		/** when the state machine is loaded */
		private function onStateMachinesLoaded( evt : Event ) : void
		{
			stateMachine.initializeStates( new XML( evt.target.data ) );

			// load conversations
			resourceLoader.loadXMLData( ResourceConsts.PATH_BASE_CONFIG + ResourceConsts.PATH_BASE_CHARACTERS + ResourceConsts.PATH_CONVERSATIONS, onConversationsLoaded );
		}

		private function onConversationsLoaded( evt : Event ) : void
		{
			stateMachine.initializeConversations( new XML( evt.target.data ) );

			// all required xmls are loaded, gr8!
			dispatch( new ResourceEvent( ResourceEvent.LOADED + "|" + ResourceConsts.BATCH_MAINCONFIG, ResourceConsts.BATCH_MAINCONFIG ) ) ;
		}

		/** loads the menu */
		public function loadMenu() : void
		{
			var tRequiredLibraryMenu : RequestedLibraryVO = new RequestedLibraryVO( ResourceConsts.BATCH_MENU, "mainmenu", ResourceConsts.PATH_BASE_ASSETS + ResourceConsts.PATH_MENU );
			var tRequiredLibraryUI : RequestedLibraryVO = new RequestedLibraryVO( ResourceConsts.BATCH_MENU, "ui", ResourceConsts.PATH_BASE_ASSETS + ResourceConsts.PATH_UI );
			var tVecLibs : Vector.<RequestedLibraryVO> = new Vector.<RequestedLibraryVO>();

			tVecLibs.push( tRequiredLibraryMenu );
			tVecLibs.push( tRequiredLibraryUI );

			// load them
			resourceLoader.loadLibraries( tVecLibs );

			// add a listener
			eventMap.mapListener( resourceLoader, ResourceEvent.LOADED + "|" + ResourceConsts.BATCH_MENU, dispatch, ResourceEvent );
		}

		/** loads the given levels config and graphics */
		public function loadLevel( tLevel : int ) : void
		{
			level.cleanup();

			// get the data of the level
			var tPath : String = ResourceConsts.PATH_BASE_CONFIG + ResourceConsts.PATH_BASE_LEVELS + ResourceConsts.PATH_PRE_LEVEL + tLevel + ".xml";
			resourceLoader.loadXMLData( tPath, processLevelData );
		}

		/** processes levels configuration data and then loads graphics for the level */
		private function processLevelData( evt : Event ) : void
		{
			var tXML : XML = new XML( evt.target.data );

			// store the configuration under level model
			level.parseAndStoreConfig( tXML );

			// load levels graphics
			var tLevelId : int = int( tXML.@id );
			loadLevelGraphics( tLevelId );
		}

		/** load level graphics */
		private function loadLevelGraphics( tLevelId : int ) : void
		{
			// create the libraries thats required for the level
			var tPath : String = ResourceConsts.PATH_BASE_ASSETS + ResourceConsts.PATH_BASE_LEVELS + ResourceConsts.PATH_PRE_LEVEL + tLevelId + ".swf";
			var tRequiredLibraries : RequestedLibraryVO = new RequestedLibraryVO( ResourceConsts.BATCH_LEVELBASE + tLevelId, ResourceConsts.PATH_PRE_LEVEL + tLevelId, tPath );
			var tVecLibs : Vector.<RequestedLibraryVO> = new Vector.<RequestedLibraryVO>();
			tVecLibs.push( tRequiredLibraries );

			// load them
			resourceLoader.loadLibraries( tVecLibs );

			// add a listener
			eventMap.mapListener( resourceLoader, ResourceEvent.LOADED + "|" + ResourceConsts.BATCH_LEVELBASE + tLevelId, onLevelLoaded, ResourceEvent );
		}

		/** triggered when a level is loaded */
		private function onLevelLoaded( evt : ResourceEvent ) : void
		{
			// which level is loaded?
			var tLevelId : int = int( evt.batchName.split( "_" )[1] );

			// check the characters for the level, are they loaded?
			var tRequiredCharacters : Vector.<String> = level.getRequiredCharactersForLevel( tLevelId );

			var tBatchesToLoad : Vector.<String> = new Vector.<String>;

			for each (var tCharacterType:String in tRequiredCharacters)
			{
				if (!resourceLoader.isBatchLoaded( "character|" + tCharacterType ))
				{
					tBatchesToLoad.push( tCharacterType );
				}
			}

			totalCharactersToBeLoaded = tBatchesToLoad.length;

			// for each character in the list
			for each (var tBatch:String in tBatchesToLoad)
			{
				var tCharacter : XMLList = config.characters.character.(@type == tBatch);
				var tAnimationsHolder : AnimationsHolder = new AnimationsHolder();

				var tVecRLI : Vector.<RequestedLibraryVO> = new Vector.<RequestedLibraryVO>;

				for each (var tAnimationXML:XML in tCharacter[0].animation)
				{
					var tURL : String = ResourceConsts.PATH_BASE_ASSETS + ResourceConsts.PATH_BASE_ANIMATIONS + tBatch + "/" + tAnimationXML.@url + ".swf";
					var tRLI : RequestedLibraryVO = new RequestedLibraryVO( tBatch, tAnimationXML.@name, tURL );
					tVecRLI.push( tRLI );
				}

				resourceLoader.loadLibraries( tVecRLI );
				eventMap.mapListener( resourceLoader, ResourceEvent.LOADED + "|" + tBatch, onCharacterAnimationBatchLoaded, ResourceEvent );
			}
		}

		private function onCharacterAnimationBatchLoaded( evt : ResourceEvent ) : void
		{
			totalCharactersToBeLoaded--;

			if (totalCharactersToBeLoaded == 0)
			{
				// tell the application that a level is loaded completely
				dispatch( new LevelLoadedEvent( LevelLoadedEvent.LOADED, 1 ) );
			}
		}

		private function onCharacterConfigLoaded( evt : Event ) : void
		{
		}

		public function getMovieClipFromBatch( tBatch : String, tReferenceClass : String ) : MovieClip
		{
			return resourceLoader.getObjectFromClassName( tBatch, tReferenceClass );
		}
	}
}