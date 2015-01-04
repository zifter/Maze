package utils
{
	import flash.utils.getTimer;
	
	public class Random 
	{
		private static const MAX_RATIO:Number = 1 / uint.MAX_VALUE;
		private static var r:uint;
		// default random from Math
		private static const defaultRandom:Function = 
			function ():Number 	{ return Math.random();	};
		// fixed random with seed
		private static const seedRandom:Function = 
			function ():Number 	{ return randWithSeed();	};
		
		private static var randFunc:Function = defaultRandom;

		public static function randomize(seed:uint = 0):void
		{
			r = seed || getTimer();

			if (seed == 0)
			{
				randFunc = defaultRandom;
			}
			else
			{
				randFunc = seedRandom;
			}
		}
		
		public static function randWithSeed():Number
		{
			r ^= (r << 21);
			r ^= (r >>> 35);
			r ^= (r << 4);
			return (r * MAX_RATIO);
		}
		
		//  returns a random Number from 0 – 1
		// if seed equal 0, then using Math.random()
		public static function rand():Number
		{
			return randFunc();
		}
	}
}