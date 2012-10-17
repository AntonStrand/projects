package se.antonstrand.ateljedigital.videoplayer.controller
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import se.antonstrand.ateljedigital.videoplayer.event.VideoViewEvent;
	import se.antonstrand.ateljedigital.videoplayer.model.ModelDatabase;
	import se.antonstrand.ateljedigital.videoplayer.view.VideoView;

	public class VideoController
	{
		private var _videos		:Vector.<VideoView>;
		private var _numVideos	:uint;
		
		private var _stage		:Sprite
		
		public function VideoController( modelDB:ModelDatabase )
		{
			initVideos( modelDB );
		}
		
		public function set stage( stage:Sprite ): void
		{
			_stage = stage;
		}
		
		
		private function initVideos( modelDB: ModelDatabase ): void
		{
			_videos = new Vector.<VideoView>();
			
			for (var i:int = 0; i < modelDB.models.length; i++) 
			{
				_videos[i] = new VideoView( modelDB.models[i] );
				_videos[i].addEventListener(VideoViewEvent.ERROR, onError_removeVideo);
				_videos[i].addEventListener(VideoViewEvent.LOADED, countLoaded);
			}
			
		}
		
		private function countLoaded(e:Event = null):void
		{
			if( e != null ) 
			{
				e.target.removeEventListener(VideoViewEvent.LOADED, countLoaded);
				_numVideos++;
			}
			
			
			if( _numVideos == _videos.length )
			{
				// Här ska den dispatcha så att programmet ska connecta till iPaden och starta default videon. 
				_videos[0].play();
				_stage.addChild( _videos[0] );
				trace( 'all loaded' );
			}
		}
		
		private function onError_removeVideo( e:VideoViewEvent ): void
		{
			e.target.removeEventListener(VideoViewEvent.ERROR, onError_removeVideo);
			e.target.removeEventListener(VideoViewEvent.LOADED, countLoaded);
			
			// Fångar upp den som inte fungerar för den ska inte skapas.
			
			// Ska lägga in data i VideoViewEvent för att kunna plocka ut den ur mdb.
			
			
			// För om det är fel på den sista ska man ändå fortsätta för att se om alla andra har laddats in.
			countLoaded();
		}
	}
}