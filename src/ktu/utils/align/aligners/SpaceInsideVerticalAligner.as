

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_top;
	
	/**
	 * SpaceHorizontalAligner evenly spaces the targets along the x axis inside of the target coordinate space
	 * @author ktu
	 */
	public class SpaceInsideVerticalAligner implements IRectangleAligner {
		
		/**
		 * evenly spaces the targets along the x axis inside of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();																// 	copy targets into new array so i do not ruin ordering
			targets = targets.sort ( sort_rectangle_top ) ;											//	sort targets on top edge
			
			var objsHeight:Number = 0;																//	total height of all targets
			var totalHeight:Number = targetCoordinateSpace.height;									//	total height of tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )	 												//	loop (each target)
				objsHeight += targets[i].height ;													//		add height of target to total targets height
			
			var spread:Number = ( totalHeight - objsHeight ) / ( length + 1 ) ;						//	the gap between each target
			var bottom:Number = targetCoordinateSpace.top											//	current right edge of the last placed target
			for ( var j:int = 0; j < length; j++ ) {												//	loop (each target - first)
				var target:Rectangle = targets[j];													//		grab current item
				target.y = bottom + spread;															//		place item at right edge plus spread
				bottom += target.height + spread;														//		update right edge to include current item
			}																						//	end loop
		}
	}
}