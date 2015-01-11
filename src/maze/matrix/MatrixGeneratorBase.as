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
		public function setCell(x:uint, y:uint, value:uint):void
		{
			matrix[x][y] = value;
		}
		public function setCellP(p:Point, value:uint):void
		{
			setCell(p.x, p.y, value)
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
		
		public function isValidP(pos:Point):Boolean
		{
			return isValid(pos.x, pos.y);
		}
		public function isValid(x:uint, y:uint):Boolean
		{
			return isValidX(x) && isValidY(y);
		}
		public function isValidX(x:uint):Boolean
		{
			return (x >= 0 && x < width);
		}
		public function isValidY(y:uint):Boolean
		{
			return (y >= 0 && y < height);
		}
		public function setWall(x:uint, y:uint, side: uint): Boolean
		{
			if (!isValid(x, y))
			{
				return false;
			}
			// set side for pos cell
			setCell(x, y, cell(x, y) | side);
			
			// set side for neighbor
			var neighbor:Point = MazeType.neighbor(x, y, side);
			if (isValidP(neighbor))
			{
				setCellP(neighbor, cellP(neighbor) | MazeType.reverse(side));
			}

			return true;
		}
		public function setWallP(pos: Point, side: uint): Boolean
		{
			return setWall(pos.x, pos.y, side);
		}

		public function breakWall(x:uint, y:uint, side: uint): Boolean
		{
			if (!isValid(x, y))
			{
				return false;
			}
			// set side for pos cell
			setCell(x, y, cell(x, y) & (MazeType.ALL ^ side));
			
			// set side for neighbor
			var neighbor:Point = MazeType.neighbor(x, y, side);
			if (isValidP(neighbor))
			{
				setCellP(neighbor, cellP(neighbor) & (MazeType.ALL ^ MazeType.reverse(side)));
			}

			return true;
		}
		public function breakWallP(pos: Point, side: uint): Boolean
		{
			return breakWall(pos.x, pos.y, side);
		}
		// override me
		public function getSpecialVisialCells(): Array
		{
			return new Array();
		}
	}
}