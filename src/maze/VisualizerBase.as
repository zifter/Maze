package maze {
	import mx.core.UIComponent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.geom.Point;

	public class VisualizerBase
	{
		private var _settings:VisualSettings;
		// getter/setter
		private var _generator:GeneratorBase;
		private var _view:UIComponent;
		
		public function VisualizerBase()
		{
			_settings = new VisualSettings();
			generator = null;
			view = null;
		}
		
		public function get generator():GeneratorBase { return _generator; }
		public function set generator(setValue:GeneratorBase):void { _generator = setValue; }
		
		public function get view():UIComponent { return _view; }
		public function set view(setValue:UIComponent):void { _view = setValue; }
		
		public function get settings():VisualSettings { return _settings; }
		public function set settings(setValue:VisualSettings):void { _settings = setValue; }
		
		private var _animHandler: uint;

		public final function draw(uiView:UIComponent):void
		{
			view = uiView;
			
			if (_animHandler)
			{
				clearInterval(_animHandler);
			}

			if (settings.ANIMATED)
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
			var fixedStep:int = settings.SPEED;
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