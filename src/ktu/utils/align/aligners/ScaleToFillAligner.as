

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * ScaleToFillAligner makes all the targets fill the entire size of the target coordinate space object while maintaining the original width/height ratio.
	 * @author ktu
	 */
	public class ScaleToFillAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsWidth:Number = targetCoordinateSpace.width;
			var tcsHeight:Number = targetCoordinateSpace.height;
			var tcsRatio:Number = tcsWidth / tcsHeight ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var itemWidth:Number = item.width;
				var itemHeight:Number = item.height;
				var itemWHRatio:Number = itemWidth / itemHeight;
				var itemHWRatio:Number = itemHeight / itemWidth;
				if ( itemWHRatio > tcsRatio ) {
					item.height = tcsHeight;
					item.width = tcsHeight / itemHWRatio;
				} else if ( itemWHRatio < tcsRatio ) {
					item.width = tcsWidth ;
					item.height = tcsWidth / itemWHRatio;
				} else {
					item.width = tcsWidth;
					item.height = tcsHeight;
				}
			}
		}
	}
}