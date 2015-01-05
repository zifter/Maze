package maze.matrix {
	// base
	import maze.VisualizerBase;

	// ui
	import mx.core.UIComponent;
	import flash.geom.Point;

	public class MatrixVisualizerBase extends VisualizerBase
	{
		override protected function doDraw():void
		{
			var start:Point = new Point(thickness / 2, thickness / 2);
			var genMaze:MatrixGeneratorBase = generator as MatrixGeneratorBase;
			
			view.setStyle('borderWeight', thickness);
			view.graphics.clear();

			view.width  = size.x * genMaze.width  + thickness;
			view.height = size.y * genMaze.height + thickness;
			
			for (var cx:uint = 0; cx < genMaze.width; ++cx)
			{
				for (var cy:uint = 0; cy < genMaze.height; ++cy)
				{
					var cData:uint = genMaze.cell(cx, cy);
					view.graphics.lineStyle(thickness, (cData & MazeType.CELL_VISITED) ? 0x000000 : 0xCCCCCC);
					if (cData & MazeType.WALL_TOP)
					{
						view.graphics.moveTo(start.x + cx * size.x, start.y + cy * size.y);
						view.graphics.lineTo(start.x + cx * size.x + size.x, start.y + cy * size.y);
					}

					if (cData & MazeType.WALL_LEFT)
					{
						view.graphics.moveTo(start.x + cx * size.x, start.y + cy * size.y);
						view.graphics.lineTo(start.x + cx * size.x, start.y + cy * size.y + size.y);
					}
				}
			}

			// Draw start position
			view.graphics.lineStyle();
			view.graphics.beginFill(0x55FF11, 1);
			view.graphics.drawCircle(start.x + genMaze.start.x * size.x + size.x / 2, start.y + genMaze.start.y * size.y + size.y / 2, size.x / 2.5);
			view.graphics.endFill();

			// Draw finish position
			view.graphics.lineStyle();
			view.graphics.beginFill(0xFF6611, 1);
			view.graphics.drawRect(start.x + genMaze.finish.x * size.x + 2, start.y + genMaze.finish.y * size.y + 2, size.x - 4, size.y - 4);
			view.graphics.endFill();
		}
	}
}