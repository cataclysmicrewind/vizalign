

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * BottomAligner aligns each target so the bottom edge matches the bottom edge of the target coordinate space
	 * @author ktu
	 */
	public class BottomAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom; 
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = tcsBottomEdge - targets[i].height;
		}
	}
}