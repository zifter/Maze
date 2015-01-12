package graph {
	import adobe.utils.CustomActions;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.Map;
	
	public class Vertex extends DataHolder {
		private var _edges:IMap;

        public function Vertex(data:Object = null) 
		{
            data = data;
			_edges = new Map();
        }
		public function addEdge(edge:Edge, dir:uint):Boolean
		{
			if (_edges.hasKey(dir))
			{
				return false;
			}
			_edges.add(dir, edge)
			return true
		}
		public function get edges():Array	{	return _edges.toArray()	}
		public function neighbors():Array	
		{	
			var ns:Array = new Array();
			for each (var edge:* in _edges) 
			{ 
				if (edge.src == this)
					ns.push(edge.src);
				else 
					ns.push(edge.dst);
			} 
			return ns;
		}
		public function equals(v:Vertex):Boolean
		{
			return _edges == v._edges;
		}
		public function toString():String
		{
			var str:String = "[" + id + ": ";
			var it:IIterator = _edges.iterator();
			while(it.hasNext())
			{
				var a:* = it.next();
				str += a +", ";
			}
			str += "]";
			return str;
		}
    }
}