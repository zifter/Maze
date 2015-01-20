package graph {
	import flash.geom.Point;
	import utils.Random;

	public interface JoinBase
	{
		// override me
		function reverse(direction:*):*;
		function all():Array;
	}
}