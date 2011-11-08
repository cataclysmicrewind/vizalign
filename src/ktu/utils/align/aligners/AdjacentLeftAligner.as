

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * AdjacentLeftAligner aligns the targets right edge against the left edge of the target coordinate space object.
	 * @author ktu
	 */
	public class AdjacentLeftAligner implements IRectangleAligner {
		
		/**
		 * aligns the targets right edge against the left edge of the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].x = tcsLeftEdge - targets[i].width;
		}
	}
}