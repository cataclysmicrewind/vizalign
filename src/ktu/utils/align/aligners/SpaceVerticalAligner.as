

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_top;
	
	/**
	 * SpaceVerticalAligner evenly spaces the targets along the y axis inside of the target coordinate space
	 * @author ktu
	 */
	public class SpaceVerticalAligner implements IRectangleAligner {
		
		/**
		 * evenly spaces the targets along the y axis inside of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();																//	copy targets into new array so i do not ruin ordering
			targets = targets.sort ( sort_rectangle_top ) ;											//	sort targets by the top edge
			
			var targetTotalHeight:Number = 0;														//	total height of all targets
			var tcsTotalHeight:Number = targetCoordinateSpace.height;								//	total height of tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )													//	loop (each target)
				targetTotalHeight += targets[i].height;												//		add height of target to total
			
			var spread:Number = ( tcsTotalHeight - targetTotalHeight ) / ( length - 1 ) ;			//	the gap between each target
			var bottom:Number = targetCoordinateSpace.top + targets[0].height;						//	current bottom of the last placed target
			targets[0].y = targetCoordinateSpace.top;												//	place the first target
			for ( var j:int = 1; j < length; j++ ) {												//	loop (each target - first)
				var item:Rectangle = targets[j];													//		grab current target
				item.y = bottom + spread ;															//		target y = bottom of the last target plus spread
				bottom += item.height + spread ;													//		update bottom to include current placed target
			}																						//	end loop
		}
	}
}