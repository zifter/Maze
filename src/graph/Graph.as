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
		
		public function addEdge(v1:Vertex, v2:Vertex, dir:uint):Edge
		{
			var edge:Edge = new Edge(v1, v2);
			v1.addEdge(edge, dir);
			v2.addEdge(edge, dir); // TODO:
			return edge
		}
        //public function toString():String 
		//{
            //var s:String = "";
            //for each (var v:Vertex in _vertices.toArray()) {
                //s += v + ": ";
//
                //var set:ISet = _edges.itemFor(v) as Set;
                //for each (var w:Vertex in set.toArray()) {
                    //s += (w + " ");
                //}
                //s += "\n";
            //}
            //return s;
        //}
    }
}