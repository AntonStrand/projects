package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.ui.Mouse;
	
	import se.antonstrand.ateljedigital.inrediakarta.controllers.MainController;
	import se.antonstrand.ateljedigital.inrediakarta.models.ModelDatabase;
	import se.antonstrand.ateljedigital.inrediakarta.views.PatternGenerator;
	
	[SWF(width="1920", height="1080")]
	public class InrediaKarta extends Sprite
	{
		private var _modelDatabase		:ModelDatabase;
		
		public function InrediaKarta()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.displayState = StageDisplayState.FULL_SCREEN;
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.nativeWindow.activate();
			stage.nativeWindow.orderToBack();
			stage.nativeWindow.orderToFront();
			Mouse.hide();
			
			//_modelDatabase = new ModelDatabase();
			var controller : MainController = new MainController( new ModelDatabase );
			addChild( controller );
			
		}
	}
}