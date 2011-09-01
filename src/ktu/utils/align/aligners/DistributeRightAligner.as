package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_right;
	/**
	 * ...
	 * @author ...
	 */
	public class DistributeRightAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();
			targets.sort ( sort_rectangle_right ) ;
			
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var first:Number = tcsLeftEdge + targets[0].width;
			var spread:Number = ( ( targetCoordinateSpace.right - first ) / ( targets.length - 1 ) ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = first - targets[i].width + ( spread * i ) ;
		}
	}
}