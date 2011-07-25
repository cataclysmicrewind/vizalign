/**
 * 
 * 
 * 
 */
package ktu.utils.align {
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.ArrayUtils;
	import ktu.utils.RectangleUtils;
	
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
		public static function left ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):Array {
			var tcsLeftEdge:Number = targetCoordinateSpace.left;									// get left edge of target coordinate space object
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												// loop through all targets
				var target:Rectangle = targets[i];													// 		grab current target as item
				var endX:Number = tcsLeftEdge;														// 		calculate end x value for current item
				target.x = endX;																	// 		apply math to target
			}																						// end loop
			return targets;																			// return new array
		}
		public static function horizontal ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var mid:Number = targetCoordinateSpace.left + (targetCoordinateSpace.width / 2);		// get center x value of target coordinate space object
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												// loop through all targets
				var target:Rectangle = targets[i];													// 		grab current target as item
				var endX:Number = mid - (target.width / 2) ;										// 		calculate end x value for current item
				target.x = endX;																	// 		apply math to target
			}																						// end loop
			return targets;																			// return array
		};
		public static function right ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsRightEdge:Number = targetCoordinateSpace.right;									// get right edge of target coordinate space object
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												// loop through all targets
				var target:Rectangle = targets[i];													// 		grab current target as item
				var endX:Number = tcsRightEdge - target.width;										// 		calculate end x value for current item
				target.x = endX;																	// 		apply math to target
			}																						// end loop
			return targets;																			// return array
		};
		/*
		*
		************
		*  Center  *
		************
		*/
		public static function center (targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):Array {
			var tcsCenterX:Number = targetCoordinateSpace.left + (targetCoordinateSpace.width / 2);	// get center x value of target coordinate space object
			var tcsCenterY:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height/ 2);
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												// loop through all targets
				var target:Rectangle = targets[i];													// 		grab current target as item
				var endX:Number = tcsCenterX - (target.width / 2);									// 		calculate end x value for current item
				var endY:Number = tcsCenterY - (target.height / 2);
				target.x = endX;																	// 		apply math to target
				target.y = endY;
			}																						// end loop
			return targets;	
		};
		/*
		*
		**************
		*  Align: y  *
		**************
		*/
		public static function top ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endY:Number = tcsTopEdge;
				item.y = endY;
			}
			return targets;
		}
		public static function vertical ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var mid:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height / 2);
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endY:Number = mid - ( item.height / 2 ) ;
				item.y = endY;
			}
			return targets;
		}
		public static function bottom ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom; 
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endY:Number = tcsBottomEdge - item.height;
				item.y = endY;
			}
			return targets;
		}
		/*
		*
		****************
		*  Combo: x,y  *
		****************
		*/
		public static function topLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):Array {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsLeftEdge;														// calculate end x value for current item
				var endY:Number = tcsTopEdge;														// calculate end y value for current item
				item.x = endX;																		// apply math to target
				item.y = endY;																		// apply maht to target
			}
			return targets;
		}
		public static function topRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):Array {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsRightEdge - item.width;										// calculate end x value for current item
				var endY:Number = tcsTopEdge;														// calculate end y value for current item
				item.x = endX;																		// apply math to target
				item.y = endY;																		// apply maht to target
			}
			return targets;
		}
		public static function bottomLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):Array {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsLeftEdge;														// calculate end x value for current item
				var endY:Number = tcsBottomEdge - item.height;
				item.x = endX;																		// apply math to target
				item.y = endY;																		// apply maht to target
			}
			return targets;
		}
		public static function bottomRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):Array {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsRightEdge - item.width;										// calculate end x value for current item
				var endY:Number = tcsBottomEdge - item.width;
				item.x = endX;																		// apply math to target
				item.y = endY;																		// apply maht to target
			}
			return targets;
		}
		/*
		*
		*****************
		*  Adjacent: x  *
		*****************
		*/
		public static function adjacentLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsLeftEdge - item.width;
				item.x = endX;
			}
			return targets;
		}
		public static function adjacentHorizontalLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsCenterX:Number = targetCoordinateSpace.left + targetCoordinateSpace.width / 2;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsCenterX - item.width;
				item.x = endX;
			}
			return targets;
		}
		public static function adjacentHorizontalRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsCenterX:Number = targetCoordinateSpace.left + targetCoordinateSpace.width / 2;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsCenterX;
				item.x = endX;
			}
			return targets;
		}
		public static function adjacentRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsRightEdge;
				item.x = endX;
			}
			return targets;
		}
		/*
		*
		*****************
		*  Adjacent: y  *
		*****************
		*/
		public static function adjacentTop ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/ ) :Array {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var length:int = targets.length;													// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endY:Number = tcsTopEdge - item.height;
				item.y = endY;
			}
			return targets;
		}
		public static function adjacentVerticalTop ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsCenterY:Number = targetCoordinateSpace.top + targetCoordinateSpace.height / 2;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endY:Number = tcsCenterY - item.height;
				item.y = endY;
			}
			return targets;
		}
		public static function adjacentVerticalBottom ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsCenterY:Number = targetCoordinateSpace.top + targetCoordinateSpace.height / 2;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endY:Number = tcsCenterY;
				item.y = endY;
			}
			return targets;
		}
		public static function adjacentBottom ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var length:int = targets.length;													// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endY:Number = tcsBottomEdge;
				item.y = endY;
			}
			return targets;
		}
		/*
		*
		*************************
		*  Combo Adjacent: x,y  *
		*************************
		*/
		public static function adjacentTopLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsLeftEdge - item.width;
				var endY:Number = tcsTopEdge - item.height;
				item.x = endX;
				item.y = endY;
			}
			return targets;
		}
		public static function adjacentTopRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsRightEdge;
				var endY:Number = tcsTopEdge - item.height;
				item.x = endX;
				item.y = endY;
			}
			return targets;
		}
		public static function adjacentBottomLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsLeftEdge - item.width;
				var endY:Number = tcsBottomEdge;
				item.x = endX;
				item.y = endY;
			}
			return targets;
		}
		public static function adjacentBottomRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsRightEdge;
				var endY:Number = tcsBottomEdge;
				item.x = endX;
				item.y = endY;
			}
			return targets;
		}
		/*
		*
		*******************
		*  Distribute: x  *
		*******************
		*/
		public static function distLeft ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var origOrderedDic:Dictionary = ArrayUtils.preserveOrderWithDictionary(targets);
			
			targets = targets.sort ( RectangleUtils.sortGlobalX ) ;
			var lastIndex:int = targets.length - 1;
			var lastTarget:Rectangle = targets[lastIndex];
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var spread:Number = (targetCoordinateSpace.width - lastTarget.width) / (lastIndex);
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = tcsLeftEdge + (spread * i) ;
				item.x = endX;
			}
			return ArrayUtils.reorderArray(targets, origOrderedDic);
		}
		public static function distHorizontal ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var origOrderedDic:Dictionary = ArrayUtils.preserveOrderWithDictionary(targets);
			
			targets = targets.sort ( RectangleUtils.sortGlobalCenterX ) ;
			var lastIndex:int = targets.length - 1;
			var first:Number = targetCoordinateSpace.left + (targets[0].width / 2);
			var last:Number = targetCoordinateSpace.right - (targets[lastIndex].width / 2) ;
			var spread:Number = ((last - first) / lastIndex) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = first - ( item.width / 2 ) + ( spread * i ) ;
				item.x = endX;
			}
			return ArrayUtils.reorderArray(targets, origOrderedDic);
		};
		public static function distRight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/ ) :Array {
			var origOrderedDic:Dictionary = ArrayUtils.preserveOrderWithDictionary(targets);
			
			targets = targets.sort ( RectangleUtils.sortGlobalRight ) ;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var first:Number = tcsLeftEdge + targets[0].width;
			var last:Number = targetCoordinateSpace.right;
			var spread:Number = ( ( last - first ) / ( targets.length - 1 ) ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endX:Number = first - item.width + ( spread * i ) ;
				item.x = endX;
			}
			return targets;
		};
		/*
		*
		*******************
		*  Distribute: y  *
		*******************
		*/
		public static function distTop ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var origOrderedDic:Dictionary = ArrayUtils.preserveOrderWithDictionary(targets);
			
			targets = targets.sort ( RectangleUtils.sortGlobalY ) ;
			var lastIndex:int = targets.length - 1;
			var first:Number = targetCoordinateSpace.top;
			var last:Number = targetCoordinateSpace.bottom - targets[lastIndex].height;
			var spread:Number = ( last - first ) / ( lastIndex ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endY:Number = first + ( spread * i ) ;
				item.y = endY;
			}
			return ArrayUtils.reorderArray(targets, origOrderedDic);
		}
		public static function distVertical ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var origOrderedDic:Dictionary = ArrayUtils.preserveOrderWithDictionary(targets);
			
			targets = targets.sort ( RectangleUtils.sortGlobalCenterY ) ;
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var first:Number = tcsTopEdge + ( targets[0].height / 2 ) ;
			var last:Number = targetCoordinateSpace.bottom - ( targets[targets.length - 1].height / 2 ) ;
			var spread:Number = ( ( last - first ) / ( targets.length - 1 ) ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endY:Number = first - ( item.height / 2 ) + ( spread * i ) ;
				item.y = endY;
			}
			return ArrayUtils.reorderArray(targets, origOrderedDic);
		}
		public static function distBottom ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var origOrderedDic:Dictionary = ArrayUtils.preserveOrderWithDictionary(targets);
			
			targets.sort ( RectangleUtils.sortGlobalBottom ) ;
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var first:Number = tcsTopEdge + targets[0].height;
			var last:Number = targetCoordinateSpace.bottom;
			var spread:Number = ( ( last - first ) / ( targets.length - 1 ) ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				var endY:Number = first - item.height + ( spread * i ) ;
				item.y = endY;
			}
			return ArrayUtils.reorderArray(targets,origOrderedDic);
		};
		/*
		*
		*****************
		*  Match Sizes  *
		*****************
		*/
		public static function matchWidth ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var endW:Number = targetCoordinateSpace.width;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				item.width = endW;
			}
			return targets;
		}
		public static function matchHeight ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var endH:Number = targetCoordinateSpace.height;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				item.height = endH;
			}
			return targets;
		}
		public static function matchSize ( targetCoordinateSpace:Rectangle, targets:Array ) :Array {
			var endW:Number = targetCoordinateSpace.width;
			var endH:Number = targetCoordinateSpace.height;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				item.width = endW;
				item.height = endH;
			}
			return targets;
		}
		public static function scaleToFit ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
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
			return targets;
		}
		public static function scaleToFill ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
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
			return targets;
		}
		/*
		*
		******************
		*  Space Evenly  *
		******************
		*/
		public static function spaceVertical ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var origOrderedDic:Dictionary = ArrayUtils.preserveOrderWithDictionary(targets);
			
			targets = targets.sort ( RectangleUtils.sortGlobalY ) ;
			var objsHeight:Number = 0;
			var totalHeight:Number = targetCoordinateSpace.height;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				objsHeight += targets[i].height;
			}
			var spread:Number = ( totalHeight - objsHeight ) / ( targets.length - 1 ) ;
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var firstTarget:Rectangle = targets[0];
			var bottom:Number = tcsTopEdge + firstTarget.height;
			firstTarget.y = tcsTopEdge;
			for ( var j:int = 1; j < length; j++ ) {
				var item:Rectangle = targets[j];
				var endY:Number = bottom + spread ;
				bottom += item.height + spread ;
				item.y = endY;
			}
			return ArrayUtils.reorderArray(targets, origOrderedDic);
		}
		public static function spaceHorizontal ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var origOrderedDic:Dictionary = ArrayUtils.preserveOrderWithDictionary(targets);
			
			targets = targets.sort ( RectangleUtils.sortGlobalX ) ;
			var objsWidth:Number = 0;
			var totalWidth:Number = targetCoordinateSpace.width;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				objsWidth += targets[i].width ;
			}
			var spread:Number = ( totalWidth - objsWidth ) / ( targets.length - 1 ) ;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var firstTarget:Rectangle = targets[0];
			var right:Number = tcsLeftEdge + firstTarget.width;
			firstTarget.x = tcsLeftEdge;
			for ( var j:int = 1; j < length; j++ ) {
				var item:Rectangle = targets[j];
				var endX:Number = right + spread;
				right += item.width + spread;
				item.x = endX;
			}
			return ArrayUtils.reorderArray(targets, origOrderedDic);
		}
		/*
		*
		***********
		*  Stack  *
		***********
		*/
		public static function stackVertical ( targetCoordinateSpace:Rectangle, targets:Array /*Rectangle*/) :Array {
			var origOrderedDic:Dictionary = ArrayUtils.preserveOrderWithDictionary(targets);
			
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
			above.sort ( RectangleUtils.sortAdjacentBottom ) ;
			below.sort ( RectangleUtils.sortAdjacentTop ) ;
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
			return ArrayUtils.reorderArray(targets, origOrderedDic);
		}
		public static function stackHorizontal ( targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/) :Array {
			var origOrderedDic:Dictionary = ArrayUtils.preserveOrderWithDictionary(targets);
			
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
			before.sort ( RectangleUtils.sortAdjacentRight ) ;									// sort before array
			after.sort ( RectangleUtils.sortAdjacentLeft ) ;									// sort after array
			before.reverse ( ) ;																// reverse the before array so its in the order I need
			// place before array
			var firstTarget:Rectangle = before[0];												// save ref to first target in before array
			endX = tcsLeftEdge - firstTarget.width;												// first time, endX = the left edge of the tcs - width of first target
			left = tcsLeftEdge - firstTarget.width;												// first time, left = left edge of first target
			firstTarget.x = endX;																// move the first target because it requires diff math
			for ( i = 1; i < before.length; i++ ) {												// loop through all targets in before array
				item = before[i];																//		save ref to target
				endX = left - item.width;														//		this says the left - the width of item
				left -= item.width;																//		save the new left edge value of targets already aligned
				item.x = endX;																	//		apply the math
			}																					// end loop
			// place after array
			firstTarget = after[0];																// save re to first target in after array
			endX = tcsRightEdge ;																// first time, endX = the right edge of tcs
			right = tcsRightEdge + firstTarget.width;											// first time, right = the right edge of first target after alignment
			firstTarget.x = endX;																// apply this math
			for ( i = 1; i < after.length; i++ ) {												// loop through all targets in after array
				item = after[i];																//		save ref to target
				endX = right;																	//		endX = right edge of last targed placed
				right += item.width;															//		update right = right edge of last placed target
				item.x = endX;																	//		apply the math
			}																					// end loop
			//reset & return
			targets = before;																	// targets = before array
			targets = targets.concat ( after ) ;												// targets = before array + after array
			return ArrayUtils.reorderArray(targets, origOrderedDic);							// return targets!
		}
	}
}