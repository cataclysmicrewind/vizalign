

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * TopLeftAligner aligns each target so the top and left edges match the top and left edges of the target coordinate space
	 * @author ktu
	 */
	public class TopLeftAligner implements IRectangleAligner {
		
		/**
		 * aligns each target so the top and left edges match the top and left edges of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;										// 	grab the top of the tcs
			var tcsLeftEdge:Number = targetCoordinateSpace.left;									// 	grab the left of the tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												//	loop (each target)
				targets[i].y = tcsTopEdge;															//		place y at top
				targets[i].x = tcsLeftEdge;															// 		place x at left
			}																						//	end loop
		}
	}
}