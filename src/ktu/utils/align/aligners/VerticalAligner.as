

package ktu.utils.align.aligners {
	
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * VerticalAligner aligns the y center of each target to match the y center of the target coordinate space
	 * @author ktu
	 */
	public class VerticalAligner implements IRectangleAligner {
		/**
		 * aligns the y center of each target to match the y center of the target coordinate space
		 * 
		 * 
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var centerY:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height / 2);	// 	grab the y center of the tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )													// 	loop (each target)
				targets[i].y = centerY - ( targets[i].height / 2 );									//		put target y at center of tcs, then subtract half its height	
		}
	}
}