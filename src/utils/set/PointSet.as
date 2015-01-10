package utils.set
{
	import utils.SetBase;
	public class PointSet extends SetBase
	{
		public function PointSet()
		{
			var f:Function = function(a:*, b:*):Boolean { return a.equals(b) };
			super(f)
		}
	}
}