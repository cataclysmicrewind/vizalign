

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_centerY;
	
	/**
	 * DistributeVerticalAligner places an even space between the y center of the targets inside the target coordinate space object.
	 * @author ktu
	 */
	public class DistributeVerticalAligner implements IRectangleAligner {
		
		/**
		 * places an even space between the y center of the targets inside the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();
			targets = targets.sort ( sort_rectangle_centerY ) ;
			
			var length:int = targets.length;														// targets length for optimized looping
			var first:Number = targetCoordinateSpace.top + ( targets[0].height / 2 ) ;
			var spread:Number = ( (  targetCoordinateSpace.bottom - ( targets[length - 1].height / 2 ) - first ) / ( length - 1 ) ) ;
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = first - ( targets[i].height / 2 ) + ( spread * i ) ;
			
		}
	}
}