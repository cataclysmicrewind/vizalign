package ktu.utils.align.aligners {
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * ...
	 * @author ktu
	 */
	public class SpiralAligner implements IRectangleAligner {
		
		
		public var fromCorner:int = 0;
		public var rotation:int = 1;	// or -1
		
		public function SpiralAligner() {
			
		}
		
		/* INTERFACE ktu.utils.align.IRectangleAligner */
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var numTargets:int = targets.length;
			
			
		}
		
	}

}