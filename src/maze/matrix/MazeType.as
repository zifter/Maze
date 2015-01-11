package maze.matrix {
	import flash.geom.Point;
	public class MazeType
	{
		public static const EMPTY 			: uint	= 0;
		public static const WALL_TOP		: uint	= 1 << 0;
		public static const WALL_RIGHT		: uint	= 1 << 1;
		public static const WALL_BOTTOM		: uint	= 1 << 2;
		public static const WALL_LEFT		: uint	= 1 << 3;
		public static const WALL_AROUND		: uint	= WALL_TOP | WALL_RIGHT | WALL_BOTTOM | WALL_LEFT;
		public static const CELL_VISITED	: uint	= 1 << 7;
		public static const ALL				: uint	= 0xFFFF;
		public static const WALLS_ARRAY		: Array = new Array(WALL_TOP, WALL_BOTTOM, WALL_LEFT, WALL_RIGHT);
		
		public static function reverse(direction:uint):uint
		{
			switch (direction)
			{
				case MazeType.WALL_TOP: return MazeType.WALL_BOTTOM;
				case MazeType.WALL_RIGHT: return MazeType.WALL_LEFT;
				case MazeType.WALL_BOTTOM: return MazeType.WALL_TOP;
				case MazeType.WALL_LEFT: return MazeType.WALL_RIGHT;
			}
			return 0;
		}
		public static function neighbor(x:uint, y:uint, dir:uint):Point
		{
			if (dir == MazeType.WALL_BOTTOM)
			{
				return new Point(x, y + 1);
			}
			else if (dir == MazeType.WALL_TOP)
			{
				return new Point(x, y - 1);
			}
			else if (dir == MazeType.WALL_LEFT)
			{
				return new Point(x-1, y);
			}
			else if (dir == MazeType.WALL_RIGHT)
			{
				return new Point(x+1, y);
			}			

			return new Point(x, y);
		}
		public static function neighborP(pos:Point, dir:uint):Point
		{
			return neighbor(pos.x, pos.y, dir);
		}
	}
}