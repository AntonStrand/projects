package se.antonstrand.ateljedigital.inrediakarta.views
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import se.antonstrand.ateljedigital.inrediakarta.Settings;
	import se.antonstrand.ateljedigital.inrediakarta.events.MenuEvent;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.MapName;
	import se.antonstrand.ateljedigital.inrediakarta.views.gui.ToggleButton;

	
	public class Menu extends Sprite
	{
		[Embed(source="assets/graphics/menuborder.png")]
		private var MenuBorder		:Class;
		
		
		private var _toggleButton	:ToggleButton;
		private var _buttons		:Vector.<MenuButton>;
		private var _mapNameTf		:MapName;
		
		public function Menu()
		{
			_buttons = new Vector.<MenuButton>();
			createMenu();
		}
		
		public function updateMapNameTo( p_label:String ): void
		{
			_mapNameTf.textField.text = p_label;
		}
		
		public function addButton( label:String, idx:uint ): void
		{
			var prev_btn_idx:uint = _buttons.length;
			var newButton : MenuButton = new MenuButton( label, idx );
			
			newButton.x = prev_btn_idx * (newButton.width + 10) + 275;
			newButton.y = -10;
			
			newButton.filters = [Settings.DROP_SHADOW_FILTER];
			
			_buttons.push( newButton );
			
			newButton.addEventListener(MouseEvent.CLICK, onClick_disatch);
			
			addChild( newButton );
			trace( 'num of buttons:', _buttons.length, newButton.x );
		}
	
		
		private function createMenu(): void
		{
			var menuPattern : Bitmap = new MenuBorder();
			addChildAt( menuPattern, 0 );
			

			
			_mapNameTf = new MapName();
			_mapNameTf.filters = [ Settings.DROP_SHADOW_FILTER ];
			_mapNameTf.y = -10;
			addChild( _mapNameTf );
			
			_toggleButton = new ToggleButton();
			_toggleButton.filters = [Settings.DROP_SHADOW_FILTER];
			_toggleButton.x = Settings.STAGE_W - (_toggleButton.width + 50);
			_toggleButton.y = 40;
			addChild( _toggleButton );
		}
		
		public function get toggleButton(): ToggleButton
		{
			return _toggleButton;
		}
		
		private function onClick_disatch( e:MouseEvent ): void
		{
			var target : MenuButton = MenuButton( e.target );
			
			dispatchEvent( new MenuEvent( MenuEvent.PRESSED, target.index ));
		}
	}
}