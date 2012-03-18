package org.bemupengine.robotlegs.mvc.model.components.hotspots.actions
{
	import org.bemupengine.robotlegs.mvc.model.components.hotspots.IHotspot;

	public class AbstractAction implements IAction
	{
		private var _parent : IHotspot;

		public function AbstractAction( tParent : IHotspot )
		{
			_parent = tParent;
		}

		public function get parent() : IHotspot
		{
			return _parent;
		}

		public function trigger() : void
		{
			throw Error( "You must override me!" );
		}
	}
}