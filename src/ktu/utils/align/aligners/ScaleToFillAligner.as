/* MIT License

Copyright (c) 2012 ktu <ktu@cataclysmicrewind.com>

Permission is hereby granted, free of charge, to any person obtaining a 
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be 
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
THEAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
DEALINGS IN THE SOFTWARE.

*/
package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * ScaleToFillAligner makes all the targets fill the entire size of the target coordinate space object while maintaining the original width/height ratio.
	 * @author ktu
	 */
	public class ScaleToFillAligner implements IRectangleAligner {
		
		/**
		 * makes all the targets fill the entire size of the target coordinate space object while maintaining the original width/height ratio.
		 * 
		 * @param	targetCoordinateSpace 	the rectangle that will not change
		 * @param	targets					the rectangles you want to align
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsWidth:Number = targetCoordinateSpace.width;										//	grab width of tcs
			var tcsHeight:Number = targetCoordinateSpace.height;									//	grab height of tcs
			var tcsRatio:Number = tcsWidth / tcsHeight ;											// 	grab the aspect ratio of tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												//	loop (each target)
				var item:Rectangle = targets[i];													//		store ref to target
				var itemWHRatio:Number = item.width / item.height;									//		grab item w/h ratio
				var itemHWRatio:Number = item.height / item.width;									//		grab item h/w ratio
				if ( itemWHRatio > tcsRatio ) {														//		if (w/h ratio is greater)
					item.height = tcsHeight;														//			height of item is same as tcs height
					item.width = tcsHeight / itemHWRatio;											//			width of item is tcs height / h/w ratio)
				} else if ( itemWHRatio < tcsRatio ) {												//		if (w/h ratio is smaller)
					item.width = tcsWidth ;															//			width of item is same as tcs width
					item.height = tcsWidth / itemWHRatio;											//			height of item is tcs width / w/h ratio
				} else {																			//		else (same ratio)
					item.width = tcsWidth;															//			item width is tcs width
					item.height = tcsHeight;														//			item height is tcs height
				}																					//		end if
			}																						//	end loop
		}
	}
}