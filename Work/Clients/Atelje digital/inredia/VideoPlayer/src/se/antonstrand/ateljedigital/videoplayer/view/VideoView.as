package se.antonstrand.ateljedigital.videoplayer.view
{
	import fl.video.FLVPlayback;
	import fl.video.VideoEvent;
	import fl.video.VideoState;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import se.antonstrand.ateljedigital.videoplayer.Settings;
	import se.antonstrand.ateljedigital.videoplayer.event.VideoViewEvent;
	import se.antonstrand.ateljedigital.videoplayer.model.VideoData;
	
	
	
	
	public class VideoView extends Sprite
	{
		
		private var _videoPlayer		:FLVPlayback;
		
		private var _videoData			:VideoData;
		
		private var _pausePoint			:Number = 0;
		private var _isLoaded			:Boolean;
		private var _loadingError		:Boolean;
		
		public function VideoView( videoData:VideoData )
		{
			_videoData = videoData;
			init();
		}
		
		
		public function play( rewind:Boolean = true ): void
		{
			if( rewind ) _pausePoint = 0;
			
			if( _isLoaded && !_loadingError )
			{
				_videoPlayer.seek( _pausePoint );
				_videoPlayer.play();
				trace('play');
			}
			else if( !_isLoaded )
			{
				dispatchEvent( new VideoViewEvent( VideoViewEvent.NOT_LOADED ));
			}
		}
		
		public function stop(): void
		{
			if( _isLoaded && !_loadingError )
			{
				_pausePoint = _videoPlayer.playheadTime;
				_videoPlayer.stop();				
			}
		}
		
		private function init(): void
		{
			_videoPlayer = new FLVPlayback();
			_videoPlayer.width = Settings.STAGE_W;
			_videoPlayer.height = Settings.STAGE_H;
			_videoPlayer.addEventListener(VideoEvent.STATE_CHANGE, onStateChange_checkForError);
			_videoPlayer.addEventListener(VideoEvent.READY, onReady);
			_videoPlayer.load( _videoData.source );
			
			addChild( _videoPlayer );
			trace(' video view init ');
		}
		
		private function onStateChange_checkForError(e:VideoEvent):void
		{
			trace( e.state );
			if( e.state == VideoState.CONNECTION_ERROR )
			{
				_loadingError = true;
				dispatchEvent( new VideoViewEvent( VideoViewEvent.ERROR ));
			}
		}		
		
		private function onReady( e:VideoEvent ): void
		{
			_isLoaded = true;
			dispatchEvent( new VideoViewEvent( VideoViewEvent.LOADED ));
		}
	}
}