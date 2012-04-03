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
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_adjacentTop;
	import ktu.utils.sorting.sort_rectangle_adjacentBottom;
	
	/**
	 * StackVerticalAligner places all the targets flush against each other around the target coordinate space on the y axis
	 * @author ktu
	 */
	public class StackVerticalAligner implements IRectangleAligner {
		
		/**
		 * places all the targets flush against each other around the target coordinate space on the y axis
		 * 
		 * @param	targetCoordinateSpace 	the rectangle that will not change
		 * @param	targets					the rectangles you want to align
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();																// 	copy targets into new array so i do not ruin ordering
			var above:Array = new Array ( ) ;														//	array to hold objects aobve of the tcs
			var below:Array = new Array ( ) ;														//	array to hold objects to the left of the tcs
			var tcsCenterY:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height / 2);	//	grab the center y of the tcs
			for ( var i:int = 0; i < targets.length; i++ ) {										//	for (each target)
				var target:Rectangle = targets[i];													//		grab target
				var targetCenterY:Number = target.top + (target.height / 2);						//		grab target center y
				if ( targetCenterY < tcsCenterY )													//		if (target center y < tcs center y)
					above.push (targets[i]) ;														//			place target in above array
				else																				//		else 
					below.push (targets[i]) ;														//			place target in below array
			}																						//	end loop
			above.sort ( sort_rectangle_adjacentTop ) ;												//	sort above array by adjacent top
			below.sort ( sort_rectangle_adjacentBottom ) ;											//	sort below array by adjacent bottom
			above.reverse ( ) ;																		//	reverse the above array so we go from center out
			var top:Number = 0;																		//	holds where I placed the previous target for above array
			var bottom:Number = 0;																	//	holds where I placed the previous target for below array
			var item:Rectangle;																		//	current item (i have two loops that use this)
			var endY:Number;																		//	endY is the value used to place the target
			for ( var j:int = 0; j < above.length; j++ ) {											//	loop (each target above tcs)
				 item = above[j]																	//		grab item
				if ( j != 0 ) {																		//		if (not first target)
					endY = top - item.height;														//			endY is the top - item height
					top -= item.height;																//			top -= item height (we are starting at the tcs and going up)
				} else {																			//		else (is frist target)
					endY = targetCoordinateSpace.top - item.height;									//			endY = tcs top - item height
					top = targetCoordinateSpace.top - item.height ;									//			top = tcs top - item height
				}																					//		end if
				item.y = endY;																		//		place target at endY
			}																						//	end loop
			for ( var k:int = 0; k < below.length; k++ ) {											//	loop (each target below tcs)
				item = below[k];																	//		grab item
				if ( k != 0 ) {																		//		if (not first target)
					endY = bottom;																	//			endY is the bottom
					bottom += item.height;															//			bottom += item height
				} else {																			//		else (is first target)
					endY = targetCoordinateSpace.bottom;											//			endY is the bottom of the tcs
					bottom = targetCoordinateSpace.bottom;											//			bottom is the tcs bottom
				}																					//		end it
				item.y = endY;																		//		place target at endY
			}																						//	end loop
		}
	}
}