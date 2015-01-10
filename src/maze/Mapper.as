package maze {
	import flash.utils.Dictionary;
	import maze.matrix.prim.PrimVisualizer;
	import mx.collections.ArrayCollection;
	import maze.matrix.MatrixVisualizerBase;
	
	import maze.matrix.eller.EllerGenerator;
	
	import maze.matrix.prim.PrimGenerator;

	import maze.matrix.route.RouteGenerator;
	import maze.matrix.route.RouteVisualizer;

	public class Mapper
	{
		private var mazeMap:Dictionary;

		public function Mapper()
		{
			mazeMap = new Dictionary();
			mazeMap["Route_Ivanov_A"] = create(new RouteGenerator, new RouteVisualizer);
			mazeMap["Ivanov_A"] = create(new RouteGenerator, new MatrixVisualizerBase);
			mazeMap["Eller's algorithm"] = create(new EllerGenerator, new MatrixVisualizerBase);
			mazeMap["Prim's algorithm"] = create(new PrimGenerator, new PrimVisualizer);
		}

		public final function map(name:String):VisualizerBase
		{
			return mazeMap[name];
		}
		
		public final function availableMazes():ArrayCollection
		{
			var names:Array = new Array()
			for (var key:* in mazeMap) 
			{
				names.push(key);
			}
			return new ArrayCollection(names);
		}
		
		private final function create(gen:GeneratorBase, vis:VisualizerBase):VisualizerBase
		{
			vis.generator = gen;
			return vis;
		}
	}
}