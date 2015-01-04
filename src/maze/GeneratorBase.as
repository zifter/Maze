package maze {
	import utils.Random;

	public class GeneratorBase
	{
		// random seed
		private var _seed:uint = 0;

		public function get seed():uint	{ return _seed; }
		public function set seed(setValue:uint):void { _seed = setValue; }
		
		public function buildAll():void
		{
			while(doStep()) {}
		}
		
		public function doStepTimes(number:uint):Boolean
		{
			while (--number && doStep()) { }
			
			return doStep();
		}
		
		public final function init():Boolean
		{
			Random.randomize(seed);

			return doInit();
		}

		public function doInit():Boolean
		{
			return true;
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