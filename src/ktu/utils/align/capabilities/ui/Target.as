package ktu.utils.align.capabilities.ui {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Keelan
	 */
	public class Target extends Sprite {
		
		private var originX:int = 0;
		private var originY:int = 0;
		private var w:int = 100;
		private var h:int = 100;
		private var color:uint = 0x333333;
		
		private var showOrigin:Boolean = false;
		
		
		public function Target(w:int = 100, h:int = 100) {
			setSize(w, h);
			// dragability
			addEventListener (MouseEvent.MOUSE_DOWN, onMouseDown);
			// double click shows origin with line
			doubleClickEnabled = true;
			addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
			redraw();
		}
		
		
		
		public function setSize (w:int, h:int):void {
			this.w = w;
			this.h = h;
			redraw();
		}
		
		
		public function setColor (color:uint):void {
			this.color = color;
			redraw();
		}
		
		public function setOriginOffset (x:int, y:int):void {
			originX = x;
			originY = y;
			redraw();
		}
		
		
		
		private function redraw():void {
			graphics.clear();
			
			// draw box
			graphics.beginFill(color);
			graphics.drawRect( -originX, -originY, w, h);
			graphics.endFill();
			
			if (showOrigin) {
				graphics.lineStyle(1, 0xFF0000, 1, true, "none", "none", "none");
				graphics.moveTo( -originX, -originY);
				graphics.lineTo(0, 0);
				// draw +
				graphics.moveTo( -5, 0);
				graphics.lineTo( 5, 0);
				graphics.moveTo( 0, -5);
				graphics.lineTo( 0, 5);
			}
		}
		
		
		
		/**
		 *
		 * 		Dragability Code
		 *
		 *
		 * @param	e
		 */
		private function onMouseDown(e:MouseEvent):void {
			startDrag();
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseUp(e:MouseEvent):void {
			stopDrag();
		}
		
		
		/**
		 *
		 * 	double click code shows origin point
		 *
		 *
		 *
		 */
		private function onDoubleClick(e:MouseEvent):void {
			showOrigin = !showOrigin;
			trace("Target::onDoubleClick() - showOrigin is now " + showOrigin);
			redraw();
		}
	}
}