package org.bemupengine.robotlegs.mvc.model.components.level.postsimulation
{
	public class PostSimulationDecorator implements IPostSimulation
	{
		protected var decoratedPostSimulation : IPostSimulation;

		public function PostSimulationDecorator( decoratedPostSimulation : IPostSimulation )
		{
			this.decoratedPostSimulation = decoratedPostSimulation;
		}

		public function update() : void
		{
			decoratedPostSimulation.update();
		}
	}
}