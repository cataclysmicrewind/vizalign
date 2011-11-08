

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_centerX;
	
	/**
	 * DistributeHorizontalAligner places an even space between the x center of the targets inside the target coordinate space object.
	 * @author ktu
	 */
	public class DistributeHorizontalAligner implements IRectangleAligner {
		
		/**
		 * places an even space between the x center of the targets inside the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
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