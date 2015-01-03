package maze.matrix {
	import flash.utils.setInterval;

	public class MazeMatrix extends MatrixGeneratorBase
	{
		private var _startX		: int;
		private var _startY		: int;
		private var _finishX		: int;
		private var _finishY		: int;
		public var activeRoute		: Array;
		private var currentStep		: int;
		
		private const WALL_AROUND	: int	= 15;
		public static const WALL_TOP		: int	= 1;
		public static const WALL_RIGHT		: int	= 2;
		public static const WALL_BOTTOM	: int	= 4;
		public static const WALL_LEFT		: int	= 8;
		public static const CELL_VISITED	: int	= 128;

		public function MazeMatrix(w: int, h: int, startX: int=0, startY: int=0, autogenerate:Boolean = true)
		{
			width	= w;
			height	= h;
			_startX = startX;
			_startY = startY;
			_finishX	= w - 1;
			_finishY	= h - 1;
			matrix	= new Array(w);

			for (var i:int = 0; i < w; ++i)
			{
				matrix[i] = new Array(h);
				(matrix[i] as Array).forEach(fillMatrix);
			}

			activeRoute = new Array(new MazeIndex(startX, startY));
			matrix[startX][startY] |= CELL_VISITED;
			currentStep = 0;

			if (autogenerate) 
			{
				buildAll();
			}
		}
		
		public function get startX():int
		{
			return _startX;
		}
		
		public function get startY():int
		{
			return _startY;
		}
		
		public function get finishX():int
		{
			return _finishX;
		}
		
		public function get finishY():int
		{
			return _finishY;
		}
		
		public function getCell(x: int, y:int):int
		{
			return matrix[x][y];
		}
		
		override public function isCompleted():Boolean
		{
			return activeRoute.length == 0;
		}
		
		
		// Initialize maze array
		private function fillMatrix(element:*, index:int, arr:Array):void
		{
			arr[index] = WALL_AROUND;
		}
		
		override public function doStep():Boolean
		{
			// If now way (maze is completed)
			if (isCompleted())
			{
				return false;
			}
			
			var p:MazeIndex = activeRoute[currentStep];
			var wayExist:Boolean = canMove(p, WALL_TOP) || canMove(p, WALL_RIGHT) ||
				canMove(p, WALL_BOTTOM) || canMove(p, WALL_LEFT);
			if (wayExist)
			{
				switch (Math.floor(Math.random() * 4))
				{
					case 0:
						if (canMove(p, WALL_TOP)) { addRoute(p, WALL_TOP); }
						break;
					case 1:
						if (canMove(p, WALL_RIGHT)) { addRoute(p, WALL_RIGHT); }
						break;
					case 2:
						if (canMove(p, WALL_BOTTOM)) { addRoute(p, WALL_BOTTOM);  }
						break;
					case 3:
						if (canMove(p, WALL_LEFT)) { addRoute(p, WALL_LEFT); }
						break;
				}				
				// Continue route
				currentStep = activeRoute.length - 1;
			}
			else
			{
				// Remove deadlock route point
				activeRoute.splice(currentStep, 1);
				
				// Start a new route
				currentStep = 0;
				
				// Return false, if maze is completed
				return !isCompleted();
			}
			return true;
		}
		
		
		private function addRoute(pos: MazeIndex, direct: int): void
		{
			matrix[pos.x][pos.y] = matrix[pos.x][pos.y] & (0xFFFF ^ direct);
			var newIndex:MazeIndex = new MazeIndex(
				pos.x + (direct == WALL_LEFT ? -1 : (direct == WALL_RIGHT ? 1 : 0)),
				pos.y + (direct == WALL_TOP ? -1 : (direct == WALL_BOTTOM ? 1 : 0))
			);
			matrix[newIndex.x][newIndex.y] = (matrix[newIndex.x][newIndex.y] | CELL_VISITED) & (0xFFFF ^ backDirect(direct));
			if ((newIndex.x == _finishX) && (newIndex.y == _finishY)) 
			{ 
				return; 
			}
			activeRoute.push(newIndex);
		}
		
		
		// Returns inverse direction
		private function backDirect(direct: int):int
		{
			switch (direct)
			{
				case WALL_TOP: return WALL_BOTTOM;
				case WALL_RIGHT: return WALL_LEFT;
				case WALL_BOTTOM: return WALL_TOP;
				case WALL_LEFT: return WALL_RIGHT;
			}
			return 0;
		}
		
		
		// Check a movement
		private function canMove(pos: MazeIndex, direct: int): Boolean
		{
			switch (direct)
			{
				case (WALL_TOP):
					return (pos.y > 0) && ((matrix[pos.x][pos.y - 1] & CELL_VISITED) == 0);
				case (WALL_RIGHT):
					return (pos.x < width - 1) && ((matrix[pos.x + 1][pos.y] & CELL_VISITED) == 0);
				case (WALL_BOTTOM):
					return (pos.y < height - 1) && ((matrix[pos.x][pos.y + 1] & CELL_VISITED) == 0);
				case (WALL_LEFT):
					return (pos.x > 0) && ((matrix[pos.x - 1][pos.y] & CELL_VISITED) == 0);
			}
			return false;
		}
		
	}
}