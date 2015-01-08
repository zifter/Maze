package maze.matrix {
	import flash.geom.Point;
	import utils.Random;

	public class EllerGenerator extends MatrixGeneratorBase
	{
		private var _currentY : uint;
		private var _currentX : uint;
		private var _line : Array;
		private var _createBottomWallMode:Boolean;

		override public function doInit():Boolean
		{
			initMatrix(MazeType.EMPTY);
			_currentX = 0;
			_currentY = 0;
			_line = new Array(width);
			for (var i:uint = 0; i < width; ++i)
			{
				_line[i] = i;
			}
			_createBottomWallMode = false;
			return true;
		}

		override public function isCompleted():Boolean
		{
			return _currentY == height && _currentX == width;
		}
		
		override public function doStep():Boolean
		{
			if (isCompleted())
			{
				return false;
			}
			if (_currentX == width)
			{
				_currentX = 0;
				if (_createBottomWallMode)
				{
					resetLine();
					_currentY ++;
				}
				_createBottomWallMode = !_createBottomWallMode;
			}
			
			if (_createBottomWallMode)
			{
				createBottomWall();
			}
			else
			{
				createRightWall();
			}

			return true;
		}
		
		public function createRightWall():void
		{
			setCell(_currentX, _currentY, cell(_currentX, _currentY) | MazeType.CELL_VISITED);

			var newX:uint = _currentX+1;

			if (isValidX(newX))
			{
				if (needCreateRightWall(_currentX, newX))
				{
					setWall(_currentX, _currentY, MazeType.WALL_RIGHT);
				}
				else
				{
					//move this cell in one set
					_line[newX] =  _line[_currentX];
				}
			}

			_currentX = newX;
		}
		
		public function createBottomWall():void
		{
			var rightX:uint = _currentX;
			for (var side:uint = rightX+1; side < width; ++side)
			{
				if (_line[_currentX] == _line[side])
				{
					rightX = side;
				}
				else
				{
					break;
				}
			}
			var maximumWallNumber:uint = rightX - _currentX;
			for (var i:uint = _currentX; i <= rightX; ++i)
			{
				if (maximumWallNumber > 0 && (Random.rand() * 5) > 3)
				{
					setWall(i, _currentY, MazeType.WALL_BOTTOM);
					maximumWallNumber--;
				}
			}

			_currentX = rightX+1;
		}
		
		public function resetLine():void
		{
			for (var i:uint = 0; i < width; ++i)
			{
				if (cell(i, _currentY) & MazeType.WALL_BOTTOM)
				{
					_line[i] = (_currentY+1)*width+i; // now, cell belongs unique set
				}
			}
		}

		public function needCreateRightWall(px1:uint, px2:uint):Boolean
		{
			return _line[px1] == _line[px2] || (Random.rand() * 5) > 3 ;
		}
	}
}