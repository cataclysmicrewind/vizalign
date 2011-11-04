

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * CenterAligner aligns each target so the visual x center and y center match the visual x and y center of the target coordinate space
	 * @author ktu
	 */
	public class CenterAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsCenterX:Number = targetCoordinateSpace.left + (targetCoordinateSpace.width / 2);	// get center x value of target coordinate space object
			var tcsCenterY:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height/ 2);	// get center y value of target coordinate space object
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												// loop through all targets
				var target:Rectangle = targets[i];													// 		grab current target as item
				target.x = tcsCenterX - (target.width / 2);											// 		apply x centering math
				target.y = tcsCenterY - (target.height / 2);										//		apply y centering math
			}																						// end loop
		}
	}
}