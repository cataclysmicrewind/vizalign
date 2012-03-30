package ktu.utils.align.capabilities.utils {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	/**
	 * ...
	 * @author ktu
	 */
	public class ScreenRuler extends Sprite {
		
		private var _activated:Boolean = false;
		private var _delay:int = 10;
		public var strokeColor:uint = 0x073F3F;
		public var fillColor:uint = 0x073F3F;
		public var fillAlpha:Number = .4;
		private var distanceX:int = 15;
		private var distanceY:int = 15;
		private var paddingX:int = 15;
		private var paddingY:int = 15;
		private var anchor:Point;
		
		private var txt:TextField = new TextField();
		private var copy:Sprite = new Sprite();
		private var selection:Sprite = new Sprite();
		
		private var intervalID:uint;
		private var dragIntervalID:uint;
		private var copytxt:TextField;
		
		public function ScreenRuler(){
			txt.autoSize = "left";
			txt.border = true
			txt.background = true;
			addChild(txt);
			mouseEnabled = false;
			mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage(e:Event):void {
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onAddedToStage(e:Event):void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		public function get activated():Boolean {
			return _activated;
		}
		
		public function set activated(value:Boolean):void {
			_activated = value;
			if (value){
				intervalID = setInterval(update, _delay);
				
			} else {
				clearInterval(intervalID);
			}
		}
		
		
		
		public function get delay():int {
			return _delay;
		}
		
		public function set delay(value:int):void {
			_delay = value;
			activated = false;
			activated = true;
		}
		
		
		private function update():void {
			
			// info
			var mousePos:Point = new Point(stage.mouseX, stage.mouseY);
			var rect:Rectangle = drawCross(graphics, mousePos);
			
			// position text
			txt.text = mousePos.x + " : " + mousePos.y;
			var inside:Rectangle = rect.clone();
			inside.inflate(-txt.width + paddingX - distanceX, -txt.height - paddingY - distanceY);
			inside.offset(0, -txt.height + paddingY);
			
			if (mousePos.x > inside.width){
				// place on left side of shit
				txt.x = mousePos.x - distanceX - txt.width;
			} else {
				// place on right side of shit
				txt.x = mousePos.x + distanceX;
			}
			if (mousePos.y < inside.y){
				// place below shit
				txt.y = mousePos.y + distanceY;
			} else {
				// place above shit
				txt.y = mousePos.y - distanceX - txt.height;
			}
			setChildIndex(txt, numChildren-1);
		}
		private function drawCross(g:Graphics, mousePos:Point):Rectangle {
			var rect:Rectangle = new Rectangle();
			if (stage.displayState == StageDisplayState.NORMAL){
				rect.width = stage.stageWidth;
				rect.height = stage.stageHeight;
			} else {
				rect.width = stage.fullScreenSourceRect.width;
				rect.height = stage.fullScreenSourceRect.height;
			}
			
			// lines
			g.clear();
			g.beginFill(strokeColor);
			g.drawRect(0, mousePos.y, rect.width, 1);
			g.drawRect(mousePos.x, 0, 1, rect.height);
			g.endFill();
			return rect;
		}
		private function onMouseDown(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp)
			// get position and store anchor
			var mousePos:Point = new Point(stage.mouseX, stage.mouseY);
			anchor = mousePos.clone();
			// add interval for drawing rect
			dragIntervalID = setInterval(dragUpdate, _delay);
			// make copy of current position and leave there
			drawCross(copy.graphics, mousePos);
			addChild(copy);
			addChild(selection);
			// place copy of position text
			copytxt = new TextField();
			copytxt.autoSize = "left";
			copytxt.border = true
			copytxt.background = true;
			addChild(copytxt);
			copytxt.text = txt.text;
			copytxt.x = txt.x;
			copytxt.y = txt.y;
		}
		
		private function onMouseUp(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			removeChild(copy);
			removeChild(selection);
			removeChild(copytxt);
			clearInterval(dragIntervalID);
		}
		
		private function dragUpdate():void {
			// draw box from current pos to anchor
			
			var g:Graphics = selection.graphics;
			g.clear();
			g.beginFill(fillColor, fillAlpha);
			g.drawRect(anchor.x, anchor.y, mouseX - anchor.x, mouseY - anchor.y);
			g.endFill();
			
			
			
			
			txt.appendText("\n" + selection.width + " : " + selection.height);
		}
	}
}