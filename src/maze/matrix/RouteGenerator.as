package maze.matrix {
	import flash.utils.setInterval;
	import flash.geom.Point;
	import utils.Random;

	public class RouteGenerator extends MatrixGeneratorBase
	{
		public var _activeRoute		: Array = new Array();
		private var _currentStep	: uint = 0;
		
		override public function doInit():Boolean
		{
			initMatrix(MazeType.WALL_AROUND);

			_activeRoute.push(start);
			
			matrix[start.x][start.y] |= MazeType.CELL_VISITED;

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
			
			var availabeWay:Array = new Array();
			if (canMove(p, MazeType.WALL_TOP)) 		{ availabeWay.push(MazeType.WALL_TOP); }
			if (canMove(p, MazeType.WALL_RIGHT))	{ availabeWay.push(MazeType.WALL_RIGHT); }
			if (canMove(p, MazeType.WALL_BOTTOM)) 	{ availabeWay.push(MazeType.WALL_BOTTOM); }
			if (canMove(p, MazeType.WALL_LEFT)) 	{ availabeWay.push(MazeType.WALL_LEFT); }

			if (availabeWay.length != 0)
			{
				var nextDirIndex:uint = 0;
				if (availabeWay.length > 1)
				{
					nextDirIndex = Math.floor(Random.rand() * availabeWay.length);
				}
				
				addRoute(p, availabeWay[nextDirIndex]);
		
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