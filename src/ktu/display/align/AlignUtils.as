

package ktu.display.align {
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	/**
	 *
	 * 		This is a utility class with methods specific to aligning objects visually. This class returns
	 * x/y values that relate to the corresponding area of a DisplayObject in relation to the stage
	 * (meaning ignores nesting). All of the corners can be retrieved as well as the center, origins,
	 * plus width and height. This also contains sorting methods to sort DisplayObjects in order
	 * of their global x, y, centers, width and height.
	 * 																																							<br/><br/>
	 * Sorting Functions:																																		<br/>
	 *	These methods are used to sort your objects in a manner that will be
	 * appropriate for the applicable align method.																												<br/>
	 * 																																							<br/>
	 * 																																							<br/><listing version="3">
	 *  ________________________________
	 * |                                |
	 * |     $ ______________           |
	 * |      |              |          | <--- Stage
	 * |      |   +          |          | $ = x,y position of top left pixel inside of box
	 * |      | (0,0) &      |          |        in relation to the stage.
	 * |      |              | <---box  | + = 0,0 inside of box
	 * |      |______________|          | & = center of pixels inside of box
	 * |________________________________| 																														</listing>
	 * 																																							<br/>
	 * Calling AlignUtils.getLeftEdge(box) returns $ in relation to the stage origins.																			<br/>
	 * Calling AlignUtils.getCenterX(box) returns & in relation to the stage origins.																			<br/>
	 * 																																							<br/>
	 *																																							<br/>
	 * 																																							<br/>
	 * Author: Ktu																																				<br/>
	 * Version: 0.5 *																																			<br/>
	 * Last Update: 01.22.10																																	<br/>
	 *																																							<br/>
	 * version history:																																			<br/>
	 * 01.22.10 0.5 : Using pixelBounds rather than getBounds
	 * 05.03.09 0.4 : Cleaned up code.																															<br/>
	 * 11.29.08	0.3	: Added adjacent sort methods																												<br/>
	 * 10.18.08	0.2 : Added sort methods																														<br/>
	 * 10.03.08	0.1 : Completed get methods																														<br/>
	 *																																							<br/>
	 *
	*/
	public class AlignUtils extends Object {
		
		/**
		 * A reference to the Stage, this must be set for this class to function.
		 */
		private static var _stageRef:Stage;
		
		/**
		 * A reference to the Stage, this must be set for this class to function.
		 * Static classes have issues with Stage references, as static methods cannot create objects that can get a reference to the stage. <br/>
		 * If this is NOT set, VizAlign package will not work.
		 */
		public static function get stageRef ():Stage { return _stageRef; };
		public static function set stageRef (n:Stage):void { _stageRef = n; };
		/*
		*
		*************************
		* 						*
		*        Find: x        *
		* 						*
		*************************
		*/
		/**
		 *	returns the farthest left pixel value of the passed in DisplayObject in relation to the Stage
		 *
		 * @param	item	item you wish to retrieve the farthest left pixel of according to the Stage
		 * @return			returns the left edge of the item paramater according to DisplayObject.getBounds(Stage)
		 */
		public static function getLeftEdge (item:DisplayObject):Number {
			return item.transform.pixelBounds.left;
		}
		/**
		 *	returns the center x pixel value of the passed in DisplayObject in relation to the Stage
		 *
		 * @param	item	item you wish to retrieve the center x pixel of according to the Stage
		 * @return			returns the center x of the item paramater according to DisplayObject.getBounds(Stage)
		 */
		public static function getCenterX (item:DisplayObject):Number {
			var bounds:Rectangle = item.transform.pixelBounds;
			return bounds.left + (bounds.width / 2);
		}
		/**
		 *	returns the farthest right pixel value of the passed in DisplayObject in relation to the Stage
		 *
		 * @param	item	item you wish to retrieve the farthest right pixel of according to the Stage
		 * @return			returns the right edge of the item paramater according to DisplayObject.getBounds(Stage)
		 */
		public static function getRightEdge (item:DisplayObject):Number {
			return item.transform.pixelBounds.right;
		}
		/**
		 *	returns the pixel width of the passed in DisplayObject in relation to the Stage
		 *
		 * @param	item	item you wish to retrieve the pixel width of according to the Stage
		 * @return			returns the width of the item paramater according to DisplayObject.getBounds(Stage)
		 */
		public static function getWidth (item:DisplayObject):Number {
			return item.transform.pixelBounds.width;
		}
		/**
		 *  returns the difference between the left edge of the item, and the origin of the item
		 *
		 *  This is a significant method when doing alignment. If the origin of a DisplayObject is not 0,0 the x or y
		 *  values of the object do not reflect the edge of the pixels in the DisplayObject.
		 *
		 * @param	item	item you wish to retrieve the difference between the left edge and origin, according to the Stage
		 * @return			returns the difference of the left edge of the item paramater and its origin.
		 */
		public static function getOriginX (item:DisplayObject):Number {
			return item.x - getLeftEdge (item);
		}
		/*
		*
		*************************
		* 						*
		*        Find: y        *
		* 						*
		*************************
		*/
		/**
		 *	returns the farthest top pixel value of the passed in DisplayObject in relation to the Stage
		 *
		 * @param	item	item you wish to retrieve the farthest top pixel of according to the Stage
		 * @return			returns the top edge of the item paramater according to DisplayObject.getBounds(Stage)
		 */
		public static function getTopEdge (item:DisplayObject):Number {
			return item.transform.pixelBounds.top;
		}
		/**
		 *	returns the center y pixel value of the passed in DisplayObject in relation to the Stage
		 *
		 * @param	item	item you wish to retrieve the center y pixel of according to the Stage
		 * @return			returns the center y of the item paramater according to DisplayObject.getBounds(Stage)
		 */
		public static function getCenterY (item:DisplayObject):Number {
			var bounds:Rectangle = item.transform.pixelBounds;
			return bounds.top + (bounds.height / 2);
		}
		/**
		 *	returns the farthest bottom pixel value of the passed in DisplayObject in relation to the Stage
		 *
		 * @param	item	item you wish to retrieve the farthest bottom pixel of according to the Stage
		 * @return			returns the bottom edge of the item paramater according to DisplayObject.getBounds(Stage)
		 */
		public static function getBottomEdge (item:DisplayObject):Number {
			return item.transform.pixelBounds.bottom;
		}
		/**
		 *	returns the pixel height of the passed in DisplayObject in relation to the Stage
		 *
		 * @param	item	item you wish to retrieve the pixel height of according to the Stage
		 * @return			returns the height of the item paramater according to DisplayObject.getBounds(Stage)
		 */
		public static function getHeight (item:DisplayObject):Number {
			return item.transform.pixelBounds.height;
		}
		/**
		 *  returns the difference between the top edge of the item, and the origin of the item
		 *
		 *  This is a significant method when doing alignment. If the origin of a DisplayObject is not 0,0 the x or y
		 *  values of the object do not reflect the edge of the pixels in the DisplayObject.
		 *
		 * @param	item	item you wish to retrieve the difference between the top edge and origin, according to the Stage
		 * @return			returns the difference of the top edge of the item paramater and its origin.
		 */
		public static function getOriginY (item:DisplayObject):Number {
			return item.y - getTopEdge (item);
		}
		/*
		*
		***********************************
		* 								  *
		*        Sort Functions: x        *
		* 								  *
		***********************************
		*/
		/**
		 * Method to be used with Array.sort() for sorting objects by the left edge in relation to the stage.
		 * Note: Array must be filled with VizAlignTarget.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalX (A:VizAlignTarget, B:VizAlignTarget):Number {
			return check ( getLeftEdge ( A.target ) , getLeftEdge ( B.target ) ) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by the center pixel of each object in relation to the stage.
		 * Note: Array must be filled with VizAlignTarget.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalCenterX (A:VizAlignTarget, B:VizAlignTarget):Number {
			return check ( getCenterX ( A.target ) , getCenterX ( B.target ) ) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by the right edge in relation to the stage.
		 * Note: Array must be filled with VizAlignTarget.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalRight (A:VizAlignTarget, B:VizAlignTarget):Number {
			return check ( getRightEdge ( A.target ) , getRightEdge ( B.target ) ) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by their width.
		 * Note: Array must be filled with VizAlignTarget.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalWidth (A:VizAlignTarget, B:VizAlignTarget):Number {
			return check ( getWidth ( A.target ) , getWidth ( B.target ) ) ;
		}
		/*
		*
		***********************************
		* 								  *
		*        Sort Functions: y        *
		* 								  *
		***********************************
		*/
		/**
		 * Method to be used with Array.sort() for sorting objects by the top edge in relation to the stage.
		 * Note: Array must be filled with VizAlignTarget.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalY (A:VizAlignTarget, B:VizAlignTarget):Number {
			return check ( getTopEdge ( A.target ) , getTopEdge ( B.target ) ) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by the center pixel in relation to the stage.
		 * Note: Array must be filled with VizAlignTarget.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalCenterY (A:VizAlignTarget, B:VizAlignTarget):Number {
			return check ( getCenterY ( A.target ) , getCenterY ( B.target ) ) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by the bottom edge in relation to the stage.
		 * Note: Array must be filled with VizAlignTarget.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalBottom (A:VizAlignTarget, B:VizAlignTarget):Number {
			return check ( getBottomEdge ( A.target ) , getBottomEdge ( B.target ) ) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by their height.
		 * Note: Array must be filled with VizAlignTarget.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalHeight (A:VizAlignTarget, B:VizAlignTarget):Number {
			return check ( getHeight ( A.target ) , getHeight ( B.target ) ) ;
		}
		/*
		*
		*****************************************
		* 										*
		*        Sort Adjacent Functions        *
		* 										*
		*****************************************
		*/
		/**
		 * Method to be used with Array.sort() for sorting objects by their left edge, if left edge matches, the items are then
		 * sorted by their right edge.
		 *
		 * Note: Array must be filled with VizAlignTarget.
		 *
		 *  Array.sort()
		 */
		public static function sortAdjacentLeft ( A:VizAlignTarget, B:VizAlignTarget ) :Number {
			var i:int = sortGlobalX ( A, B ) ;
			if ( i == 0 ) i = sortGlobalRight ( A, B ) ;
			return i;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by their right edge, if right edge matches, the items are then
		 * sorted by their left edge.
		 *
		 * Note: Array must be filled with VizAlignTarget.
		 *
		 *  Array.sort()
		 */
		public static function sortAdjacentRight (A:VizAlignTarget, B:VizAlignTarget):Number {
			var i:int = sortGlobalRight ( A, B ) ;
			if ( i == 0 ) i = sortGlobalX ( A, B ) ;
			return i;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by their top edge, if top edge matches, the items are then
		 * sorted by their bottom edge.
		 *
		 * Note: Array must be filled with VizAlignTarget.
		 *
		 *  Array.sort()
		 */
		public static function sortAdjacentTop (A:VizAlignTarget, B:VizAlignTarget):Number {
			var i:int = sortGlobalY ( A, B ) ;
			if ( i == 0 ) i = sortGlobalBottom ( A, B ) ;
			return i;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by their bottom edge, if bottom edge matches, the items are then
		 * sorted by their top edge.
		 *
		 * Note: Array must be filled with VizAlignTarget.
		 *
		 *  Array.sort()
		 */
		public static function sortAdjacentBottom (A:VizAlignTarget, B:VizAlignTarget):Number {
			var i:int = sortGlobalBottom ( A, B ) ;
			if ( i == 0 ) i = sortGlobalY ( A, B ) ;
			return i;
		}
		/**
		 * Method used with Array.sort(). The actual logic abstracted into this method for cleaner code.
		 *
		 *  Array.sort()
		 */
		private static function check (a:Number, b:Number):int {
			if (a > b) {
				return 1;
			} else if(a < b) {
				return -1;
			} else {
				return 0;
			}
		}
	}
}