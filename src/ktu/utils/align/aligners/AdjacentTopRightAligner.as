

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * AdjacentTopRightAligner aligns the targets bottom and left edge againts the top and right edge of the target coordinate space object.
	 * @author ktu
	 */
	public class AdjacentTopRightAligner implements IRectangleAligner {
		
		/**
		 * aligns the targets bottom and left edge againts the top and right edge of the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var target:Rectangle = targets[i];
				target.x = tcsRightEdge;
				target.y = tcsTopEdge - target.height;
			}
		}
	}
}