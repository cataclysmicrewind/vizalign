package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_adjacentRight;
	import ktu.utils.sorting.sort_rectangle_adjacentLeft;
	/**
	 * ...
	 * @author ...
	 */
	public class StackHorizontalAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();
			var before:Array = new Array ( ) ;													// array to hold objects to the left of the tcs
			var after:Array = new Array ( ) ;													// array to hold objects to the right of the tcs
			var left:Number = 0;																// holds where I placed the previous target for before array
			var right:Number = 0;																// holds where I placed the previous target for after array
			var item:Rectangle;																	// var for holding current target
			var endX:Number;																	// endX is the value used for the placement of target
			var tcsLeftEdge:Number = targetCoordinateSpace.left;								// save left edge of tcs
			var tcsRightEdge:Number = targetCoordinateSpace.right;								// save right edge of tcs
			var tcsCenterX:Number = targetCoordinateSpace.left + (targetCoordinateSpace.width / 2);// save the centerX value of the tcs
			// put targets in approriate array depending on position relative to the tcs
			for (var i:int = 0; i < targets.length; i++) {										// loop through all targets
				var target:Rectangle = targets[i];
				var targetCenterX:Number = target.left + (target.width / 2);
				if ( targetCenterX < tcsCenterX ) {												//		If the centerX of target is < centerX of tcs
					before.push(targets[i]);													//			add to before array (targets sits to left of tcs)
				} else {																		// 		else
					after.push(targets[i]) ;													//			otherwise, add to after array
				}																				//		end if
			}																					// end loop
			before.sort ( sort_rectangle_adjacentRight ) ;													// sort before array
			after.sort ( sort_rectangle_adjacentLeft ) ;													// sort after array
			before.reverse ( ) ;																// reverse the before array so its in the order I need
			var firstTarget:Rectangle;
			// place before array
			if (before.length > 0) {															// if at least one target before...
				firstTarget = before[0];														// 		save ref to first target in before array
				endX = tcsLeftEdge - firstTarget.width;											// 		first time, endX = the left edge of the tcs - width of first target
				left = tcsLeftEdge - firstTarget.width;											// 		first time, left = left edge of first target
				firstTarget.x = endX;															// 		move the first target because it requires diff math
				for ( i = 1; i < before.length; i++ ) {											// 		loop through all targets in before array
					item = before[i];															//			save ref to target
					endX = left - item.width;													//			this says the left - the width of item
					left -= item.width;															//			save the new left edge value of targets already aligned
					item.x = endX;																//			apply the math
				}																				// 		end loop
			}																					// end if (before targets);
			// place after array
			if (after.length > 0) {																// if at least on target after...
				firstTarget = after[0];															// 		save re to first target in after array
				endX = tcsRightEdge ;															// 		first time, endX = the right edge of tcs
				right = tcsRightEdge + firstTarget.width;										// 		first time, right = the right edge of first target after alignment
				firstTarget.x = endX;															// 		apply this math
				for ( i = 1; i < after.length; i++ ) {											// 		loop through all targets in after array
					item = after[i];															//			save ref to target
					endX = right;																//			endX = right edge of last targed placed
					right += item.width;														//			update right = right edge of last placed target
					item.x = endX;																//			apply the math
				}																				// 		end loop
			}																					// end if (after targets);
		}
	}
}