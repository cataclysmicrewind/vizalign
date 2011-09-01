package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	/**
	 * ...
	 * @author ...
	 */
	public class LeftAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsLeftEdge:Number = targetCoordinateSpace.left;				// get left edge of target coordinate space object
			var length:int = targets.length;									// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 								// loop through all targets
				targets[i].x = tcsLeftEdge;										// 		grab current target and set its x value
		}
		
	}

}