package maze {
	// base
	import maze.VisualizerBase;
	import maze.MazePrintView;
			
	// for print
	import mx.printing.FlexPrintJob;
	import mx.printing.FlexPrintJobScaleType;
	import mx.core.FlexGlobals;

	public class Printer
	{
		static public function Send(visual:VisualizerBase):void
		{
			// Finish maze builing if not completed yet
			if (!visual.generator.isCompleted())
			{
				// TODO:
				//maze.createRoute();
			}
			
			var printJob:FlexPrintJob = new FlexPrintJob();
			printJob.printAsBitmap = false;

			if (printJob.start())
			{
				var printView:MazePrintView = new MazePrintView();
				printView.width  = printJob.pageWidth;
				printView.height = printJob.pageHeight;
				
				FlexGlobals.topLevelApplication.addElement(printView);
				visual.draw(printView.printBC);
				
				printView.callLater(
					function ():void {
						var mw:Number = printView.printBC.width;
						var mh:Number = printView.printBC.height;
						var pw:Number = printView.printCont.width;
						var ph:Number = printView.printCont.height;
						
						// If rotation is optimal
						if ((mw > mh && ph > pw) || (mw < mh && ph < pw))
						{
							printView.printBC.rotation = 90;
							printView.printBC.scaleY = printView.printBC.scaleX = Math.min(pw / mh, ph / mw, 1);
						}
						else
						{
							printView.printBC.scaleY = printView.printBC.scaleX = Math.min(ph / mh, pw / mw, 1);
						}

						printJob.addObject(printView, FlexPrintJobScaleType.SHOW_ALL);
						printJob.send(); 
						
						FlexGlobals.topLevelApplication.removeElement(printView);
					}
				);
			}
		}
	}
}