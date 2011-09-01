package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	/**
	 * ...
	 * @author ...
	 */
	public class BottomRightAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var target:Rectangle = targets[i];
				target.x = tcsRightEdge - target.width;
				target.y = tcsBottomEdge - target.width;
			}
		}
		
	}

}