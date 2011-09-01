package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	/**
	 * ...
	 * @author ...
	 */
	public class AdjacentRightAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = tcsRightEdge;
		}
		
	}

}