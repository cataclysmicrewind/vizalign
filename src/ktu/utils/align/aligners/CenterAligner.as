package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	/**
	 * ...
	 * @author ...
	 */
	public class CenterAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsCenterX:Number = targetCoordinateSpace.left + (targetCoordinateSpace.width / 2);	// get center x value of target coordinate space object
			var tcsCenterY:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height/ 2);
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												// loop through all targets
				var target:Rectangle = targets[i];													// 		grab current target as item
				target.x = tcsCenterX - (target.width / 2);											// 		apply math to target
				target.y = tcsCenterY - (target.height / 2);
			}																						// end loop
		}
		
	}

}