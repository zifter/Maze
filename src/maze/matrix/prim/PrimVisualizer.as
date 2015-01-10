package maze.matrix.prim {
	import flash.geom.Point;
	import maze.matrix.MatrixVisualizerBase;
	
	public class PrimVisualizer extends MatrixVisualizerBase
	{
		override protected function doDraw():void
		{
			super.doDraw()
			
			var start:Point = new Point(thickness / 2, thickness / 2);
			var genMaze:PrimGenerator = generator as PrimGenerator;

			var frontier:Array = genMaze.getAllFrontier();
			// Display routre stack
			for (var i:uint = 0; i < frontier.length; ++i)
			{
				var p:Point = frontier[i];
				view.graphics.lineStyle();
				view.graphics.beginFill(0xFF9999, 1);
				view.graphics.drawRect(start.x + p.x * size.x + size.x/4, start.y + p.y * size.y + size.y/4, size.x/2, size.y/2);
				view.graphics.endFill();
			}
		}		
	}
}