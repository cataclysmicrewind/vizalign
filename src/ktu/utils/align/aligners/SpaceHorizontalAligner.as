

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_left;
	
	/**
	 * SpaceHorizontalAligner evenly spaces the targets along the x axis inside of the target coordinate space
	 * @author ktu
	 */
	public class SpaceHorizontalAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();																// make new array becuase I am going to screw with the ordering
			targets = targets.sort ( sort_rectangle_left ) ;
			
			var objsWidth:Number = 0;
			var totalWidth:Number = targetCoordinateSpace.width;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				objsWidth += targets[i].width ;
			
			var spread:Number = ( totalWidth - objsWidth ) / ( length - 1 ) ;
			var right:Number = targetCoordinateSpace.left + targets[0].width;
			targets[0].x = targetCoordinateSpace.left;
			for ( var j:int = 1; j < length; j++ ) {
				targets[j].x = right + spread;
				right += targets[j].width + spread;
			}
		}
	}
}