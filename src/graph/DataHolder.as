package graph
{
	// binary edge
    public class DataHolder extends Object
	{
        private var _data:*;
		private var _id:uint;
		private static var g_id:uint = 0;
		
		public function DataHolder()
		{
			_id = ++g_id;
		}
		
		public function get data():Vertex { return _data; }
		public function set data(setValue:*):void { _data = setValue; }
		
		public function get id():uint { return _id; }
    }
}
