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
		
		public function buildAll():void
		{
			while(doStep()) {}
		}
		
		public function doStepTimes(number:uint):Boolean
		{
			while (--number && doStep()) { }
			
			return doStep();
		}
		
		// override me
		public function isCompleted():Boolean
		{
			return true;
		}
		
		// override me
		public function doStep():Boolean
		{
			return false;
		}
	}
}