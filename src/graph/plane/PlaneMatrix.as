package graph.plane {
	import graph.Graph;
	import graph.join.Join4;

	public interface PlaneMatrix
	{
		static const join : Join4;
		public var width:uint = 10;
		public var height:uint = 10;
		
		function Create(graph:Graph):Boolean
		{
			var newMatrix:Array = new Array(width);

			for (var i:uint = 0; i < width; ++i)
			{
				newMatrix[i] = new Array(height);
				for (var j:uint = 0; j < height; ++j)
				{
					newMatrix[i][j] = addVertex();
				}
			}
			// set vertical wall
			var dirBottom:uint = Join4.WALL_BOTTOM;
			var dirRight:uint = Join4.WALL_RIGHT;
			for (var i:uint = 0; i < width; ++i)
			{
				for (var j:uint = 0; j < height; ++j)
				{
					var v0:Vertex = vert[i][j];
					var vHorizontalRight:Vertex = vert[i][j + 1]; 
					var vVerticalBottom:Vertex = vert[i+1][j]; 
					
					addEdge(v0, vHorizontalRight, dirRight);
					addEdge(v0, vVerticalBottom, dirBottom);
				}
			};
		}
	}
}