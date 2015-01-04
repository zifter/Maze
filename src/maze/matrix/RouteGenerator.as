package maze.matrix {
	import flash.utils.setInterval;
	import flash.geom.Point;
	import utils.Random;

	public class RouteGenerator extends MatrixGeneratorBase
	{
		public var _activeRoute		: Array;
		private var _currentStep		: uint;
		
		override public function doInit():Boolean
		{
			initMatrix(MazeType.WALL_AROUND);

			_activeRoute = new Array(start);
			matrix[start.x][start.y] |= MazeType.CELL_VISITED;
			_currentStep = 0;

			return true;
		}
	
		override public function isCompleted():Boolean
		{
			return _activeRoute.length == 0;
		}
		
		override public function doStep():Boolean
		{
			// If now way (maze is completed)
			if (isCompleted())
			{
				return false;
			}
			
			var p:Point = _activeRoute[_currentStep];
			var wayExist:Boolean = canMove(p, MazeType.WALL_TOP) ||
				canMove(p, MazeType.WALL_RIGHT) ||
				canMove(p, MazeType.WALL_BOTTOM) || 
				canMove(p, MazeType.WALL_LEFT);

			if (wayExist)
			{
				var nextDir:uint = Math.floor(Random.rand() * 4);
				switch (nextDir)
				{
					case 0:
						if (canMove(p, MazeType.WALL_TOP)) { addRoute(p, MazeType.WALL_TOP); }
						break;
					case 1:
						if (canMove(p, MazeType.WALL_RIGHT)) { addRoute(p, MazeType.WALL_RIGHT); }
						break;
					case 2:
						if (canMove(p, MazeType.WALL_BOTTOM)) { addRoute(p, MazeType.WALL_BOTTOM);  }
						break;
					case 3:
						if (canMove(p, MazeType.WALL_LEFT)) { addRoute(p, MazeType.WALL_LEFT); }
						break;
				}				
				// Continue route
				_currentStep = _activeRoute.length - 1;
			}
			else
			{
				// Remove deadlock route point
				_activeRoute.splice(_currentStep, 1);
				
				// Start a new route
				_currentStep = 0;
				
				// Return false, if maze is completed
				return !isCompleted();
			}
			return true;
		}
		
		private function addRoute(pos: Point, direct: int): void
		{
			matrix[pos.x][pos.y] = cellP(pos) & (0xFFFF ^ direct);
			var indexX:uint = pos.x + (direct == MazeType.WALL_LEFT ? -1 : (direct == MazeType.WALL_RIGHT ? 1 : 0));
			var indexY:uint = pos.y + (direct == MazeType.WALL_TOP ? -1 : (direct == MazeType.WALL_BOTTOM ? 1 : 0))
			var newIndex:Point = new Point(indexX, indexY);

			matrix[newIndex.x][newIndex.y] = (cellP(newIndex) | MazeType.CELL_VISITED) & (0xFFFF ^ MazeType.reverse(direct));
			if (newIndex == finish) 
			{ 
				return; 
			}
			_activeRoute.push(newIndex);
		}		
	}
}