package maze.matrix.eller {
	import flash.geom.Point;
	import utils.Random;
	import maze.matrix.MazeType;
	import maze.matrix.MatrixGeneratorBase;
	import utils.SetBase;

	public class EllerGenerator extends MatrixGeneratorBase
	{
		private var _currentY : uint;
		private var _currentX : uint;
		private var _line : Array;
		private var _createBottomWallMode:Boolean;
		private var _visitedSet : SetBase;

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
			_visitedSet = new SetBase();
			return true;
		}

		override public function isCompleted():Boolean
		{
			return _currentY == height && _currentX == width;
		}
		
		override public function doStep():Boolean
		{
			if (_currentX == width)
			{
				_currentX = 0;
				if (_createBottomWallMode)
				{
					// don't reset cell's sets at the last line
					if (_currentY != height-1)
					{
						resetLine();
					}

					_currentY++;
				}
				_createBottomWallMode = !_createBottomWallMode;
			}
			
			if (_currentY == height)
			{
				createLastLine();
			}
			else
			{
				if (_createBottomWallMode)
				{
					createBottomWall();
				}
				else
				{
					createRightWall();
				}	
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
					//move all cell from set in one set with current cell
					merge(_line[newX], _line[_currentX])
				}
			}

			_currentX = newX;
		}
		
		public function createBottomWall():void
		{
			while (isValidX(_currentX) && _visitedSet.contains(_line[_currentX]))
			{
				_currentX++;
			}
			if (!isValidX(_currentX))
			{
				return;
			}

			_visitedSet.add(_line[_currentX])

			var indexes:Array = new Array();
			for (var i:uint = _currentX; i <= width; ++i)
			{
				if (_line[_currentX] == _line[i])
				{
					indexes.push(i);
				}
			}
			
			var maximumWallNumber:uint = indexes.length - 1;
			while (maximumWallNumber > 0)
			{
				var index:uint = Random.randNumber(indexes.length);
				setWall(indexes[index], _currentY, MazeType.WALL_BOTTOM);
				maximumWallNumber--;
			}
		}

		public function createLastLine():void
		{
			while (isValidX(_currentX) && _line[_currentX] == _line[0])
			{
				_currentX++;
			}
			if (!isValidX(_currentX))
			{
				return;
			}
			var prevX:uint = _currentX - 1;
			breakWall(prevX, _currentY - 1, MazeType.WALL_RIGHT);
			
			merge(_line[_currentX], _line[0])
		}
		
		public function resetLine():void
		{
			_visitedSet.removeAll();
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
			return _line[px1] == _line[px2] || Random.nextBoolean();
		}
		
		public function merge(srcSet:uint, destSet:uint):void
		{
			for (var i:uint = 0; i < width; ++i)
			{
				if (_line[i] == srcSet)
				{
					_line[i] = destSet;		
				}
			}
		}
	}
}