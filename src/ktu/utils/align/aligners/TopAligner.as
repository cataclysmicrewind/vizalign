

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * TopAligner aligns each target so the top edge matches the top edge of the target coordinate space
	 * @author ktu
	 */
	public class TopAligner implements IRectangleAligner {
		
		/**
		 * aligns each target so the top edge matches the top edge of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;										//	grab top of tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )													//	for (each target)
				targets[i].y = tcsTopEdge;															//		place y at top
		}
	}
}