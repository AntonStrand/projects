package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import se.antonstrand.ateljedigital.videoplayer.Settings;
	import se.antonstrand.ateljedigital.videoplayer.controller.VideoController;
	import se.antonstrand.ateljedigital.videoplayer.event.ModelEvent;
	import se.antonstrand.ateljedigital.videoplayer.event.VideoViewEvent;
	import se.antonstrand.ateljedigital.videoplayer.model.ModelDatabase;
	import se.antonstrand.ateljedigital.videoplayer.view.VideoView;
	
	[SWF(width="1920", height='1080', frameRate="60", backgroundColor="0x444444")]
	public class VideoPlayer extends Sprite
	{
		private var _videoModel			:ModelDatabase;
		private var _videoController	:VideoController;
		
		public function VideoPlayer()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			
			init();
		}
		
		private function init(): void
		{
			// Sätter vilken bredd och höjd som ska finnas i Settings
			Settings.STAGE_W = stage.stageWidth;
			Settings.STAGE_H = stage.stageHeight;
			
			loadVideos();
		}
		
		private function loadVideos(): void
		{
			_videoModel = new ModelDatabase();
			_videoModel.addEventListener(ModelEvent.ERROR, onModelError);
			_videoModel.addEventListener(ModelEvent.COMPLETE, onModelComplete);
		}
		
		private function onModelComplete( e:ModelEvent ): void
		{
			_videoController = new VideoController( _videoModel );
			_videoController.stage = this;
		}
		
		protected function onLoaded_play(e:Event):void
		{
			trace(' on loaded' );

			e.target.play();
			
		}
		
		private function onModelError( e:ModelEvent ): void
		{
			trace( 'error loading' );
		}
	}
}
