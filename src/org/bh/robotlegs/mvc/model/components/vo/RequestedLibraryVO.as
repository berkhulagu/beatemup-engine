package org.bh.robotlegs.mvc.model.components.vo
{
	import flash.display.LoaderInfo;

	public class RequestedLibraryVO
	{
		private var _batch:String;
		
		/** unique id of the requested library */
		private var _id:String;
		
		/** url for the library */
		private var _url:String
		
		private var _content:LoaderInfo
		
		public function RequestedLibraryVO(batch:String, id:String, url:String)
		{
			this.batch = batch
			this.id  = id
			this.url = url
			this._content = null;
		}


		/** to which batch this requested library belongs to */
		public function get batch():String
		{
			return _batch;
		}

		/**
		 * @private
		 */
		public function set batch(value:String):void
		{
			_batch = value;
		}

		/** content info of the library. Initially its null, but when the library is loaded, it must be non-null */
		public function get content():LoaderInfo
		{
			return _content;
		}

		/**
		 * @private
		 */
		public function set content(value:LoaderInfo):void
		{
			_content = value;
		}

		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

	}
}