

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * AdjacentHorizontalRightAligner aligns the targets left edge against the x center of the target coordinate space object.
	 * @author ktu
	 */
	public class AdjacentHorizontalRightAligner implements IRectangleAligner {
		
		/**
		 * aligns the targets left edge against the x center of the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsCenterX:Number = targetCoordinateSpace.left + targetCoordinateSpace.width / 2;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = tcsCenterX;
		}
	}
}