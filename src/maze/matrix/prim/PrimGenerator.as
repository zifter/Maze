package maze.matrix.prim {
	import flash.geom.Point;
	import utils.Random;
	import maze.matrix.MazeType;
	import maze.matrix.MatrixGeneratorBase;
	import utils.set.PointSet;

	public class PrimGenerator extends MatrixGeneratorBase
	{
		private var _In: PointSet;
		private var _Out: PointSet;
		private var _Frontier: PointSet;
		
		override public function doInit():Boolean
		{
			initMatrix(MazeType.WALL_AROUND);
			_In = new PointSet();
			_Out = new PointSet();
			_Frontier = new PointSet();

			for (var i:uint = 0; i < width; ++i)
			{
				for (var j:uint = 0; j < height; ++j)
				{
					_Out.add(new Point(i, j));
				}
			}
			return true;
		}

		override public function isCompleted():Boolean
		{
			return _Frontier.isEmpty && _Out.isEmpty;
		}
		
		override public function doStep():Boolean
		{
			if (_In.isEmpty)
			{
				addToIn(_Out.randomAndRemove())
			}
			
			var obj:Point = _Frontier.randomAndRemove();
			var direction:uint = directionToPointFromIn(obj)
			addToIn(obj)
			breakWallP(obj, direction)

			return true;
		}
		private function addToIn(point:Point):void
		{
			setCellP(point, cellP(point) | MazeType.CELL_VISITED);
			_In.add(point)
			for (var i:uint = 0; i < MazeType.WALLS_ARRAY.length; ++i)
			{
				var neighbor:Point = MazeType.neighborP(point, MazeType.WALLS_ARRAY[i])
				if (isValidP(neighbor) && _Out.remove(neighbor))
				{
					_Frontier.add(neighbor);
				}
			}
		}
		private function directionToPointFromIn(point:Point):uint
		{
			var neighbors:Array = new Array()
			for (var i:uint = 0; i < MazeType.WALLS_ARRAY.length; ++i)
			{
				var neighbor:Point = MazeType.neighborP(point, MazeType.WALLS_ARRAY[i])
				if (isValidP(neighbor) && _In.contains(neighbor))
				{
					neighbors.push(MazeType.WALLS_ARRAY[i])
				}
			}
			return neighbors[Random.randNumber(neighbors.length)]
		}
		
		public function getAllFrontier():Array
		{
			return _Frontier.getAsArray();
		}
	}
}