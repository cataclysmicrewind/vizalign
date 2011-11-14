

package ktu.utils.align.aligners {
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ktu.utils.align.IPointAligner;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * LeftAligner aligns each target so the left edge matches the left edge of the target coordinate space
	 * @author ktu
	 */
	public class LeftAligner implements IRectangleAligner, IPointAligner {
		
		/**
		 * aligns each target so the left edge matches the left edge of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsLeftEdge:Number = targetCoordinateSpace.left;				// get left edge of target coordinate space object
			var length:int = targets.length;									// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 								// loop through all targets
				targets[i].x = tcsLeftEdge;										// 		grab current target and set its x value
		}
		
		/**
		 * aligns Point to the left of the targetCoordinateSpace.
		 * 
		 * this function simply uses the alignRectanges. that function is genericly typed and since the only properties
		 * it cares about in the targets is an x, there is no problem because both Point and Rectangle have x properties
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignPoints(targetCoordinateSpace:Point, targets:Array/*Rectangle*/):void {
			alignRectangles(new Rectangle(targetCoordinateSpace.x, targetCoordinateSpace.y, 0, 0), targets);
		}
	}
}