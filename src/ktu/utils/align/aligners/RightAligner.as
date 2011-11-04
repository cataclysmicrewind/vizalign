

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * RightAligner aligns each target so the right edge of each target matches the right edge of the target coordinate space.
	 * @author ktu
	 */
	public class RightAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsRightEdge:Number = targetCoordinateSpace.right;				// get right edge of target coordinate space
			var length:int = targets.length;									// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 								// loop through all targets
				targets[i].x = tcsRightEdge - targets[i].width;					// 		grab current target as item
		}
	}
}