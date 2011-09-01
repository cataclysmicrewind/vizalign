package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_top;
	/**
	 * ...
	 * @author ...
	 */
	public class SpaceVerticalAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();
			targets = targets.sort ( sort_rectangle_top ) ;
			
			var objsHeight:Number = 0;
			var totalHeight:Number = targetCoordinateSpace.height;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				objsHeight += targets[i].height;
			
			var spread:Number = ( totalHeight - objsHeight ) / ( length - 1 ) ;
			var bottom:Number = targetCoordinateSpace.top + targets[0].height;
			targets[0].y = targetCoordinateSpace.top;
			for ( var j:int = 1; j < length; j++ ) {
				targets[j].y = bottom + spread ;
				bottom += targets[j].height + spread ;
			}
		}
	}
}