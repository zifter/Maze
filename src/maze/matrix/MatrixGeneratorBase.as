package maze.matrix {
	import maze.GeneratorBase;
	public class MatrixGeneratorBase extends GeneratorBase
	{
		private var _width		: uint;
		private var _height		: uint;
		private var _matrix		: Array;

		public function get width():uint
		{
			return _width;
		}
		public function set width(setValue:uint):void
		{
			_width = setValue;
		}
		
		public function get height():uint
		{
			return _height;
		}
		public function set height(setValue:uint):void
		{
			_height = setValue;
		}
		
		public function get matrix():Array
		{
			return _matrix;
		}
		public function set matrix(setValue:Array):void
		{
			_matrix = setValue;
		}
	}
}