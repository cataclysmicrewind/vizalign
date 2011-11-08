

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * AdjacentBottomAligner aligns the targets top edge againts the bottom edge of the target coordinate space object.
	 * @author ktu
	 */
	public class AdjacentBottomAligner implements IRectangleAligner {
		
		/**
		 * aligns the targets top edge againts the bottom edge of the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var length:int = targets.length;													// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].y = tcsBottomEdge;
		}
	}
}