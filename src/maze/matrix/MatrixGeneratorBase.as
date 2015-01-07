package maze.matrix {
	import adobe.utils.CustomActions;
	import maze.GeneratorBase;
	
	import flash.geom.Point;
	public class MatrixGeneratorBase extends GeneratorBase
	{
		private var _width	: uint;
		private var _height	: uint;
		private var _matrix	: Array;
		private var _start	: Point;
		private var _finish	: Point;
		
		public function get width():uint {return _width; }
		public function set width(setValue:uint):void { _width = setValue; }
		
		public function get height():uint { return _height; }
		public function set height(setValue:uint):void { _height = setValue; }
		
		public function get matrix():Array { return _matrix; }
		public function set matrix(setValue:Array):void { _matrix = setValue; }

		public function get start():Point { return _start; }
		public function set start(setValue:Point):void { _start = setValue; }
		
		public function get finish():Point { return _finish; }
		public function set finish(setValue:Point):void { _finish = setValue; }

		public function cell(x: uint, y:uint):uint
		{
			return matrix[x][y];
		}
		public function cellP(p:Point):uint
		{
			return matrix[p.x][p.y];
		}
		public function setCell(p:Point, value:uint):void
		{
			matrix[p.x][p.y] = value;
		}
				
		public function initMatrix(cellValue:uint):void
		{
			matrix = createMatrix(cellValue);
		}
		
		protected function createMatrix(cellValue:uint):Array
		{
			var newMatrix:Array = new Array(width);

			for (var i:uint = 0; i < width; ++i)
			{
				newMatrix[i] = new Array(height);
				for (var j:uint = 0; j < height; ++j)
				{
					newMatrix[i][j] = cellValue;
				}
			}
			return newMatrix
		}
		
		public function canMove(pos: Point, direct: uint): Boolean
		{
			switch (direct)
			{
				case (MazeType.WALL_TOP):
					return (pos.y > 0) && ((matrix[pos.x][pos.y - 1] & MazeType.CELL_VISITED) == 0);
				case (MazeType.WALL_RIGHT):
					return (pos.x < width - 1) && ((matrix[pos.x + 1][pos.y] & MazeType.CELL_VISITED) == 0);
				case (MazeType.WALL_BOTTOM):
					return (pos.y < height - 1) && ((matrix[pos.x][pos.y + 1] & MazeType.CELL_VISITED) == 0);
				case (MazeType.WALL_LEFT):
					return (pos.x > 0) && ((matrix[pos.x - 1][pos.y] & MazeType.CELL_VISITED) == 0);
			}
			return false;
		}
		
		public function isValid(pos:Point):Boolean
		{
			return (pos.x >= 0 && pos.x < width) && (pos.y >= 0 && pos.y < height);
		}
		
		public function setWall(pos: Point, side: uint): Boolean
		{
			if (!isValid(pos))
			{
				return false;
			}
			// set side for pos cell
			setCell(pos, cellP(pos) | side);
			
			// set side for neighbor
			var neighbor:Point;
			if (side & MazeType.WALL_BOTTOM)
			{
				neighbor = new Point(pos.x, pos.y + 1);
				if (isValid(neighbor))
				{
					setCell(neighbor, cellP(neighbor) | MazeType.WALL_TOP);
				}
			}
			if (side & MazeType.WALL_TOP)
			{
				neighbor = new Point(pos.x, pos.y - 1);
				if (isValid(neighbor))
				{
					setCell(neighbor, cellP(neighbor) | MazeType.WALL_BOTTOM);
				}
			}
			if (side & MazeType.WALL_LEFT)
			{
				neighbor = new Point(pos.x-1, pos.y);
				if (isValid(neighbor))
				{
					setCell(neighbor, cellP(neighbor) | MazeType.WALL_RIGHT);
				}
			}
			if (side & MazeType.WALL_RIGHT)
			{
				neighbor = new Point(pos.x+1, pos.y);
				if (isValid(neighbor))
				{
					setCell(neighbor, cellP(neighbor) | MazeType.WALL_LEFT);
				}
			}

			return true;
		}
	}
}