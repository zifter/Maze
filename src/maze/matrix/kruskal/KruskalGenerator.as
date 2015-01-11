package maze.matrix.kruskal {
	import flash.geom.Point;
	import utils.Random;
	import maze.matrix.MazeType;
	import maze.matrix.MatrixGeneratorBase;
	import utils.set.PointSet;
	import utils.SetBase;

	public class KruskalGenerator extends MatrixGeneratorBase
	{
		private var _ids:Array;
		private var _freeEdge:SetBase;
		override public function doInit():Boolean
		{
			initMatrix(MazeType.WALL_AROUND);
			var f:Function = function (a:Array, b:Array):Boolean
			{
				return a[0] == b[0] && a[1] == b[1];
			}
			_freeEdge = new SetBase(f);
			_ids = createMatrix(0);
			for (var i:uint = 0; i < width; ++i)
			{
				for (var j:uint = 0; j < height; ++j)
				{
					_ids[i][j] = i * width + j;
					_freeEdge.add([new Point(i, j), MazeType.WALL_RIGHT])
					_freeEdge.add([new Point(i, j), MazeType.WALL_TOP])
				}
			}
			
			return true;
		}

		override public function isCompleted():Boolean
		{
			return _freeEdge.isEmpty;
		}
		
		override public function doStep():Boolean
		{
			var tryAgain:Boolean = true;
			while (tryAgain && !isCompleted())
			{
				var obj:Array = _freeEdge.randomAndRemove();
				var neighbor:Point = MazeType.neighborP(obj[0], obj[1]);
				if(!isValidP(neighbor))
				{
					continue;
				}

				if (id(obj[0]) != id(neighbor))
				{
					setCellP(obj[0], cellP(obj[0]) | MazeType.CELL_VISITED);
					setCellP(neighbor, cellP(neighbor) | MazeType.CELL_VISITED);
					breakWallP(obj[0], obj[1])
					merge(id(obj[0]), id(neighbor))
					tryAgain = false;
				}
			}
			
			return true;
		}
		public function id(point:Point):uint
		{
			return _ids[point.x][point.y];
		}
		public function merge(srcSet:uint, destSet:uint):void
		{
			for (var i:uint = 0; i < width; ++i)
			{
				for (var j:uint = 0; j < height; ++j)
				{
					if (_ids[i][j] == srcSet)
					{
						_ids[i][j] = destSet;		
					}
				}
			}
		}
	}
}