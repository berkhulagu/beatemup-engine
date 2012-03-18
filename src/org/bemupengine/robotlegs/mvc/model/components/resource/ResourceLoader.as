package org.bemupengine.robotlegs.mvc.model.components.resource
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import org.bemupengine.robotlegs.events.ResourceEvent;
	import org.bemupengine.robotlegs.mvc.model.components.vo.RequestedLibraryVO;


	/** loads swfs and xmls */
	public class ResourceLoader extends EventDispatcher
	{
		/** loader helper util class */
		private var loaderHelper : Dictionary = new Dictionary();
		/** loaded libraries are stored here */
		private var loadedLibraries : Dictionary = new Dictionary();

		public function ResourceLoader()
		{
		}

		/** loads the requested libraries */
		public function loadLibraries( tRequestedLibraries : Vector.<RequestedLibraryVO> ) : void
		{
			for each (var tRequestedLibraryInfo:RequestedLibraryVO in tRequestedLibraries)
			{
				loadLibrary( tRequestedLibraryInfo );
			}
		}

		/** loads the target library */
		private function loadLibrary( tRequestedLibraryVO : RequestedLibraryVO ) : void
		{
			var tURLRequest : URLRequest = new URLRequest( tRequestedLibraryVO.url );
			var tLoader : Loader = new Loader();
			loaderHelper[tLoader] = tRequestedLibraryVO;

			tLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, onResourcesLoaded, false, 0, true );
			tLoader.load( tURLRequest );
		}

		/** calback function; triggered when resources are loaded */
		private function onResourcesLoaded( evt : Event ) : void
		{
			var tContent : LoaderInfo = evt.target as LoaderInfo;

			// which requested library is loaded?
			var tRequestedLibraryVO : RequestedLibraryVO = loaderHelper[tContent.loader];
			tRequestedLibraryVO.content = tContent;

			// are all requested libraries loaded?
			if (areAllLibrariesLoaded( tRequestedLibraryVO.batch ))
			{
				// store them in loaded libraries dictionary for quick access
				storeLoadedLibraries( tRequestedLibraryVO.batch );

				// tell the resourcemodel that the resources are loaded and they are accessible
				dispatchEvent( new ResourceEvent( ResourceEvent.LOADED + "|" + tRequestedLibraryVO.batch, tRequestedLibraryVO.batch ) );
			}
		}

		/** stores the loaded libraries in loadedLıbraries dictionary for quick access */
		private function storeLoadedLibraries( tBatch : String ) : void
		{
			var tVecRLI : Vector.<RequestedLibraryVO> = new Vector.<RequestedLibraryVO>();

			for each (var tRLI:RequestedLibraryVO in loaderHelper)
			{
				if (tRLI.batch == tRLI.batch)
				{
					tVecRLI.push( tRLI );
				}
			}

			loadedLibraries[tBatch] = tVecRLI;
		}

		/** checks whether if all libs are loaded or not */
		private function areAllLibrariesLoaded( tBatch : String ) : Boolean
		{
			for each (var tRLI:RequestedLibraryVO in loaderHelper)
			{
				if (tRLI.batch == tBatch && tRLI.content == null)
					return false;
			}

			return true;
		}

		/** creates movieclip from the given classname
		 * @param tName name of the class
		 * @return object of that target class
		 */
		public function getObjectFromClassName( tBatch : String, tName : String ) : MovieClip
		{
			var tLoadedLibs : Vector.<RequestedLibraryVO> = loadedLibraries[tBatch];

			for each (var tRequestedLibraryInfo:RequestedLibraryVO in tLoadedLibs)
			{
				if (tRequestedLibraryInfo.content.applicationDomain.hasDefinition( tName ))
				{
					var tClass : Class = tRequestedLibraryInfo.content.applicationDomain.getDefinition( tName ) as Class;
					var tMC : MovieClip = new tClass() as MovieClip;

					return tMC;
				}
			}

			return null;
		}

		/** loads xml data and calls the callback function when done */
		public function loadXMLData( tPath : String, tCallback : Function ) : void
		{
			var tLoader : URLLoader = new URLLoader();
			tLoader.load( new URLRequest( tPath ) );
			tLoader.addEventListener( Event.COMPLETE, tCallback, false, 0, true );
		}

		/** checks whether if a batch is loaded or not */
		public function isBatchLoaded( tBatch : String ) : Boolean
		{
			if (loadedLibraries[tBatch])
				return true;
			else
				return false;
		}
	}
}