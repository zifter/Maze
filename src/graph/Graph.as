package graph {
	import adobe.utils.CustomActions;
    import org.as3commons.collections.Map;
    import org.as3commons.collections.Set;
    import org.as3commons.collections.framework.IMap;
    import org.as3commons.collections.framework.ISet;

    public class Graph 
	{
        public var _edges:ISet;
        public var _vertices:ISet;

        private static const EMPTY_SET:ISet = new Set();

        private var _numVertices:int;
        private var _numEdges:int;
		
		private var join:JoinBase;

        public function Graph(_join:JoinBase) 
		{
            _edges = new Set();
            _vertices = new Set();
            _numVertices = _numEdges = 0;
			join = _join;
        }
		public function Create():void
		{

		}
		public function addVertex():Vertex
		{
			var vert:Vertex = new Vertex(join);
			_vertices.add(vert);
			return vert;
		}
		public function addEdge(v1:Vertex, v2:Vertex, dir:*):Edge
		{
			var edge:Edge = new Edge(v1, v2);
			v1.setEdge(edge, dir);
			v2.setEdge(edge, join.reverse(dir));
			_edges.add(edge);
			return edge
		}
        public function toString():String 
		{
            var s:String = "Vertex:";
            for each (var v:Vertex in _vertices.toArray()) 
			{
                s += v + "\n";
            }
			s += "Edges:";
            for each (var e:Edge in _edges.toArray()) 
			{
                s += e + "\n";
            }

            return s;
        }
    }
}