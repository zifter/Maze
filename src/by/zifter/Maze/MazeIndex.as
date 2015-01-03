package by.zifter.Maze {
	public class MazeIndex
	{
		public var x	: int;
		public var y	: int;
		
		public function MazeIndex(x: int, y: int)
		{
			this.x = x;
			this.y = y;
		}
		
		
		public function toString():String
		{
			return '[' + x + ', ' + y + ']';
		}
	}
}