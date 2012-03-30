package ktu.utils.align.capabilities.gfx {
	import com.bit101.components.CheckBox;
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author ktu
	 */
	public class Options extends Sprite {
		
		public var currentTarget:Target;
		
		private var btnTab:PushButton;
		
		private var panel:Panel;
		private var header:Label;
		private var targetDetails:Label;
		private var targetName:Label;
		private var targetProps:Label;
		private var vrule:Sprite;
		
		private static const VRULE_COLOR:uint = Style.LIST_ROLLOVER
		
		private var showOrigin:CheckBox;
		private var _open:Boolean = false;
		private var screenRuler:CheckBox;
		private var highlightTCS:CheckBox;
		
		public function get open():Boolean {
			return _open;
		}
		
		public function set open(value:Boolean):void {
			_open = value;
			if (_open){
				// open position
				btnTab.rotation = 0;
				btnTab.x = 150 / 2 - btnTab.width / 2;
				btnTab.y = 0 - btnTab.height;
			} else {
				// closed position
				btnTab.rotation = 90;
				btnTab.x = panel.width + btnTab.height;
				btnTab.y = panel.height / 2 - btnTab.width / 2;
			}
			dispatchEvent(new StatusEvent("open"));
		}
		
		
		
		public function Options(){
			build();
			open = false;
		}
		
		
		private function build():void {
			
			// tab
			btnTab = new PushButton(this, 0, 0, "options", function (e:MouseEvent):void {
				open = !open;
			});
			
			
			// main panel
			panel = new Panel(this);
			panel.width = 150;
			panel.height = 220;
			panel.color = Style.BOTTOM;
			panel.draw();
			
			
			header = new Label(panel, 5, 5, "options:");
			header.autoSize = false;
			header.width = panel.width - 10;
			
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			fmt.align = "center";
			header.textField.defaultTextFormat = fmt;
			header.text = "options:";
			
			
			var infoPanel:Panel = new Panel(panel, 5, header.y + header.height + 10);
			infoPanel.width = panel.width - 10;
			infoPanel.height = panel.height - infoPanel.y - 5 - 20;
			
			
			// screen ruler
			screenRuler = new CheckBox(infoPanel, 10, 20, "show screen ruler", onScreenRuler);
			
			// highlight tcs
			highlightTCS = new CheckBox(infoPanel, 10, screenRuler.y + screenRuler.height + 20, "highlight tcs", onHightlightTCS);
			
			// fullscreen
			var fullscreen:Fullscreen = new Fullscreen();
			fullscreen.x = 5;
			fullscreen.y = highlightTCS.y + highlightTCS.height + 20;
			infoPanel.addChild(fullscreen);
		
		
		}
		
		private function onHightlightTCS(e:Event):void {
			dispatchEvent(new StatusEvent("highlightTCS", false, false, highlightTCS.selected.toString()));
		}
		
		private function onScreenRuler(e:Event):void {
			dispatchEvent(new StatusEvent("screenRuler", false, false, screenRuler.selected.toString()));
		}
	
	}

}