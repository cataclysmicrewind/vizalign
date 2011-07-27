package ktu.utils.align.capabilities.gfx {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * ...
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
		}
		
		public function redraw( ):void {
			var g:Graphics = bg.graphics;
			g.clear();
			g.lineStyle(1, 0, 1, true, "none", "none", "none");
			g.moveTo(.5,.5);
			g.lineTo(w-1, .5);
			g.lineTo(w-1, h-1);
			g.lineTo(.5, h-1);
			g.lineTo(.5, .5);
			
		}
	}
}