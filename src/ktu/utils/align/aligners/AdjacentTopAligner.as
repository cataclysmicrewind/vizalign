

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * AdjacentTopAligner aligns the targets bottom edge against the top edge of the target coordinate space object.
	 * @author ktu
	 */
	public class AdjacentTopAligner implements IRectangleAligner {
		
		/**
		 * aligns the targets bottom edge against the top edge of the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var length:int = targets.length;													// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = tcsTopEdge - targets[i].height;
		}
	}
}