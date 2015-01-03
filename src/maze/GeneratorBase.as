package maze {
	public class GeneratorBase
	{
		// random seed
		private var _seed:uint;
		
		public function get seed():uint
		{
			return _seed;
		}

		public function set seed(setValue:uint):void
		{
			_seed = setValue;
		}
		
		// override me
		public function isCompleted():Boolean
		{
			return true;
		}
	}
}