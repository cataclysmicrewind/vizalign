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
	import ktu.utils.sorting.sort_rectangle_adjacentRight;
	import ktu.utils.sorting.sort_rectangle_adjacentLeft;
	
	/**
	 *  StackHorizontalAligner places all the targets flush against each other around the target coordinate space on the x axis
	 * @author ktu
	 */
	public class StackHorizontalAligner implements IRectangleAligner {
		
		/**
		 * places all the targets flush against each other around the target coordinate space on the x axis
		 * 
		 * @param	targetCoordinateSpace 	the rectangle that will not change
		 * @param	targets					the rectangles you want to align
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();																//	copy targets into new array so i do not ruin ordering
			var before:Array = new Array ( ) ;														// 	array to hold objects to the left of the tcs
			var after:Array = new Array ( ) ;														// 	array to hold objects to the right of the tcs
			var left:Number = 0;																	// 	holds where I placed the previous target for before array
			var right:Number = 0;																	// 	holds where I placed the previous target for after array
			var item:Rectangle;																		// 	var for holding current target
			var endX:Number;																		// 	endX is the value used for the placement of target
			var tcsLeftEdge:Number = targetCoordinateSpace.left;									// 	save left edge of tcs
			var tcsRightEdge:Number = targetCoordinateSpace.right;									// 	save right edge of tcs
			var tcsCenterX:Number = targetCoordinateSpace.left + (targetCoordinateSpace.width / 2);	// 	save the x center of the tcs
			// put targets in approriate array depending on position relative to the tcs
			for (var i:int = 0; i < targets.length; i++) {											// 	loop through all targets
				var target:Rectangle = targets[i];													//	grab ref to current target
				var targetCenterX:Number = target.left + (target.width / 2);						//	grab x center of target
				if ( targetCenterX < tcsCenterX ) {													//		if (x center of target < x center of tcs)
					before.push(targets[i]);														//			add to before array (targets sits to left of tcs)
				} else {																			// 		else
					after.push(targets[i]) ;														//			otherwise, add to after array
				}																					//		end if
			}																						// end loop
			before.sort ( sort_rectangle_adjacentRight ) ;											// sort before array
			after.sort ( sort_rectangle_adjacentLeft ) ;											// sort after array
			before.reverse ( ) ;																	// reverse the before array so its in the order I need
			var firstTarget:Rectangle;
			// place before array
			if (before.length > 0) {																// if at least one target before...
				firstTarget = before[0];															// 		save ref to first target in before array
				endX = tcsLeftEdge - firstTarget.width;												// 		first time, endX = the left edge of the tcs - width of first target
				left = tcsLeftEdge - firstTarget.width;												// 		first time, left = left edge of first target
				firstTarget.x = endX;																// 		move the first target because it requires diff math
				for ( i = 1; i < before.length; i++ ) {												// 		loop through all targets in before array
					item = before[i];																//			save ref to target
					endX = left - item.width;														//			this says the left - the width of item
					left -= item.width;																//			save the new left edge value of targets already aligned
					item.x = endX;																	//			apply the math
				}																					// 		end loop
			}																						// end if (before targets);
			// place after array
			if (after.length > 0) {																	// if at least on target after...
				firstTarget = after[0];																// 		save re to first target in after array
				endX = tcsRightEdge ;																// 		first time, endX = the right edge of tcs
				right = tcsRightEdge + firstTarget.width;											// 		first time, right = the right edge of first target after alignment
				firstTarget.x = endX;																// 		apply this math
				for ( i = 1; i < after.length; i++ ) {												// 		loop through all targets in after array
					item = after[i];																//			save ref to target
					endX = right;																	//			endX = right edge of last targed placed
					right += item.width;															//			update right = right edge of last placed target
					item.x = endX;																	//			apply the math
				}																					// 		end loop
			}																						// end if (after targets);
		}
	}
}