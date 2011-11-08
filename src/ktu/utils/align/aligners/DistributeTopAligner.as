package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_top;
	/**
	 * DistributeTopAligner places an even space between the top edge of the targets inside the target coordinate space object.
	 * @author ...
	 */
	public class DistributeTopAligner implements IRectangleAligner {
		
		/**
		 * places an even space between the top edge of the targets inside the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();																//	copy targets into new array so i do not ruin ordering
			targets = targets.sort ( sort_rectangle_top ) ;											//	sort by top
			
			var length:int = targets.length;														// 	targets length for optimized looping
			var first:Number = targetCoordinateSpace.top;											//	
			var spread:Number = ( targetCoordinateSpace.bottom - targets[length - 1].height - first ) / ( length - 1 ) ;
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = first + ( spread * i ) ;
			
		}
	}
}