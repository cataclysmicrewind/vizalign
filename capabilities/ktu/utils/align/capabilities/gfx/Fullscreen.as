package ktu.utils.align.capabilities.gfx {
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Fullscreen extends Sprite {
		
		private var _panel:Panel;
		private var _w:Text;
		private var _h:Text;
		private var _go:PushButton;
		private var _lable:Label;
		
		public function Fullscreen() {
			
			_panel = new Panel(this, 0, 0);
			_panel.width = 150;
			_panel.height = 75;
			
			_w = new Text(_panel, 10, 10, String(Capabilities.screenResolutionX));
			_w.width = 60;
			_w.height = 25;
			
			_h = new Text(_panel, 80, 10, String(Capabilities.screenResolutionY));
			_h.width = 60;
			_h.height = 25;
			
			_go = new PushButton(_panel, 40, 45, "fullscreen", onGoClick);
			_go.width = 70;
		}
		
		private function onGoClick(e:Event):void {
			// toggle fullscreen
			stage.fullScreenSourceRect = new Rectangle(0, 0, int(_w.text), int(_h.text));
			stage.displayState = StageDisplayState.FULL_SCREEN
		}
		
	}

}