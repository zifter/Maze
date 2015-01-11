package maze {
	import flash.geom.Point;
	public class VisualSettings
	{
		public var COLOR_WALL			:uint = 0x000000;
		public var COLOR_SPECIAL		:uint = 0xFAB6B6;
		public var COLOR_NOT_VISITED	:uint = 0xB0B5BF;
		public var COLOR_START_CELL		:uint = 0x55FF11;
		public var COLOR_FINISH_CELL	:uint = 0xFF6611;
		
		public var LINE_THICKNESS		:uint = 2;
		public var SPEED				:uint = 1;
		public var SIZE					:Point = new Point(20, 20);
		public var ANIMATED				:Boolean = false;
	}
}