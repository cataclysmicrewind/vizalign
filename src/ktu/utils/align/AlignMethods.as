/**
 * 
 * 
 * 
 */
package ktu.utils.align {
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.VizAlign;
	import ktu.utils.SortRectangleUtils;
	
	/**
	 * 	
	 * 	This class contains all of the functions that will align rectangles.
	 * 
	 * 	each method has the same signature, a targetCoordinateSpace:Rectangle, and targets:Array of Rectangle
	 *		the method will take all of the targets and align them to the targetCoordinateSpace.
	 * 
	 * 
	 * 	If you wish to add your own, or create your own, keep the same signature and follow this basic logic for aligning:
	 * 		Copy array of targets into new array (so not to mess with the original array)
	 * 		If sorting, create a dictionary to hold onto the original order
	 * 		Loop through all targets and apply math to them
	 * 		if sorted, return original order with dictionary
	 * 		return new array of targets
	 * 
	 * 
	 */
	public class AlignMethods {
		/*
		*
		**************
		*  Align: x  *
		**************
		*/
		public static function left ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsLeftEdge:Number = targetCoordinateSpace.left;									// get left edge of target coordinate space object
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 												// loop through all targets
				targets[i].x = tcsLeftEdge;									// 		grab current target and set its x value
		}
		public static function horizontal ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var mid:Number = targetCoordinateSpace.left + (targetCoordinateSpace.width / 2);		// get center x value of target coordinate space object
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )												// loop through all targets
				targets[i].x = mid - (targets[i].width / 2);											// 		grab current target as item
		}
		public static function right ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsRightEdge:Number = targetCoordinateSpace.right;									// get right edge of target coordinate space object
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 												// loop through all targets
				targets[i].x = tcsRightEdge - targets[i].width;													// 		grab current target as item
		}
		/*
		*
		************
		*  Center  *
		************
		*/
		public static function center (targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsCenterX:Number = targetCoordinateSpace.left + (targetCoordinateSpace.width / 2);	// get center x value of target coordinate space object
			var tcsCenterY:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height/ 2);
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												// loop through all targets
				var target:Rectangle = targets[i];													// 		grab current target as item
				target.x = tcsCenterX - (target.width / 2);																	// 		apply math to target
				target.y = tcsCenterY - (target.height / 2);
			}																						// end loop
		};
		/*
		*
		**************
		*  Align: y  *
		**************
		*/
		public static function top ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].y = tcsTopEdge;
		}
		public static function vertical ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var mid:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height / 2);
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].y = mid - ( targets[i].height / 2 );
		}
		public static function bottom ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom; 
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = tcsBottomEdge - targets[i].height;
		}
		/*
		*
		****************
		*  Combo: x,y  *
		****************
		*/
		public static function topLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				targets[i].x = tcsLeftEdge;
				targets[i].y = tcsTopEdge;
			}
		}
		public static function topRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				targets[i].x = tcsRightEdge - targets[i].width;
				targets[i].y = tcsTopEdge;
			}
		}
		public static function bottomLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				targets[i].x = tcsLeftEdge;
				targets[i].y = tcsBottomEdge - targets[i].height;
			}
		}
		public static function bottomRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var target:Rectangle = targets[i];
				target.x = tcsRightEdge - target.width;
				target.y = tcsBottomEdge - target.width;
			}
		}
		/*
		*
		*****************
		*  Adjacent: x  *
		*****************
		*/
		public static function adjacentLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].x = tcsLeftEdge - targets[i].width;
		}
		public static function adjacentHorizontalLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsCenterX:Number = targetCoordinateSpace.left + targetCoordinateSpace.width / 2;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = tcsCenterX - targets[i].width;
		}
		public static function adjacentHorizontalRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsCenterX:Number = targetCoordinateSpace.left + targetCoordinateSpace.width / 2;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = tcsCenterX;
		}
		public static function adjacentRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = tcsRightEdge;
		}
		/*
		*
		*****************
		*  Adjacent: y  *
		*****************
		*/
		public static function adjacentTop ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/ ) :void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var length:int = targets.length;													// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = tcsTopEdge - targets[i].height;
		}
		public static function adjacentVerticalTop ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsCenterY:Number = targetCoordinateSpace.top + targetCoordinateSpace.height / 2;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].y = tcsCenterY - targets[i].height;
		}
		public static function adjacentVerticalBottom ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsCenterY:Number = targetCoordinateSpace.top + targetCoordinateSpace.height / 2;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].y = tcsCenterY;
		}
		public static function adjacentBottom ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var length:int = targets.length;													// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].y = tcsBottomEdge;
		}
		/*
		*
		*************************
		*  Combo Adjacent: x,y  *
		*************************
		*/
		public static function adjacentTopLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var target:Rectangle = targets[i];
				target.x = tcsLeftEdge - target.width;
				target.y = tcsTopEdge - target.height;
			}
		}
		public static function adjacentTopRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var target:Rectangle = targets[i];
				target.x = tcsRightEdge;
				target.y = tcsTopEdge - target.height;
			}
		}
		public static function adjacentBottomLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var target:Rectangle = targets[i];
				target.x = tcsLeftEdge - target.width;
				target.y = tcsBottomEdge;
			}
		}
		public static function adjacentBottomRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				item.x = tcsRightEdge;
				item.y = tcsBottomEdge;
			}
		}
		/*
		*
		*******************
		*  Distribute: x  *
		*******************
		*/
		public static function distLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var origOrderedDic:Dictionary = VizAlign.preserveOrderWithDictionary(targets);
			targets = targets.sort ( SortRectangleUtils.sortGlobalX ) ;
			
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var spread:Number = (targetCoordinateSpace.width - targets[targets.length - 1].width) / (targets.length - 1);
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].x = tcsLeftEdge + (spread * i) ;
				
			VizAlign.reorderArray(targets, origOrderedDic);
		}
		public static function distHorizontal ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var origOrderedDic:Dictionary = VizAlign.preserveOrderWithDictionary(targets);
			targets = targets.sort ( SortRectangleUtils.sortGlobalCenterX ) ;
			
			var first:Number = targetCoordinateSpace.left + (targets[0].width / 2);
			var last:Number = targetCoordinateSpace.right - (targets[targets.length - 1].width / 2) ;
			var spread:Number = ((last - first) / targets.length - 1) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = first - ( targets[i].width / 2 ) + ( spread * i ) ;
			
			VizAlign.reorderArray(targets, origOrderedDic);
		}
		public static function distRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/ ) :void {
			var origOrderedDic:Dictionary = VizAlign.preserveOrderWithDictionary(targets);
			targets = targets.sort ( SortRectangleUtils.sortGlobalRight ) ;
			
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var first:Number = tcsLeftEdge + targets[0].width;
			var spread:Number = ( ( targetCoordinateSpace.right - first ) / ( targets.length - 1 ) ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = first - targets[i].width + ( spread * i ) ;
			
			VizAlign.reorderArray(targets, origOrderedDic);
		};
		/*
		*
		*******************
		*  Distribute: y  *
		*******************
		*/
		public static function distTop ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var origOrderedDic:Dictionary = VizAlign.preserveOrderWithDictionary(targets);
			targets = targets.sort ( SortRectangleUtils.sortGlobalY ) ;
			
			var length:int = targets.length;														// targets length for optimized looping
			var first:Number = targetCoordinateSpace.top;
			var spread:Number = ( targetCoordinateSpace.bottom - targets[length - 1].height - first ) / ( length - 1 ) ;
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = first + ( spread * i ) ;
			
			VizAlign.reorderArray(targets, origOrderedDic);
		}
		public static function distVertical ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var origOrderedDic:Dictionary = VizAlign.preserveOrderWithDictionary(targets);
			targets = targets.sort ( SortRectangleUtils.sortGlobalCenterY ) ;
			
			var length:int = targets.length;														// targets length for optimized looping
			var first:Number = targetCoordinateSpace.top + ( targets[0].height / 2 ) ;
			var spread:Number = ( (  targetCoordinateSpace.bottom - ( targets[length - 1].height / 2 ) - first ) / ( length - 1 ) ) ;
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = first - ( targets[i].height / 2 ) + ( spread * i ) ;
			
			VizAlign.reorderArray(targets, origOrderedDic);
		}
		public static function distBottom ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var origOrderedDic:Dictionary = VizAlign.preserveOrderWithDictionary(targets);
			targets.sort ( SortRectangleUtils.sortGlobalBottom ) ;
			
			var length:int = targets.length;														// targets length for optimized looping
			var first:Number = targetCoordinateSpace.top + targets[0].height;
			var spread:Number = ( ( targetCoordinateSpace.bottom - first ) / ( length - 1 ) ) ;
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = first - targets[i].height + ( spread * i ) ;
			
			VizAlign.reorderArray(targets,origOrderedDic);
		}
		/*
		*
		*****************
		*  Match Sizes  *
		*****************
		*/
		public static function matchWidth ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var endW:Number = targetCoordinateSpace.width;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].width = endW;
		}
		public static function matchHeight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var endH:Number = targetCoordinateSpace.height;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].height = endH;
		}
		public static function matchSize ( targetCoordinateSpace:Rectangle, targets:Array ) :void {
			var endW:Number = targetCoordinateSpace.width;
			var endH:Number = targetCoordinateSpace.height;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				targets[i].width = endW;
				targets[i].height = endH;
			}
		}
		public static function scaleToFit ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
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
		public static function scaleToFill ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
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
		/*
		*
		******************
		*  Space Evenly  *
		******************
		*/
		public static function spaceVertical ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var origOrderedDic:Dictionary = VizAlign.preserveOrderWithDictionary(targets);
			targets = targets.sort ( SortRectangleUtils.sortGlobalY ) ;
			
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
			VizAlign.reorderArray(targets, origOrderedDic);
		}
		public static function spaceHorizontal ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var origOrderedDic:Dictionary = VizAlign.preserveOrderWithDictionary(targets);
			targets = targets.sort ( SortRectangleUtils.sortGlobalX ) ;
			
			var objsWidth:Number = 0;
			var totalWidth:Number = targetCoordinateSpace.width;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				objsWidth += targets[i].width ;
			
			var spread:Number = ( totalWidth - objsWidth ) / ( length - 1 ) ;
			var right:Number = targetCoordinateSpace.left + targets[0].width;
			targets[0].x = targetCoordinateSpace.left;
			for ( var j:int = 1; j < length; j++ ) {
				targets[j] = right + spread;
				right += targets[j].width + spread;
			}
			VizAlign.reorderArray(targets, origOrderedDic);
		}
		/*
		*
		***********
		*  Stack  *
		***********
		*/
		public static function stackVertical ( targetCoordinateSpace:Rectangle, targets:Array /*Rectangle*/) :void {
			var origOrderedDic:Dictionary = VizAlign.preserveOrderWithDictionary(targets);
			
			var above:Array = new Array ( ) ;
			var below:Array = new Array ( ) ;
			var tcsCenterY:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height / 2);
			for ( var i:int = 0; i < targets.length; i++ ) {
				var target:Rectangle = targets[i];
				var targetCenterY:Number = target.top + (target.height / 2);
				if ( targetCenterY < tcsCenterY )
					above.push (targets[i]) ;
				else
					below.push (targets[i]) ;
			}
			above.sort ( SortRectangleUtils.sortAdjacentBottom ) ;
			below.sort ( SortRectangleUtils.sortAdjacentTop ) ;
			above.reverse ( ) ;
			var top:Number = 0;
			var bottom:Number = 0;
			var item:Rectangle;
			var endY:Number;
			for ( var j:int = 0; j < above.length; j++ ) {
				 item = above[j]
				if ( j != 0 ) {
					endY = top - item.height;
					top -= item.height;
				} else {
					endY = targetCoordinateSpace.top - item.height;
					top = targetCoordinateSpace.top - item.height ;
				}
				item.y = endY;
			}
			for ( var k:int = 0; k < below.length; k++ ) {
				item = below[k];
				endY = 0;
				if ( k != 0 ) {
					endY = bottom;
					bottom += item.height;
				} else {
					endY = targetCoordinateSpace.bottom;
					bottom = targetCoordinateSpace.bottom;
				}
				item.y = endY;
			}
			above.reverse ( ) ;
			targets = above;
			targets = targets.concat ( below ) ;
			VizAlign.reorderArray(targets, origOrderedDic);
		}
		public static function stackHorizontal ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :void {
			var origOrderedDic:Dictionary = VizAlign.preserveOrderWithDictionary(targets);
			
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
			before.sort ( SortRectangleUtils.sortAdjacentRight ) ;									// sort before array
			after.sort ( SortRectangleUtils.sortAdjacentLeft ) ;									// sort after array
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
			//reset & return
			targets = before;																	// targets = before array
			targets = targets.concat ( after ) ;												// targets = before array + after array
			VizAlign.reorderArray(targets, origOrderedDic);									// reorder targets
		}
	}
}