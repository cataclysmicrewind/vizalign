

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * BottomRightAligner aligns each target so the bottom and right edges match the bottom and right edges of the target coordinate space
	 * @author ktu
	 */
	public class BottomRightAligner implements IRectangleAligner {
		
		/**
		 * aligns each target so the bottom and right edges match the bottom and right edges of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var target:Rectangle = targets[i];
				target.x = tcsRightEdge - target.width;
				target.y = tcsBottomEdge - target.width;
			}
		}
	}
}