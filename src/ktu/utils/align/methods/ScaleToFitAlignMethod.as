package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class ScaleToFitAlignMethod extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
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