package org.bemupengine.robotlegs.mvc.model.components.hotspots
{
	import flash.events.IEventDispatcher;
	import org.bemupengine.robotlegs.mvc.model.components.hotspots.actions.IAction;


	public interface IHotspot extends IEventDispatcher
	{
		function get id() : int

		function setActions( tActions : Vector.<IAction> ) : void

		function get actions() : Vector.<IAction>

		function get x() : int

		function get y() : int

		function set x( tX : int ) : void

		function set y( tY : int ) : void

		function get limit() : int

		function set limit( tLimit : int ) : void

		function isInsideHotspot( tX : int ) : Boolean
	}
}