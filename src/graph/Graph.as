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

        public function Graph() 
		{
            _edges = new Set();
            _vertices = new Set();
            _numVertices = _numEdges = 0;
        }
		
		public function addEdge(v1:Vertex, v2:Vertex, dir:uint):Edge
		{
			var edge:Edge = new Edge(v1, v2);
			v1.addEdge(edge, dir);
			v2.addEdge(edge, dir); // TODO:
			return edge
		}

        //public function addVertex(data:Object):Vertex 
		//{
            //var v:Vertex = _vertices.itemFor(data);
//
            //if (v == null) {
                //v = new Vertex(data);
                //_vertices.add(data, v);
                //_edges.add(v, new Set());
                //_numVertices++;
            //}
//
            //return v;
        //}
//
        //public function getVertex(data:Object):Vertex 
		//{
            //return _vertices.itemFor(data);
        //}
//
        //public function hasVertex(data:Object):Boolean 
		//{
            //return _vertices.hasKey(data);
        //}
//
        //public function hasEdge(from:Object, to:Object):Boolean 
		//{
            //if (!hasVertex(from) || !hasVertex(to))
                //return false;
            //return (_edges.itemFor(_vertices.itemFor(from)) as Set).has(_vertices.itemFor(to));
        //}
//
        //public function addEdge(from:Object, to:Object):void 
		//{
            //var v:Vertex, w:Vertex;
            //if (hasEdge(from, to))
                //return;
            //_numEdges += 1;
            //if ((v = getVertex(from)) == null)
                //v = addVertex(from);
            //if ((w = getVertex(to)) == null)
                //w = addVertex(to);
            //(_edges.itemFor(v) as Set).add(w);
            //(_edges.itemFor(w) as Set).add(v);
        //}
//
        //public function adjacentTo(value:*):ISet 
		//{
            //if (value is Object && hasVertex(value as Object)) {
                //return _edges.itemFor(getVertex(value as Object)) as Set;
            //}
//
            //if (value is Vertex && _edges.has(value as Vertex)) {
                //return _edges.itemFor(value as Vertex) as Set;
            //}
//
            //return EMPTY_SET;
        //}
//
        //public function getVertices():ISet 
		//{
            //var set:ISet = new Set();
            //for each (var v:Vertex in _vertices.toArray()) {
                //set.add(v);
            //}
            //return set;
        //}
//
        //public function numVertices():int 
		//{
            //return _numVertices;
        //}
//
        //public function numEdges():int {
            //return _numEdges;
        //}
//
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