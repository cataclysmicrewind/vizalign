

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * ScaleToFitAligner makes all the targets match the size of the target coordinate space object while maintaining the original width/height ratio.
	 * @author ktu
	 */
	public class ScaleToFitAligner implements IRectangleAligner {
		
		/**
		 * makes all the targets match the size of the target coordinate space object while maintaining the original width/height ratio.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsWidth:Number = targetCoordinateSpace.width;										//	grab width of tcs
			var tcsHeight:Number = targetCoordinateSpace.height;									//	grab height of tcs
			var tcsRatio:Number = tcsWidth / tcsHeight ;											//	grab aspect ratio of tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												//	loop (each target)
				var item:Rectangle = targets[i];													//		grab item
				var itemWHRatio:Number = item.width / item.height;									//		grab item w/h ratio
				var itemHWRatio:Number = item.height / item.width;									//		grab item h/w ratio
				if ( itemWHRatio > tcsRatio ) {														//		if (item w/h > tcs ratio)
					item.width = tcsWidth ;															//			item width = tcs width
					item.height = tcsWidth / itemWHRatio;											//			item height = tcs width / item wh ratio
				} else if ( itemWHRatio < tcsRatio ) {												//		else (item w/h < tcs ratio)
					item.height = tcsHeight;														//			item height = tcs height
					item.width = tcsHeight / itemHWRatio;											//			item width = tcs height / item h/w ratio
				} else {																			//		else (same ratio)
					item.width = tcsWidth;															//			item width = tcs width
					item.height = tcsHeight;														//			item height = tcs height
				}																					//		end if
			}																						//	end loop
		}
	}
}