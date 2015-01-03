package maze.matrix {
	// base
	import maze.VisualizerBase;

	// ui
	import mx.core.UIComponent;

	public class MatrixVisualizerBase extends VisualizerBase
	{
		public function MatrixVisualizerBase()
		{
			super()
		}

		override protected function doDraw():void
		{
			var lineThick:Number = thickness;
			var startX:Number = lineThick / 2;
			var startY:Number = lineThick / 2;
			var cellW:int = size;
			var cellH:int = size;
			var cData:int;
			var cx:int = 0;
			var cy:int = 0;
			var i:int = 0;
			var p:MazeIndex;
			// TODO:
			var genMaze:MazeMatrix = generator as MazeMatrix;
			
			view.setStyle('borderWeight', lineThick);

			view.graphics.clear();
			view.width  = cellW * genMaze.width  + lineThick;
			view.height = cellH * genMaze.height + lineThick;
			
			with (view.graphics)
			{
				for (cx = 0; cx < genMaze.width; ++cx)
				{
					for (cy = 0; cy < genMaze.height; ++cy)
					{
						cData = genMaze.getCell(cx, cy);
						lineStyle(lineThick, (cData & MazeMatrix.CELL_VISITED) ? 0x000000 : 0xCCCCCC);
						if ((cy > 0) && (cData & MazeMatrix.WALL_TOP)) 
						{
							moveTo(startX + cx * cellW, startY + cy * cellH);
							lineTo(startX + cx * cellW + cellW, startY + cy * cellH);
						}

						if ((cx > 0) && (cData & MazeMatrix.WALL_LEFT)) 
						{
							moveTo(startX + cx * cellW, startY + cy * cellH);
							lineTo(startX + cx * cellW, startY + cy * cellH + cellH);
						}
					}
				}
				
				// Display routre stack
				for (i = 0; i < genMaze.activeRoute.length; ++i)
				{
					p = genMaze.activeRoute[i];
					lineStyle();
					beginFill(0xFF9999, 1);
					drawRect(startX + p.x * cellW + cellW/4, startY + p.y * cellH + cellH/4, cellW/2, cellH/2);
					endFill();
				}

				// Draw start position
				lineStyle();
				beginFill(0x55FF11, 1);
				drawCircle(startX + genMaze.startX * cellW + cellW / 2, startY + genMaze.startY * cellH + cellH / 2, cellW / 2.5);
				endFill();

				// Draw finish position
				lineStyle();
				beginFill(0xFF6611, 1);
				drawRect(startX + genMaze.finishX * cellW + 2, startY + genMaze.finishY * cellH + 2, cellW - 4, cellH - 4);
				endFill();
			}
		}
	}
}