

package ktu.utils.align.capabilities.gfx {
	
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import com.bit101.components.Text;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import ktu.utils.align.aligners.HorizontalAligner;
	import ktu.utils.align.VizAlign;
	import ktu.utils.align.VizAlignment;
	
	/**
	 *  This is a ui control that lives outside of everything on the main stage
	 *
	 * it allows you to enter fullscreen mode in the player. you can set your own dimensions and then click the button
	 *
	 *
	 * if the dimensions are smaller than the original dimensions of the swf, it throws up a warning where you can accept or deny
	 *
	 * @author ktu
	 */
	public class Fullscreen extends Sprite {
		
		private var _panel:Panel;
		private var _w:Text;
		private var _h:Text;
		private var _go:PushButton;
		private var _lable:Label;
		
		private var surpressed:Boolean = false;
		
		public function Fullscreen(){
			
			_panel = new Panel(this, 0, 0);
			_panel.width = 130;
			_panel.height = 75;
			
			_w = new Text(_panel, 10, 10, String(Capabilities.screenResolutionX));
			_w.width = 50;
			_w.height = 25;
			
			_h = new Text(_panel, 70, 10, String(Capabilities.screenResolutionY));
			_h.width = 50;
			_h.height = 25;
			
			_go = new PushButton(_panel, 30, 45, "fullscreen", onGoClick);
			_go.width = 70;
		}
		
		private function onGoClick(e:Event = null):void {
			// toggle fullscreen
			
			
			stage.fullScreenSourceRect = new Rectangle(0, 0, int(_w.text), int(_h.text));
			
			if (stage.displayState == StageDisplayState.NORMAL){
				if (!surpressed){
					if (int(_w.text) < 750 || int(_h.text) < 700){
						showWarning();
						return;
					}
				}
				_go.labelText = "exit fullscreen";
				_go.width = 80;
				_go.x = 25;
				stage.displayState = StageDisplayState.FULL_SCREEN
			} else {
				_go.labelText = "fullscreen";
				_go.width = 70;
				_go.x = 30;
				stage.displayState = StageDisplayState.NORMAL
			}
		}
		
		private function showWarning():void {
			// display a modal message that says:
			//		going fullscreen with dimensions smaller than the original state of the swf will result in undesired visibility
			//			are you sure you want to enter fullscreen with these dimensions?
			var message:Sprite = new Sprite();
			message.name = "message";
			var g:Graphics = message.graphics;
			g.beginFill(Style.BACKGROUND, .7);
			g.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			
			var panel:Panel = new Panel(message, 175, 210);
			panel.width = 400;
			panel.height = 280;
			var label:TextField = new TextField();
			label.x = label.y = 20;
			label.width = panel.width - 40
			label.height = panel.height - 60;
			label.defaultTextFormat = new TextFormat(Style.fontName, 20, Style.LABEL_TEXT, null, null, null, null, null, TextFormatAlign.CENTER);
			label.text = "the dimensions you have chosen are smaller than the original state of this swf.\n\n using these dimensions may inhibit you from using some of the controls.\n\n are you sure you want to enter fullscreen?";
			label.multiline = true;
			label.wordWrap = true;
			panel.addChild(label);
			
			var fullscreen:PushButton = new PushButton(panel, 0, 0, "fullscreen", onFullScreenAccept);
			var cancel:PushButton = new PushButton(panel, 0, 0, "cancel", onCancel);
			var space:Number = panel.width - fullscreen.width - cancel.width;
			var gap:Number = space / 3;
			fullscreen.x = gap;
			cancel.x = gap * 2 + fullscreen.width;
			
			fullscreen.y = cancel.y = (panel.height - label.y + label.height) / 2 - cancel.height / 2;
			
			
			stage.addChild(message);
		}
		
		private function onCancel(e:MouseEvent):void {
			stage.removeChild(stage.getChildByName("message"));
		}
		
		private function onFullScreenAccept(e:MouseEvent):void {
			stage.removeChild(stage.getChildByName("message"));
			
			surpressed = true;
			onGoClick();
			surpressed = false;
		}
	}
}