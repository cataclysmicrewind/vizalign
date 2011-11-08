

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * AdjacentVerticalTopAligner aligns the targets bottom edge against the y center of the target coordinate space object.
	 * @author ktu
	 */
	public class AdjacentVerticalTopAligner implements IRectangleAligner {
		
		/**
		 * aligns the targets bottom edge against the y center of the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsCenterY:Number = targetCoordinateSpace.top + targetCoordinateSpace.height / 2;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].y = tcsCenterY - targets[i].height;
		}
	}
}