

package ktu.utils.align.aligners {
	
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * HorizontalAligner aligns each target so the visual x center of each target matches the visual x center of the target coordinate space
	 * @author ktu
	 */
	public class HorizontalAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var mid:Number = targetCoordinateSpace.left + (targetCoordinateSpace.width / 2);	// get center x value of target coordinate space object
			var length:int = targets.length;													// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )												// loop through all targets
				targets[i].x = mid - (targets[i].width / 2);									// 		grab current target as item
		}
	}
}