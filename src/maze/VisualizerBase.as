package maze {
	import mx.core.UIComponent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;

	public class VisualizerBase
	{
		// getter/setter
		private var _generator:GeneratorBase;
		private var _animated:Boolean;
		private var _view:UIComponent;
		private var _speed:uint;
		private var _size:uint;
		private var _thickness:uint;
		
		public function VisualizerBase()
		{
			generator = null;
			animated = false;
			view = null;
			speed = 1;
			size = 20;
			thickness = 2;
		}
		
		public function get generator():GeneratorBase
		{
			return _generator;
		}

		public function set generator(setValue:GeneratorBase):void
		{
			_generator = setValue;
		}

		public function get animated():Boolean
		{
			return _animated;
		}

		public function set animated(setValue:Boolean):void
		{
			_animated = setValue;
		}
		
		public function get view():UIComponent
		{
			return _view;
		}

		public function set view(setValue:UIComponent):void
		{
			_view = setValue;
		}
		
		public function get speed():uint
		{
			return _speed;
		}

		public function set speed(setValue:uint):void
		{
			_speed = setValue;
		}

		public function get size():uint
		{
			return _size;
		}

		public function set size(setValue:uint):void
		{
			_size = setValue;
		}

		public function get thickness():uint
		{
			return _thickness;
		}

		public function set thickness(setValue:uint):void
		{
			_thickness = setValue;
		}

		private var _animHandler: uint;

		public final function draw(uiView:UIComponent):void
		{
			view = uiView;
			
			if (_animHandler)
			{
				clearInterval(_animHandler);
			}

			if (animated)
			{
				_animHandler = setInterval(stepDraw, 5);
			}
			else
			{
				generator.buildAll();
				doDraw();
			}
		}
		
		public final function stepDraw():void
		{
			var fixedStep:int = Math.pow(speed, 2);
			if (!generator.doStepTimes(fixedStep))
			{
				clearInterval(_animHandler);
				_animHandler = 0;
			}
			doDraw();
		}
		
		//override me
		protected function doDraw():void
		{
			return;
		}
	}
}