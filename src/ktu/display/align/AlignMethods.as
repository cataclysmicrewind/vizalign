

package ktu.display.align {
	
	import flash.display.DisplayObject;
	
	/**
	 *
	 *
	 * 	This class holds all of the available alignment methods for VizAlign. This makes it easy to add
	 * more methods. Each method functions on its own and is not used with any Array method. For simplicity
	 * reasons, the isKnownMethod() of this class utilizes bracket notation to check if the method exists.
	 * Due to this, the value of the constant in the VizAlign class MUST match the associated function name
	 * in this class.
	 *																																							<br/>
	 *																																							<br/>
	 * To Add another alignment method.																															<br/>
	 *																																							<br/>
	 * 	1. Add a public static const for your method inside the VizAlign class.																					<br/>
	 * 	2. The value of that const must EXACTLY match the spelling of the actual function name																	<br/>
	 * 	3. Create your public static function to apply your alignment math																						<br/>
	 * 	4. Make sure you sort your targets first, apply the math, then return the array																			<br/>
	 *																																							<br/>
	 *																																							<br/>
	 * Author: Ktu																																				<br/>
	 * Version: 0.4 *																																			<br/>
	 * Last Update: 10.02.09																																	<br/>
	 *																																							<br/>
	 * version history:																																			<br/>
	 * 10.02.09 0.4 : Added 8 new combination methods 									 																		<br/>
	 * 09.26.09 0.3 : Fixed a few bugs with math in adjacentHorizontal and adjacentVertical																		<br/>
	 * 05.03.09 0.2 : Updated code to reflect package changes																									<br/>
	 * 03.11.09	0.1 : First Created																																<br/>
	 *
	*/
	public class AlignMethods extends AlignUtils {
		
		/*
		**************************************************************************************************
		*
		*  Public Methods
		*
		* 			 alignMethod() - Aligns the target to the specified tcs using a method defined here
		* 		   isKnownMethod() - Checks to see if a potential method call is defined in this class
		*
		*
		**************************************************************************************************
		*/
		/**
		 *
		 * 		This method will call the appropriate alignment function according to the type paramater. This
		 * allows you to properly call the appropriate alignment method.
		 *
		 *
		 * @param	targets						Array of AlignObjects to be aligned
		 * @param	targetCoordinateSpace		tcs for the alignment
		 * @param	type						method to be applied to the targets
		 * @return								results of alignment
		 */
		public static function alignMethod ( targets:Array, targetCoordinateSpace:DisplayObject, type:String ) :Array {
			AlignMethods [ type ] ( targetCoordinateSpace, targets );
			return targets;
		}
		/**
		 *
		 * 		This method will check if the alignment method you wish to apply is defined in this class. This method
		 * uses brakcet notation to determine if the alignment method actually exists, which is why the value of the
		 * constant in VizAlign must exactly match the spelling of the associated alignment function in this class.
		 *
		 *
		 * @param	type	The method name to be applied
		 * @return			If True, then the method does exist.
		 *
		 */
		public static function isKnownMethod ( type:String ) :Boolean {
			if ( AlignMethods [ type ] is Function ) return true;
			return false;
		}
		/*
		**************************************************************************************************
		*
		*  Alignment Methods
		*
		* 		This is where all of the static constants should have a corresponding function to actually
		* 		complete the alignment of targets.
		* 		I have grouped all the methods.
		*
		*
		**************************************************************************************************
		/*
		*
		**************
		*  Align: x  *
		**************
		*/
		private static function left ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsLeftEdge:Number = getLeftEdge (targetCoordinateSpace);							// get left edge of target coordinate space object
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												// loop through all targets
				var item:DisplayObject = targets [ i ] .target;										// 		grab current target as item
				var endX:Number = tcsLeftEdge + getOriginX ( item ) ;								// 		calculate end x value for current item
				item.x = targets [ i ] .end.x = endX;												// 		apply math to target
			}																						// end loop
			return targets;																			// return array
		};
		private static function horizontal ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var mid:Number = getCenterX ( targetCoordinateSpace ) ;									// get center x value of target coordinate space object
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												// loop through all targets
				var item:DisplayObject = targets [ i ] .target;										// 		grab current target as item
				var endX:Number = mid + getOriginX ( item ) -  ( getWidth( item ) / 2 ) ;			// 		calculate end x value for current item
				item.x = targets [ i ] .end.x = endX;												// 		apply math to target
			}																						// end loop
			return targets;																			// return array
		};
		private static function right ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsRightEdge:Number = getRightEdge ( targetCoordinateSpace );						// get right edge of target coordinate space object
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												// loop through all targets
				var item:DisplayObject = targets [ i ] .target;										// 		grab current target as item
				var endX:Number = tcsRightEdge + getOriginX ( item ) - getWidth ( item ) ;			// 		calculate end x value for current item
				item.x = targets [ i ] .end.x = endX;												// 		apply math to target
			}																						// end loop
			return targets;																			// return array
		};
		/*
		*
		************
		*  Center  *
		************
		*/
		private static function center (targetCoordinateSpace:DisplayObject, targets:Array):Array {
			targets = horizontal(targetCoordinateSpace, targets);									// align targets horizontally
			targets = vertical(targetCoordinateSpace, targets);										// align targets vertically
			return targets;																			// return array
		};
		/*
		*
		**************
		*  Align: y  *
		**************
		*/
		private static function top ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsTopEdge:Number = getTopEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endY:Number = tcsTopEdge + getOriginY ( item ) ;
				item.y = targets [ i ] .end.y = endY;
			}
			return targets;
		};
		private static function vertical ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var mid:Number = getCenterY ( targetCoordinateSpace ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endY:Number = mid + getOriginY ( item ) - ( getHeight(item) / 2 ) ;
				item.y = targets [ i ] .end.y = endY;
			}
			return targets;
		};
		private static function bottom ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsBottomEdge:Number = getBottomEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endY:Number = tcsBottomEdge + getOriginY ( item ) - getHeight ( item ) ;
				item.y = targets [ i ] .end.y = endY;
			}
			return targets;
		};
		/*
		*
		****************
		*  Combo: x,y  *
		****************
		*/
		private static function topLeft ( targetCoordinateSpace:DisplayObject, targets:Array ):Array {
			var tcsTopEdge:Number = getTopEdge ( targetCoordinateSpace );
			var tcsLeftEdge:Number = getLeftEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = tcsLeftEdge + getOriginX ( item );								// calculate end x value for current item
				var endY:Number = tcsTopEdge + getOriginY ( item );									// calculate end y value for current item
				item.x = targets [ i ] .end.x = endX;												// apply math to target
				item.y = targets [ i ] .end.y = endY;												// apply maht to target
			}
			return targets;
		}
		private static function topRight ( targetCoordinateSpace:DisplayObject, targets:Array ):Array {
			var tcsTopEdge:Number = getTopEdge ( targetCoordinateSpace );
			var tcsRightEdge:Number = getRightEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = tcsRightEdge + getOriginX ( item ) - getWidth ( item ) ;			// calculate end x value for current item
				var endY:Number = tcsTopEdge + getOriginY ( item );									// calculate end y value for current item
				item.x = targets [ i ] .end.x = endX;												// apply math to target
				item.y = targets [ i ] .end.y = endY;												// apply maht to target
			}
			return targets;
		}
		private static function bottomLeft ( targetCoordinateSpace:DisplayObject, targets:Array ):Array {
			var tcsBottomEdge:Number = getBottomEdge ( targetCoordinateSpace );
			var tcsLeftEdge:Number = getLeftEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = tcsLeftEdge + getOriginX ( item );								// calculate end x value for current item
				var endY:Number = tcsBottomEdge + getOriginY ( item ) - getHeight ( item ) ;
				item.x = targets [ i ] .end.x = endX;												// apply math to target
				item.y = targets [ i ] .end.y = endY;												// apply maht to target
			}
			return targets;
		}
		private static function bottomRight ( targetCoordinateSpace:DisplayObject, targets:Array ):Array {
			var tcsBottomEdge:Number = getBottomEdge ( targetCoordinateSpace );
			var tcsRightEdge:Number = getRightEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = tcsRightEdge + getOriginX ( item ) - getWidth ( item ) ;			// calculate end x value for current item
				var endY:Number = tcsBottomEdge + getOriginY ( item ) - getHeight ( item ) ;
				item.x = targets [ i ] .end.x = endX;												// apply math to target
				item.y = targets [ i ] .end.y = endY;												// apply maht to target
			}
			return targets;
		}
		/*
		*
		*****************
		*  Adjacent: x  *
		*****************
		*/
		private static function adjacentLeft ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsLeftEdge:Number = getLeftEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = tcsLeftEdge + getOriginX(item) - getWidth ( item ) ;
				item.x = targets [ i ] .end.x = endX;
			}
			return targets;
		}
		private static function adjacentRight ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsRightEdge:Number = getRightEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = tcsRightEdge + getOriginX ( item ) ;
				item.x = targets [ i ] .end.x = endX;
			}
			return targets;
		}
		private static function adjacentHorizontal ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var before:Array = new Array ( ) ;													// array to hold objects to the left of the tcs
			var after:Array = new Array ( ) ;													// array to hold objects to the right of the tcs
			var left:Number = 0;																// holds where I placed the previous target for before array
			var right:Number = 0;																// holds where I placed the previous target for after array
			var item:DisplayObject;																// var for holding current target
			var endX:Number;																	// endX is the value used for the placement of target
			var tcsLeftEdge:Number = getLeftEdge ( targetCoordinateSpace );						// save left edge of tcs
			var tcsRightEdge:Number = getRightEdge ( targetCoordinateSpace );					// save right edge of tcs
			var tcsCenterX:Number = getCenterX ( targetCoordinateSpace );						// save the centerX value of the tcs
			// put targets in approriate array depending on position relative to the tcs
			for (var i:int = 0; i < targets.length; i++) {										// loop through all targets
				if ( getCenterX ( targets [ i ] .target ) < tcsCenterX ) {						//		If the centerX of target is < centerX of tcs
					before.push ( targets [ i ] ) ;												//			add to before array (targets sits to left of tcs)
				} else {																		// 		else
					after.push ( targets [ i ] ) ;												//			otherwise, add to after array
				}																				//		end if
			}																					// end loop
			before.sort ( sortAdjacentRight ) ;													// sort before array
			after.sort ( sortAdjacentLeft ) ;													// sort after array
			before.reverse ( ) ;																// reverse the before array so its in the order I need
			// place before array
			var firstTarget:DisplayObject = before[0].target;													// save ref to first target in before array
			endX = tcsLeftEdge + getOriginX(firstTarget) - getWidth (firstTarget) ;				// first time, endX = the left edge of the tcs - width of first target
			left = tcsLeftEdge - getWidth (firstTarget) ;										// first time, left = left edge of first target
			firstTarget.x = before[0].end.x = endX;												// move the first target because it requires diff math
			for ( i = 1; i < before.length; i++ ) {												// loop through all targets in before array
				item = before [ i ] .target;													//		save ref to target
				endX = left + getOriginX ( item ) - getWidth ( item ) ;							//		this says the left - the width of item
				left -= getWidth ( item ) ;														//		save the new left edge value of targets already aligned
				item.x = before [ i ] .end.x = endX;											//		apply the math
			}																					// end loop
			// place after array
			firstTarget = after[0].target;														// save re to first target in after array
			endX = tcsRightEdge + getOriginX ( firstTarget ) ;									// first time, endX = the right edge of tcs
			right = tcsRightEdge + getWidth ( firstTarget ) ;									// first time, right = the right edge of first target after alignment
			firstTarget.x = after[0].end.x = endX;												// apply this math
			for ( i = 1; i < after.length; i++ ) {												// loop through all targets in after array
				item = after [ i ] .target;														//		save ref to target
				endX = right + getOriginX( item ) ;												//		endX = right edge of last targed placed
				right += getWidth ( item ) ;													//		update right = right edge of last placed target
				item.x = after [ i ] .end.x = endX;												//		apply the math
			}																					// end loop
			//reset & return
			targets = before;																	// targets = before array
			targets = targets.concat ( after ) ;												// targets = before array + after array
			return targets;																		// return targets!
		}
		/*
		*
		*****************
		*  Adjacent: y  *
		*****************
		*/
		private static function adjacentTop ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsTopEdge:Number = getTopEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endY:Number = tcsTopEdge + getOriginY ( item ) - getHeight ( item ) ;
				item.y = targets [ i ] .end.y = endY;
			}
			return targets;
		}
		private static function adjacentBottom ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsBottomEdge:Number = getBottomEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endY:Number = tcsBottomEdge + getOriginY ( item ) ;
				item.y = targets [ i ] .end.y = endY;
			}
			return targets;
		}
		private static function adjacentVertical ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var above:Array = new Array ( ) ;
			var below:Array = new Array ( ) ;
			for ( var i:int = 0; i < targets.length; i++ ) {
				if ( getCenterY (targets [ i ].target) < getCenterY (targetCoordinateSpace) ) {
					above.push ( targets [ i ] ) ;
				} else {
					below.push ( targets [ i ] ) ;
				}
			}
			above.sort ( sortAdjacentBottom ) ;
			below.sort ( sortAdjacentTop ) ;
			above.reverse ( ) ;
			var top:Number = 0;
			var bottom:Number = 0;
			var item:DisplayObject;
			var endY:Number;
			for ( var j:int = 0; j < above.length; j++ ) {
				 item = above [ j ] .target
				if ( j != 0 ) {
					endY = top + getOriginY ( item ) - getHeight ( item ) ;
					top -= getHeight ( item ) ;
				} else {
					endY = getTopEdge (targetCoordinateSpace) + getOriginY (item) - getHeight (item);
					top = getTopEdge (targetCoordinateSpace) - getHeight (item) ;
				}
				item.y = above [ j ] .end.y = endY;
			}
			for ( var k:int = 0; k < below.length; k++ ) {
				item = below [ k ] .target;
				endY = 0;
				if ( k != 0 ) {
					endY = bottom + getOriginY ( item ) ;
					bottom += getHeight ( item ) ;
				} else {
					endY = getBottomEdge ( targetCoordinateSpace ) + getOriginY ( item ) ;
					bottom = getBottomEdge ( targetCoordinateSpace ) + getHeight ( item ) ;
				}
				item.y = below [ k ] .end.y = endY;
			}
			above.reverse ( ) ;
			targets = above;
			targets = targets.concat ( below ) ;
			return targets;
		}
		/*
		*
		*************************
		*  Combo Adjacent: x,y  *
		*************************
		*/
		private static function adjacentTopLeft ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsTopEdge:Number = getTopEdge ( targetCoordinateSpace );
			var tcsLeftEdge:Number = getLeftEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = tcsLeftEdge + getOriginX(item) - getWidth ( item ) ;
				var endY:Number = tcsTopEdge + getOriginY ( item ) - getHeight ( item ) ;
				item.x = targets [ i ] .end.x = endX;
				item.y = targets [ i ] .end.y = endY;
			}
			return targets;
		}
		private static function adjacentTopRight ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsTopEdge:Number = getTopEdge ( targetCoordinateSpace );
			var tcsRightEdge:Number = getRightEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = tcsRightEdge + getOriginX ( item ) ;
				var endY:Number = tcsTopEdge + getOriginY ( item ) - getHeight ( item ) ;
				item.x = targets [ i ] .end.x = endX;
				item.y = targets [ i ] .end.y = endY;
			}
			return targets;
		}
		private static function adjacentBottomLeft ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsBottomEdge:Number = getBottomEdge ( targetCoordinateSpace );
			var tcsLeftEdge:Number = getLeftEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = tcsLeftEdge + getOriginX(item) - getWidth ( item ) ;
				var endY:Number = tcsBottomEdge + getOriginY ( item ) ;
				item.x = targets [ i ] .end.x = endX;
				item.y = targets [ i ] .end.y = endY;
			}
			return targets;
		}
		private static function adjacentBottomRight ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsBottomEdge:Number = getBottomEdge ( targetCoordinateSpace );
			var tcsRightEdge:Number = getRightEdge ( targetCoordinateSpace );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = tcsRightEdge + getOriginX ( item ) ;
				var endY:Number = tcsBottomEdge + getOriginY ( item ) ;
				item.x = targets [ i ] .end.x = endX;
				item.y = targets [ i ] .end.y = endY;
			}
			return targets;
		}
		/*
		*
		*******************
		*  Distribute: x  *
		*******************
		*/
		private static function distLeft ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			targets = targets.sort ( sortGlobalX ) ;
			var lastIndex:int = targets.length - 1;
			var lastTarget:DisplayObject = targets [ lastIndex ] .target;
			var tcsLeftEdge:Number = getLeftEdge ( targetCoordinateSpace );
			var spread:Number = ( getWidth (targetCoordinateSpace) - getWidth (lastTarget) ) / ( lastIndex );
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = tcsLeftEdge + getOriginX ( item ) + ( spread * i ) ;
				item.x = targets [ i ] .end.x = endX;
			}
			return targets;
		};
		private static function distHorizontal ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			targets = targets.sort ( sortGlobalCenterX ) ;
			var lastIndex:int = targets.length - 1;
			var first:Number = getLeftEdge ( targetCoordinateSpace ) + ( getWidth ( targets [ 0 ] .target ) / 2 ) ;
			var last:Number = getRightEdge ( targetCoordinateSpace ) - ( getWidth ( targets [ lastIndex ] .target ) / 2 ) ;
			var spread:Number = ( ( last - first ) / ( lastIndex ) ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = first + getOriginX ( item ) - ( getWidth ( item ) / 2 ) + ( spread * i ) ;
				item.x = targets [ i ] .end.x = endX;
			}
			return targets;
		};
		private static function distRight ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			targets = targets.sort ( sortGlobalRight ) ;
			var tcsLeftEdge:Number = getLeftEdge ( targetCoordinateSpace );
			var first:Number = tcsLeftEdge + getWidth ( targets [ 0 ] .target );
			var last:Number = getRightEdge ( targetCoordinateSpace ) ;
			var spread:Number = ( ( last - first ) / ( targets.length - 1 ) ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endX:Number = first + getOriginX ( item ) - getWidth ( item ) + ( spread * i ) ;
				item.x = targets [ i ] .end.x = endX;
			}
			return targets;
		};
		/*
		*
		*******************
		*  Distribute: y  *
		*******************
		*/
		private static function distTop ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			targets = targets.sort ( sortGlobalY ) ;
			var lastIndex:int = targets.length - 1;
			var first:Number = getTopEdge ( targetCoordinateSpace ) ;
			var last:Number = getBottomEdge ( targetCoordinateSpace ) - getHeight( targets [ lastIndex ] .target ) ;
			var spread:Number = ( last - first ) / ( lastIndex ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endY:Number = first + getOriginY ( item ) + ( spread * i ) ;
				item.y = targets [ i ] .end.y = endY;
			}
			return targets;
		};
		private static function distVertical ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			targets = targets.sort ( sortGlobalCenterY ) ;
			var tcsTopEdge:Number = getTopEdge ( targetCoordinateSpace );
			var first:Number = tcsTopEdge + ( getHeight ( targets [ 0 ] .target ) / 2 ) ;
			var last:Number = getBottomEdge ( targetCoordinateSpace ) - ( getHeight ( targets [ targets.length - 1 ] .target ) / 2 ) ;
			var spread:Number = ( ( last - first ) / ( targets.length - 1 ) ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endY:Number = first + getOriginY ( item ) - ( getHeight ( item ) / 2 ) + ( spread * i ) ;
				item.y = targets [ i ] .end.y = endY;
			}
			return targets;
		};
		private static function distBottom ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			targets.sort ( sortGlobalBottom ) ;
			var tcsTopEdge:Number = getTopEdge ( targetCoordinateSpace );
			var first:Number = tcsTopEdge + getHeight ( targets [ 0 ] .target ); ;
			var last:Number = getBottomEdge ( targetCoordinateSpace ) ;
			var spread:Number = ( ( last - first ) / ( targets.length - 1 ) ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var endY:Number = first - getHeight ( item ) - getOriginY ( item ) + ( spread * i ) ;
				item.y = targets [ i ] .end.y = endY;
			}
			return targets;
		};
		/*
		*
		*****************
		*  Match Sizes  *
		*****************
		*/
		private static function matchWidth ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var endW:Number = getWidth ( targetCoordinateSpace ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				item.width = targets [ i ] .end.width = endW;
			}
			return targets;
		};
		private static function matchHeight ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var endH:Number = getHeight ( targetCoordinateSpace ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				item.height = targets [ i ] .end.height = endH;
			}
			return targets;
		};
		private static function matchSize ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			targets = matchWidth ( targetCoordinateSpace, targets ) ;
			targets = matchHeight ( targetCoordinateSpace, targets ) ;
			return targets;
		};
		private static function scaleToFit ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			var tcsWidth:Number = getWidth ( targetCoordinateSpace ) ;
			var tcsHeight:Number = getHeight ( targetCoordinateSpace ) ;
			var tcsRatio:Number = tcsWidth / tcsHeight ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:DisplayObject = targets [ i ] .target;
				var itemWidth:Number = getWidth ( item ) ;
				var itemHeight:Number = getHeight ( item ) ;
				var itemWHRatio:Number = itemWidth / itemHeight ;
				var itemHWRatio:Number = itemHeight / itemWidth;
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
				targets [ i ] .end.width = item.width;
				targets [ i ] .end.height = item.height;
			}
			return targets;
		}
		/*
		*
		******************
		*  Space Evenly  *
		******************
		*/
		private static function spaceVertical ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			targets = targets.sort ( sortGlobalY ) ;
			var objsHeight:Number = 0;
			var totalHeight:Number = getHeight ( targetCoordinateSpace ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				objsHeight += getHeight ( targets [ i ] .target ) ;
			}
			var spread:Number = ( totalHeight - objsHeight ) / ( targets.length - 1 ) ;
			var tcsTopEdge:Number = getTopEdge ( targetCoordinateSpace ) ;
			var firstTarget:DisplayObject = targets [ 0 ] .target ;
			var bottom:Number = tcsTopEdge + getHeight ( firstTarget ) ;
			firstTarget.y = targets [ 0 ] .end.y = tcsTopEdge + getOriginY ( firstTarget );
			for ( var j:int = 1; j < length; j++ ) {
				var item:DisplayObject = targets [ j ] .target;
				var endY:Number = bottom + getOriginY ( item ) + spread ;
				bottom += getHeight ( item ) + spread ;
				item.y = targets [ j ] .end.y = endY;
			}
			return targets;
		}
		private static function spaceHorizontal ( targetCoordinateSpace:DisplayObject, targets:Array ) :Array {
			targets = targets.sort ( sortGlobalX ) ;
			var objsWidth:Number = 0;
			var totalWidth:Number = getWidth ( targetCoordinateSpace ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				objsWidth += getWidth ( targets [ i ] .target ) ;
			}
			var spread:Number = ( totalWidth - objsWidth ) / ( targets.length - 1 ) ;
			var tcsLeftEdge:Number = getLeftEdge ( targetCoordinateSpace );
			var firstTarget:DisplayObject = targets [ 0 ] .target;
			var right:Number = tcsLeftEdge + getWidth ( firstTarget ) ;
			firstTarget.x = targets [ 0 ] .end.x = tcsLeftEdge + getOriginX ( firstTarget ) ;
			for ( var j:int = 1; j < length; j++ ) {
				var item:DisplayObject = targets [ j ] .target;
				var endX:Number = right + getOriginX ( item ) + spread;
				right += getWidth ( item ) + spread;
				item.x = targets [ j ] .end.x = endX;
			}
			return targets;
		}
	}
}