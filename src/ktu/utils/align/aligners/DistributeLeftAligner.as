

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_left;
	
	/**
	 * DistributeLeftAligner places an even space between the left edge of the targets inside the target coordinate space object.
	 * @author ktu
	 */
	public class DistributeLeftAligner implements IRectangleAligner {
		
		/**
		 * places an even space between the left edge of the targets inside the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();
			targets = targets.sort ( sort_rectangle_left ) ;
			
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var spread:Number = (targetCoordinateSpace.width - targets[targets.length - 1].width) / (targets.length - 1);
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].x = tcsLeftEdge + (spread * i) ;
		}
	}
}