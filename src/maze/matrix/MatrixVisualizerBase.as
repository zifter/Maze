package maze.matrix {
	// base
	import maze.VisualizerBase;

	// ui
	import mx.core.UIComponent;
	import flash.geom.Point;
	import maze.VisualSettings;

	public class MatrixVisualizerBase extends VisualizerBase
	{
		override protected function doDraw():void
		{
			var lineWidth:Point = new Point(settings.LINE_THICKNESS / 2, settings.LINE_THICKNESS / 2);
			var genMaze:MatrixGeneratorBase = generator as MatrixGeneratorBase;
			
			view.setStyle('borderWeight', settings.LINE_THICKNESS);
			view.graphics.clear();

			view.width  = settings.SIZE.x * genMaze.width  + settings.LINE_THICKNESS;
			view.height = settings.SIZE.y * genMaze.height + settings.LINE_THICKNESS;
	
			for (var cx:uint = 0; cx < genMaze.width; ++cx)
			{
				for (var cy:uint = 0; cy < genMaze.height; ++cy)
				{
					var cData:uint = genMaze.cell(cx, cy);
					if (!(cData & MazeType.CELL_VISITED))
					{
						view.graphics.lineStyle();
						view.graphics.beginFill(settings.COLOR_NOT_VISITED, 1);
						view.graphics.drawRect(cx * settings.SIZE.x + lineWidth.x, cy * settings.SIZE.y + lineWidth.y, settings.SIZE.x - lineWidth.x, settings.SIZE.y - lineWidth.y);
						view.graphics.endFill();	
					}
					view.graphics.lineStyle(settings.LINE_THICKNESS, settings.COLOR_WALL);
					if (cData & MazeType.WALL_TOP)
					{
						view.graphics.moveTo(cx * settings.SIZE.x + lineWidth.x, lineWidth.y + cy * settings.SIZE.y);
						view.graphics.lineTo(cx * settings.SIZE.x + lineWidth.x + settings.SIZE.x, cy * settings.SIZE.y + lineWidth.y);
					}
					if (cData & MazeType.WALL_LEFT)
					{
						view.graphics.moveTo(cx * settings.SIZE.x + lineWidth.x, cy * settings.SIZE.y + lineWidth.y);
						view.graphics.lineTo(cx * settings.SIZE.x + lineWidth.x, cy * settings.SIZE.y + lineWidth.y + settings.SIZE.y);
					}
				}
			}
			view.graphics.lineStyle();
			var special:Array = genMaze.getSpecialVisialCells();
			// Display routre stack
			for (var i:uint = 0; i < special.length; ++i)
			{
				var p:Point = special[i];
				view.graphics.beginFill(settings.COLOR_SPECIAL, 1);
				view.graphics.drawRect(p.x * settings.SIZE.x + lineWidth.x*2, p.y * settings.SIZE.y + lineWidth.y*2, settings.SIZE.x - lineWidth.x*2, settings.SIZE.y - lineWidth.y*2);
				view.graphics.endFill();
			}

			// Draw start position
			view.graphics.lineStyle();
			view.graphics.beginFill(settings.COLOR_START_CELL, 1);
			view.graphics.drawCircle(genMaze.start.x * settings.SIZE.x + settings.SIZE.x/2 + lineWidth.x, genMaze.start.y * settings.SIZE.y + settings.SIZE.y/2 + lineWidth.y, settings.SIZE.x / 2.5);
			view.graphics.endFill();

			// Draw finish position
			view.graphics.lineStyle();
			view.graphics.beginFill(settings.COLOR_FINISH_CELL, 1);
			view.graphics.drawRect(genMaze.finish.x * settings.SIZE.x + lineWidth.x, genMaze.finish.y * settings.SIZE.y + lineWidth.y, settings.SIZE.x - lineWidth.x, settings.SIZE.y - lineWidth.y);
			view.graphics.endFill();
		}
	}
}