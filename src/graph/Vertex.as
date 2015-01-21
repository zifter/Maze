package graph {
	import adobe.utils.CustomActions;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.Map;
	
	public class Vertex extends DataHolder {
		private var _edges:IMap;

        public function Vertex(join:JoinBase, data:Object = null)
		{
            data = data;
			// create structure of node
			_edges = new Map();
			for each (var dir:* in join.all())
			{
				_edges.add(null, dir);
			}
			
        }
		// set new edge for 
		public function setEdge(edge:Edge, dir:*):Boolean
		{
			if (!_edges.hasKey(dir))
			{
				return false;
			}
			_edges.replaceFor(dir, edge)
			return true
		}
		// return all edges
		public function get edges():Array	
		{	
			return _edges.toArray()	
		}
		// return all neighbors
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
		public function edge(dir:*):Edge
		{	
			return _edges.itemFor(dir);
		}
		public function neighbor(dir:*):Vertex
		{
			var edge:Edge = edge(dir);
			if (edge.src == this)
				return edge.src;
			else
				return edge.dst;
		}
		public function equals(vert:Vertex):Boolean
		{
			return this == vert;
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