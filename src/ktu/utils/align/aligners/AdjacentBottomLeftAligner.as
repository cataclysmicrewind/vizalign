

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * AdjacentBottomLeftAligner aligns the targets top and right edge against the bottom and left edge of the target coordinate space object.
	 * @author ktu
	 */
	public class AdjacentBottomLeftAligner implements IRectangleAligner {
		
		/**
		 * aligns the targets top and right edge against the bottom and left edge of the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var target:Rectangle = targets[i];
				target.x = tcsLeftEdge - target.width;
				target.y = tcsBottomEdge;
			}
		}
	}
}