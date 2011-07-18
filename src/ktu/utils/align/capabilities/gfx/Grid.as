package ktu.utils.align.capabilities.gfx {
	import flash.display.Graphics;
	import flash.display.Sprite;
	/**
	 *
	 * 	The grid is an aspect of a TargetArena
	 *
	 * 	It builds a simple grid, but has beautification.
	 *
	 * 	You can set colors for different intervals of lines.
	 *  If two intervals overlap, the color add later is the color used
	 *
	 *
	 * ...
	 * @author Keelan
	 */
	public class Grid extends Sprite {
		
		
		
		private var w:int = 100;
		private var h:int = 100;
		private var stepW:int = 10;
		private var stepH:int = 10;
		private var intervals:Array = [];
		
		private var defaultColor:uint;
		private var _table:Sprite = new Sprite();
		
		
		public function Grid(defaultColor:uint = 0xCCCCCC ) {
			this.defaultColor = defaultColor;
			addChild(_table);
			redraw();
		}
		
		public function setSize(w:int, h:int):void {
			this.w = w;
			this.h = h;
			redraw();
		}
		public function setSteps (w:int, h:int):void {
			stepW = w;
			stepH = h;
			redraw();
		}
		public function addInterval (every:int, color:uint):void {
			intervals.push ( { interval:every, color:color } );
			redraw();
		}
		
		private function redraw():void {
			var g:Graphics = _table.graphics;
			g.clear();
			
			var numStepsW:Number = w / stepW;
			var numStepsH:Number = h / stepH;
			
			// loop H does columns
			for (i = 0; i <= numStepsH; i++) {
				g.lineStyle(1, getLineColor(i), 1, true, "none", "none", "none");
				var ypos:int = i * stepH;
				g.moveTo(0, ypos);
				g.lineTo(w, ypos);
			}
			
			// loop W does columns
			for (var i:int = 0; i <= numStepsW; i++) {
				g.lineStyle(1, getLineColor(i), 1, true, "none", "none", "none");
				var xpos:int = i * stepW;
				g.moveTo(xpos, 0);
				g.lineTo(xpos, h);
			}
		}
		
		private function getLineColor(currentInterval:int):uint {
			var color:uint = defaultColor;
			for (var i:int = 0; i < intervals.length; i++) {
				var item:Object = intervals[i];
				var mod:Number = currentInterval % item.interval;
				if (mod == 0 ) color = item.color;
			}
			return color;
		}
	}

}