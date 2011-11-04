

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * MatchWidthAligner makes all targets have the same width as the target coordinate space
	 * @author ktu
	 */
	public class MatchWidthAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var endW:Number = targetCoordinateSpace.width;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].width = endW;
		}
	}
}