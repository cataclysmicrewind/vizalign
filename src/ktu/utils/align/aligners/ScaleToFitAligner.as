package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	/**
	 * ...
	 * @author ...
	 */
	public class ScaleToFitAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsWidth:Number = targetCoordinateSpace.width;
			var tcsHeight:Number = targetCoordinateSpace.height;
			var tcsRatio:Number = tcsWidth / tcsHeight ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var itemWHRatio:Number = item.width / item.height;
				var itemHWRatio:Number = item.height / item.width;
				if ( itemWHRatio > tcsRatio ) {
					item.width = tcsWidth ;
					item.height = tcsWidth / itemWHRatio;
				} else if ( itemWHRatio < tcsRatio ) {
					item.height = tcsHeight;
					item.width = tcsHeight / itemHWRatio;
				} else {
					item.width = tcsWidth;
					item.height = tcsHeight;
				}
			}
		}
		
	}

}