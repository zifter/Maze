package graph
{
	// binary edge
    public class Edge extends DataHolder
	{
        private var _src:Vertex;
        private var _dst:Vertex;

		public function get src():Vertex { return _src; }
		public function set src(setValue:Vertex):void { _src = setValue; }

		public function get dst():Vertex { return _dst; }
		public function set dst(setValue:Vertex):void { _dst = setValue; }
		
        public function Edge(srcVertex:Vertex, dstVertex:Vertex, dataValue:*=null)
        {
			src = srcVertex;
			dst = dstVertex;
			data = dataValue;
        }
		
		public function equals(edge:Edge):Boolean
		{
			return src.equals(edge.src) && dst.equals(edge.dst);
		}
		public function toString():String
		{
			var str:String = "[" + id + ": ";
			str += _src.id + "->" + _dst.id;
			str += " ]";
			return str;
		}
    }
}
