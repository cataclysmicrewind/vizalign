package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_bottom;
	/**
	 * ...
	 * @author ...
	 */
	public class DistributeBottomAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();
			targets.sort ( sort_rectangle_bottom ) ;
			
			var length:int = targets.length;														// targets length for optimized looping
			var first:Number = targetCoordinateSpace.top + targets[0].height;
			var spread:Number = ( ( targetCoordinateSpace.bottom - first ) / ( length - 1 ) ) ;
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = first - targets[i].height + ( spread * i ) ;
		}
	}
}