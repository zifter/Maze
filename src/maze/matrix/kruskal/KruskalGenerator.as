package maze.matrix.kruskal {
	import flash.geom.Point;
	import utils.Random;
	import maze.matrix.MazeType;
	import maze.matrix.MatrixGeneratorBase;

	public class KruskalGenerator extends MatrixGeneratorBase
	{
		override public function doInit():Boolean
		{
			initMatrix(MazeType.WALL_AROUND);
			return true;
		}

		override public function isCompleted():Boolean
		{
			return true;
		}
		
		override public function doStep():Boolean
		{
			return false;
		}
	}
}