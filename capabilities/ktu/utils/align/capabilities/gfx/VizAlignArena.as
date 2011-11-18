package ktu.utils.align.capabilities.gfx {
	import com.bit101.components.Style;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import ktu.utils.align.VizAlignment;
	
	/**
	 * VizAlignArena is merely an object that represents an area which will have tcs and targets to play with
	 * 
	 * this is the display list in which the tcs and targets live.
	 * 
	 * @author Keelan
	 */
	public class VizAlignArena extends Sprite{
		
		private var w:int;
		private var h:int;
		public var bg:Sprite;
		
		public var targets:Array = [];
		public var targetCoordinateSpaces:Array = [];
		
		public function VizAlignArena() {
			bg = new Sprite();
			addChild(bg);
		}
		
		public function setSize (w:int, h:int ):void {
			this.w = w;
			this.h = h;
			redraw();
		}
		
		public function addTarget(target:DisplayObject):void {
			targets.push(target);
			addChild(target);
		}
		public function addTCS(tcs:DisplayObject):void {
			targetCoordinateSpaces.push(tcs);
			addChild(tcs);
			//tcs.addEventListener(MouseEvent.ROLL_OVER, onTCSMouseOver);
		}
		
		private function onTCSMouseOver(e:MouseEvent):void {
			// show highlight
			var tcsBounds:Rectangle = VizAlignment.getTCSBounds(e.target, true);
			var highlight:Sprite = new Sprite();
			highlight.name = e.target.name + "_highlight";
			highlight.mouseEnabled = false;
			highlight.graphics.beginFill(0xCA0000, .4);
			highlight.graphics.drawRect(0, 0, tcsBounds.width, tcsBounds.height);
			highlight.graphics.endFill();
			highlight.graphics.beginFill(0xCA0000);
			highlight.graphics.drawRect(1, 1, tcsBounds.width - 2, tcsBounds.height - 2);
			highlight.graphics.drawRect(0, 0, tcsBounds.width, tcsBounds.height);
			e.target.addChild(highlight);
			e.target.removeEventListener(MouseEvent.ROLL_OVER, onTCSMouseOver);
			e.target.addEventListener(MouseEvent.ROLL_OUT, onTCSMouseOut);
		}
		
		private function onTCSMouseOut(e:MouseEvent):void {
			// remove old highlight
			var highlight:Sprite = e.target.getChildByName(e.target.name + "_highlight") as Sprite;
			e.target.removeChild(highlight);
			highlight = null;
			
			e.target.removeEventListener(MouseEvent.ROLL_OUT, onTCSMouseOut);
			e.target.addEventListener (MouseEvent.ROLL_OVER, onTCSMouseOver);
		}
		
		public function redraw( ):void {
			var g:Graphics = bg.graphics;
			g.clear();
			g.lineStyle(1, 0, 1, true, "none", "none", "none");
			g.beginFill(0xE5F5F2);
			g.moveTo(.5,.5);
			g.lineTo(w-1, .5);
			g.lineTo(w-1, h-1);
			g.lineTo(.5, h-1);
			g.lineTo(.5, .5);
			
		}
	}
}