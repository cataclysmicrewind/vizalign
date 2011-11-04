

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * TopRightAligner aligns each target so the top and right edges match the top and right edges of the target coordinate space
	 * @author ktu
	 */
	public class TopRightAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				targets[i].x = tcsRightEdge - targets[i].width;
				targets[i].y = tcsTopEdge;
			}
		}
	}
}