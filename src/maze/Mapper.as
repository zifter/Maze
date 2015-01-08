package maze {
	import flash.utils.Dictionary;
	import maze.matrix.eller.EllerGenerator;
	import maze.matrix.MatrixVisualizerBase;
	import maze.matrix.route.RouteGenerator;
	import maze.matrix.route.RouteVisualizer;
	import mx.collections.ArrayCollection;

	public class Mapper
	{
		private var mazeMap:Dictionary;

		public function Mapper()
		{
			mazeMap = new Dictionary();
			mazeMap["Route_Ivanov_A"] = create(new RouteGenerator, new RouteVisualizer);
			mazeMap["Ivanov_A"] = create(new RouteGenerator, new MatrixVisualizerBase);
			mazeMap["Eller"] = create(new EllerGenerator, new MatrixVisualizerBase);
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