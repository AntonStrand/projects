package se.antonstrand.ateljedigital.inrediakarta.views
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextFieldAutoSize;
	
	import se.antonstrand.ateljedigital.inrediakarta.RectGfx;
	import se.antonstrand.ateljedigital.inrediakarta.Settings;
	import se.antonstrand.ateljedigital.inrediakarta.controllers.SoundController;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.Headline;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.InfoBoxGfx;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.ReadMoreTextField;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.SoundBtnGfx;
	import se.antonstrand.ateljedigital.inrediakarta.models.data.BuildingData;
	
	public class BuildingInfoView extends Sprite
	{
		[Embed(source="assets/graphics/InfoMenu.png")]
		private var InfoMenu		:Class;
		
		private var _data			:BuildingData;
		
		private var _menuGfx		:Bitmap;
		private var _gfx			:Sprite;
		private var _textGfx		:Sprite;
		private var _image			:Image;
		private var _qrImage		:Image;
		private var _soundPlayer	:SoundPlayer;

		private var _haveImage		:Boolean;
		
		private var _w				:uint;
		private var _h				:uint;
		
		public function BuildingInfoView( p_data:BuildingData )
		{
			_data = p_data;
			init();
		}
		
		private function init(): void
		{

			_gfx = new Sprite();
			addChild( _gfx );
			_w = _h = Settings.INFO_BORDER;
			
			 _menuGfx = new InfoMenu();
			_gfx.addChild( _menuGfx );
			
			_h = _menuGfx.height + Settings.INFO_DISTANCE;
			
			if ( _data.image_source != "" )
			{
				_image = new Image( _data.image_source );
				_image.addEventListener(Image.LOADED, positionImage);
			}
			else addText();

		}

		
		public function deactivate(): void
		{
			if( _soundPlayer ) _soundPlayer.stopSound();
		}
		
		public function get isPlayingSound(): Boolean
		{
			if( _soundPlayer ) return _soundPlayer.isPlayingSound;
			else return false;
		}
		
		/**
		 * Move centerpoint down 
		 **/
		public function pos_up(): void
		{
			_gfx.y = - _gfx.height;
		}

		/**
		 * Move centerpoint right
		 **/
		public function positionleft(): void
		{
			_gfx.x = - _gfx.width;
		}

		
		private function positionImage( e:Event ): void
		{
			
			_image.x = Settings.INFO_BORDER;
			_image.y = _h;
					
			_w = _image.width;
			_h = _image.y + _image.height + Settings.INFO_BORDER;
			
			_gfx.addChild( _image );
			
			addText();
		}
		
		private function addText(): void
		{
			_textGfx = new Sprite();
			
			var headline : Headline = new Headline();
			headline.textField.autoSize = TextFieldAutoSize.CENTER;
			headline.textField.text = _data.name;
			_textGfx.addChild( headline );

			
			var infoBox : InfoBoxGfx = new InfoBoxGfx(); 
			if( _w > infoBox.width ) infoBox.desc_tf.width = _w 
			else if( _image ) _image.x = (_textGfx.width*.5 - _image.width*.5) + Settings.INFO_BORDER;
			infoBox.desc_tf.autoSize = TextFieldAutoSize.LEFT;
			infoBox.desc_tf.text = _data.description;
			infoBox.y = headline.height + Settings.INFO_DISTANCE;
			_textGfx.addChild( infoBox );
			
			headline.x = _textGfx.width*.5 - headline.width*.5; 
			
			
			
			_textGfx.x = Settings.INFO_BORDER;
			_textGfx.y = _h;
			_w = _textGfx.width;
			_h += _textGfx.height;
			
			_gfx.addChild( _textGfx );

			
			if( _data.sound_source != "" )
			{
				createSoundPlayer();			
			}	
			else if( _data.qr_code_source != "" )
			{
				trace('Create QR');
				_qrImage = new Image( _data.qr_code_source );	
				_image.addEventListener(Image.LOADED, positionQrImage);
			}
			else createBackground();
		}
		
		private function createSoundPlayer(): void
		{
			_soundPlayer = new SoundPlayer( new SoundController( _data.sound_source ));
			
			_soundPlayer.x = Settings.INFO_BORDER;
			_soundPlayer.y = _textGfx.y + _textGfx.height + Settings.INFO_DISTANCE;		
			
			_gfx.addChild( _soundPlayer );	
			
			
			
			if( _data.qr_code_source !='' )
			{
				trace( 'create QR', _data.qr_code_source );
				_qrImage = new Image( _data.qr_code_source );	
				_qrImage.addEventListener(Image.LOADED, positionQrImage);				
			}
			else createBackground();
		}
		
		
		
		private function positionQrImage( e:Event ): void
		{
			
			_qrImage.x = _textGfx.x + _textGfx.width - _qrImage.width;
			_qrImage.y = _textGfx.y + _textGfx.height + Settings.INFO_DISTANCE;
						
			_gfx.addChild( _qrImage );
			
			var readMore :ReadMoreTextField = new ReadMoreTextField();
			readMore.x = _qrImage.x - readMore.width;
			readMore.y = _qrImage.y + _qrImage.height - readMore.height;
			
			_gfx.addChild( readMore );
			
			createBackground();
			
		}
		
		
		private function createBackground(): void
		{
			var bg : RectGfx = new RectGfx( _gfx.width + Settings.INFO_BORDER, _gfx.height + Settings.INFO_BORDER, 0xFFFFFF ); 
			_gfx.addChildAt( bg, 0 );			
		}
	}
}