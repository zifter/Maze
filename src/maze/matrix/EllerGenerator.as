package maze.matrix {
	import flash.geom.Point;
	import utils.Random;

	public class EllerGenerator extends MatrixGeneratorBase
	{
		private var _currentPoint : Point;
		private var _line : Array;

		override public function doInit():Boolean
		{
			initMatrix(MazeType.EMPTY);
			_currentPoint = new Point(0, 0);
			_line = new Array(width);
			for (var i:uint = 0; i < width; ++i)
			{
				_line[i] = i;
			}
			return true;
		}

		override public function isCompleted():Boolean
		{
			return _currentPoint.y == height && _currentPoint.x == width;
		}
		
		override public function doStep():Boolean
		{
			if (isCompleted())
			{
				return false;
			}
			if (_currentPoint.x == width)
			{
				_currentPoint.y += 1;
				_currentPoint.x = 0;
			}
			var newPoint:Point = _currentPoint.clone();
			newPoint.x += 1;
			setCell(_currentPoint, cellP(_currentPoint) | MazeType.CELL_VISITED);

			if (needCreateRightWall(_currentPoint, newPoint))
			{
				setWall(_currentPoint, MazeType.WALL_RIGHT);
			}

			_currentPoint = newPoint;
			
			return true;
		}
		
		public function needCreateRightWall(p1:Point, p2:Point):Boolean
		{
			return (Random.rand() * 5) > 3;
		}
	}
}