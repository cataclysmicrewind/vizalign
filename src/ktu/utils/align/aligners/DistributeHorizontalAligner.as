package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_centerX;
	/**
	 * ...
	 * @author ...
	 */
	public class DistributeHorizontalAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();
			targets.sort ( sort_rectangle_centerX ) ;
			
			var first:Number = targetCoordinateSpace.left + (targets[0].width / 2);
			var last:Number = targetCoordinateSpace.right - (targets[targets.length - 1].width / 2) ;
			var spread:Number = ((last - first) / targets.length - 1) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = first - ( targets[i].width / 2 ) + ( spread * i ) ;
		}
	}
}