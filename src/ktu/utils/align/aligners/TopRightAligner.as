

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * TopRightAligner aligns each target so the top and right edges match the top and right edges of the target coordinate space
	 * @author ktu
	 */
	public class TopRightAligner implements IRectangleAligner {
		
		/**
		 * aligns each target so the top and right edges match the top and right edges of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;										//	grab top of tcs
			var tcsRightEdge:Number = targetCoordinateSpace.right;									//	grab right of tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												//	loop (each target)
				targets[i].x = tcsRightEdge - targets[i].width;										//		place x at right
				targets[i].y = tcsTopEdge;															// 		place y at top
			}																						// end loop
		}
	}
}