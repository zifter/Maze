package graph {
    public class Test
	{
		public function createEdges():void
		{
			var gr:Graph = new Graph();

			var v1:Vertex = new Vertex();
			var v2:Vertex = new Vertex();
			var v3:Vertex = new Vertex();
			var v4:Vertex = new Vertex();
			var v5:Vertex = new Vertex();
			var e1:Edge = new Edge(v1, v2);
			var e2:Edge = new Edge(v2, v3);
			var e3:Edge = new Edge(v3, v4);
			var e4:Edge = new Edge(v4, v5);
			var e5:Edge = new Edge(v5, v1);
		
			trace(v1)
			trace(v2)
			trace(v3)
			trace(v4)
			trace(v5)
			trace(e1)
			trace(e2)
			trace(e3)
			trace(e4)
			trace(e5)
		}
    }
}