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
			var lineWidth:Point = new Point(thickness / 2, thickness / 2);
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
					if (!(cData & MazeType.CELL_VISITED))
					{
						view.graphics.lineStyle();
						view.graphics.beginFill(0xB0B5BF, 1);
						view.graphics.drawRect(cx * size.x + lineWidth.x, cy * size.y + lineWidth.y, size.x - lineWidth.x, size.y - lineWidth.y);
						view.graphics.endFill();	
					}
					view.graphics.lineStyle(thickness, 0x000000);
					if (cData & MazeType.WALL_TOP)
					{
						view.graphics.moveTo(cx * size.x + lineWidth.x, lineWidth.y + cy * size.y);
						view.graphics.lineTo(cx * size.x + lineWidth.x + size.x, cy * size.y + lineWidth.y);
					}
					if (cData & MazeType.WALL_LEFT)
					{
						view.graphics.moveTo(cx * size.x + lineWidth.x, cy * size.y + lineWidth.y);
						view.graphics.lineTo(cx * size.x + lineWidth.x, cy * size.y + lineWidth.y + size.y);
					}
				}
			}
			view.graphics.lineStyle();
			var special:Array = genMaze.getSpecialVisialCells();
			// Display routre stack
			for (var i:uint = 0; i < special.length; ++i)
			{
				var p:Point = special[i];
				view.graphics.beginFill(0xFAB6B6, 1);
				view.graphics.drawRect(p.x * size.x + lineWidth.x*2, p.y * size.y + lineWidth.y*2, size.x - lineWidth.x*2, size.y - lineWidth.y*2);
				view.graphics.endFill();
			}

			// Draw start position
			view.graphics.lineStyle();
			view.graphics.beginFill(0x55FF11, 1);
			view.graphics.drawCircle(genMaze.start.x * size.x + size.x/2 + lineWidth.x, genMaze.start.y * size.y + size.y/2 + lineWidth.y, size.x / 2.5);
			view.graphics.endFill();

			// Draw finish position
			view.graphics.lineStyle();
			view.graphics.beginFill(0xFF6611, 1);
			view.graphics.drawRect(genMaze.finish.x * size.x + lineWidth.x, genMaze.finish.y * size.y + lineWidth.y, size.x - lineWidth.x, size.y - lineWidth.y);
			view.graphics.endFill();
		}
	}
}