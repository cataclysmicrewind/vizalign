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
		
		public function Grid(defaultColor:uint = 0xCCCCCC){
			this.defaultColor = defaultColor;
			addInterval(1, defaultColor);
			addChild(_table);
			redraw();
		}
		
		public function setSize(w:int, h:int):void {
			this.w = w;
			this.h = h;
			redraw();
		}
		
		public function setSteps(w:int, h:int):void {
			stepW = w;
			stepH = h;
			redraw();
		}
		
		public function addInterval(every:int, color:uint):void {
			intervals.push({interval: every, color: color});
			redraw();
		}
		
		private function redraw():void {
			var g:Graphics = _table.graphics;
			g.clear();
			
			var numStepsW:Number = w / stepW;
			var numStepsH:Number = h / stepH;
			
			
			for (var i:int = 0; i < intervals.length; i++) {
				var interval:Object = intervals[i];
				// rows
				for (var j:int = 0; j <= numStepsH; j += interval.interval) {
					var ypos:int = j * stepH;
					g.beginFill(interval.color);
					g.drawRect(0, ypos, w, 1);
					g.endFill();
				}
				// columns
				for (j = 0; j <= numStepsW; j += interval.interval) {
					var xpos:int = j * stepW;
					g.beginFill(interval.color);
					g.drawRect(xpos, 0, 1, h);
					g.endFill();
				}
			}
		}
		
		private function getLineColor(currentInterval:int):uint {
			var color:uint = defaultColor;
			for (var i:int = 0; i < intervals.length; i++){
				var item:Object = intervals[i];
				var mod:Number = currentInterval % item.interval;
				if (mod == 0)
					color = item.color;
			}
			return color;
		}
	}

}