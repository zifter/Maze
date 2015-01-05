package maze.matrix {
	import flash.geom.Point;
	import utils.Random;

	public class EllerGenerator extends MatrixGeneratorBase
	{
		private var _currentPoint : Point;

		override public function doInit():Boolean
		{
			initMatrix(MazeType.WALL_AROUND);
			_currentPoint = new Point(0, 0);
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

			var cData:uint = cellP(_currentPoint);
			cData = 1 << (Random.rand() * 4);
			matrix[_currentPoint.x][_currentPoint.y] = cData | MazeType.CELL_VISITED;
			
			_currentPoint.x += 1;
			
			return true;
		}
	}
}