package utils
{
	public class SetBase
	{
		private var _items:Array;
		private var comporator:Function;

		public function SetBase(compareFunction:Function=null)
		{
			_items = new Array();
			if (compareFunction == null)
			{
				compareFunction = function (a:*, b:*):Boolean { return a == b };
			}
			comporator = compareFunction;
		}

		public function add(item:*):Boolean
		{
			var len:int = _items.length;
			for(var i:uint = 0; i < len; i++)
			{
				if(comporator(_items[i], item))
				{
					_items[i] = item;
					return false;
				}
			}

			_items.push(item);
			return true;
		}

		public function remove(item:*):Boolean
		{
			var len:int = _items.length;
			for(var i:uint = 0; i < len; i++)
			{
				if(comporator(_items[i], item))
				{
					_items.splice(i, 1);
					return true;
				}
			}
			return false;
		}

		public function getAsArray():Array
		{
				return _items.slice();
		}

		public function removeAll():void
		{
				_items = new Array();
		}

		public function contains(item:*):Boolean
		{
				var len:int = _items.length;
				for(var i:uint = 0; i < len; i++)
				{
						if (comporator(_items[i], item))
						{
							return true;
						}
				}
				return false;
		}

		public function get isEmpty():Boolean
		{
				return _items.length == 0;
		}

		public function get length():uint
		{
				return _items.length;
		}
	}
}