package ktu.utils.align.capabilities.utils {
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
		public var strokeColor:uint = 0xFF0000;
		public var fillColor:uint = 0xFF0000;
		public var fillAlpha:Number = .4;
		
		
		private var txt:TextField = new TextField();
		
		private var intervalID:uint;
		
		public function ScreenRuler() {
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
		
		private var distanceX:int = 10;
		private var distanceY:int = 10;
		private var paddingX:int = 10;
		private var paddingY:int = 10;
		
		private function update():void {
			
			// info
			var mousePos:Point = new Point(stage.mouseX, stage.mouseY);
			var rect:Rectangle = new Rectangle();
			if (stage.displayState == StageDisplayState.NORMAL){
				rect.width = stage.stageWidth;
				rect.height = stage.stageHeight;
			} else {
				rect.width = stage.fullScreenSourceRect.width;
				rect.height = stage.fullScreenSourceRect.height;
			}
			
			// lines
			graphics.clear();
			graphics.beginFill(strokeColor);
			graphics.drawRect(0, mousePos.y, rect.width, 1);
			graphics.drawRect(mousePos.x, 0, 1, rect.height);
			graphics.endFill();
			
			// position text
			txt.text = mousePos.x + " : " + mousePos.y;
			var inside:Rectangle = rect.clone();
			inside.inflate( -txt.width + paddingX - distanceX, -txt.height - paddingY - distanceY);
			inside.offset(0, -txt.height + paddingY);
			
			if (mousePos.x > inside.width) {
				// place on left side of shit
				txt.x = mousePos.x - distanceX - txt.width;
			} else {
				// place on right side of shit
				txt.x = mousePos.x + distanceX;
			}
			if (mousePos.y < inside.y) {
				// place below shit
				txt.y = mousePos.y + distanceY;
			} else {
				// place above shit
				txt.y = mousePos.y - distanceX - txt.height;
			}
		}
		
		private function onMouseDown(e:MouseEvent):void {
			// make copy of current position and leave there
			// make box from planted position to current position
			// show and move width height box
		
		}
	}
}