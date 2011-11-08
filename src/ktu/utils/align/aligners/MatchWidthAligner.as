

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * MatchWidthAligner makes all targets have the same width as the target coordinate space
	 * @author ktu
	 */
	public class MatchWidthAligner implements IRectangleAligner {
		
		/**
		 * makes all targets have the same width as the target coordinate space
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var endW:Number = targetCoordinateSpace.width;											//	grab the width of the tcs
			var length:int = targets.length;														//  targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 													//	loop (each target)
				targets[i].width = endW;															//		target width is tcs width
		}
	}
}