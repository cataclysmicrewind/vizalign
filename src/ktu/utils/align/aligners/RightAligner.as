package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	/**
	 * ...
	 * @author ...
	 */
	public class RightAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsRightEdge:Number = targetCoordinateSpace.right;				// get right edge of target coordinate space object
			var length:int = targets.length;									// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 								// loop through all targets
				targets[i].x = tcsRightEdge - targets[i].width;					// 		grab current target as item
		}
		
	}

}