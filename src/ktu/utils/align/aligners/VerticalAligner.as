

package ktu.utils.align.aligners {
	
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * VerticalAligner aligns the y center of each target to match the y center of the target coordinate space
	 * @author ktu
	 */
	public class VerticalAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var mid:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height / 2);
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].y = mid - ( targets[i].height / 2 );
		}
	}
}