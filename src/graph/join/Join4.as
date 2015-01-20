package graph.join {
	import flash.geom.Point;
	import utils.Random;
	import graph.JoinBase;

	public class Join4 implements JoinBase
	{
		public static const WALL_TOP 	: uint = 1 << 0;
		public static const WALL_RIGHT 	: uint = 1 << 1;
		public static const WALL_BOTTOM : uint = 1 << 2;
		public static const WALL_LEFT 	: uint = 1 << 3;
		public static const WALLS_ARRAY	: Array = new Array(WALL_TOP, WALL_BOTTOM, WALL_LEFT, WALL_RIGHT);

		public function reverse(direction:*):*
		{
			switch (direction)
			{
				case WALL_TOP	: return WALL_BOTTOM;
				case WALL_RIGHT	: return WALL_LEFT;
				case WALL_BOTTOM: return WALL_TOP;
				case WALL_LEFT	: return WALL_RIGHT;
			}
			return null;
		}
		public function all():Array
		{
			return WALLS_ARRAY;
		}
	}
}