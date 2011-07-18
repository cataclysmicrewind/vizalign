
package ktu.utils.align.capabilities.gfx {
	
	import com.flashdynamix.motion.extras.ColorMatrix;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	/**
	 *
	 * 	A target used in the TargetArena.
	 *
	 * 	They can be dragged around anywhere (no boundaries)
	 * 	They can be double clicked on to show the origin
	 *
	 * 	You can set the color, size, and orignOffset
	 *
	 *
	 * 	TODO:
	 * 		Make the origin Offset better
	 * 		Add a txt field to it to show the origin offest always
	 * 			What do I do if the target is too small?
	 *
	 *
	 *
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
			
			var dcolor:Number = darken(color, .5);
			// draw drop
			graphics.beginFill(dcolor);
			graphics.drawRect( -originX + w - 1, -originY, 1, h);
			graphics.endFill();
			graphics.beginFill(dcolor);
			graphics.drawRect( -originX, -originY + h - 1, w, 1);
			graphics.endFill();
			// add corner husk
			graphics.beginFill(dcolor);
			graphics.drawRect(-originX + 2, -originY + 2, 6, 2);
			graphics.endFill();
			graphics.beginFill(dcolor);
			graphics.drawRect(-originX + 2, -originY + 2, 2, 6);
			graphics.endFill();
			
			// show origin ?
			if (showOrigin) {
				graphics.lineStyle(2, 0xFF0000, 1, true, "none", "none", "none");
				graphics.moveTo( -originX, -originY);
				graphics.lineTo(0, 0);
				
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
			redraw();
		}
		
		public static function darken(color:Number, ratio:Number):Number{
            var rgb:Object = getRGB(color);
            for (var ele in rgb){
                rgb[ele] = rgb[ele] * (1-ratio);
            }
            return (getHex(rgb.r, rgb.g, rgb.b));
        }
		public static function getRGB(color:Number):Object{
            var r = color >> 16 & 0xFF;
            var g = color >> 8 & 0xFF;
            var b = color & 0xFF;
            return {r:r, g:g, b:b};
        }
		public static function getHex(r:Number, g:Number, b:Number):Number{
            var rgb:String = "0x" + (r<16?"0":"") + r.toString(16) + (g<16?"0":"") + g.toString(16) + (b<16?"0":"") + b.toString(16);
            return Number(rgb);
        }
	}
}