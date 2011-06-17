package ktu.utils {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Ktu
	 */
	public class RectangleUtils {
		
		
		public static function cloneRectangleArray (array:Array /* of Rectangle */):Array/* of Rectangle */ {
			var dupeRects:Array = [];
			for each (var rect:Rectangle in array) {
				dupeRects.push (rect.clone());
			}
			return dupeRects;
		}
		
		public static function getCenterX (rect:Rectangle):Number {
			return rect.left + (rect.width / 2);
		}
		public static function getCenterY (rect:Rectangle):Number {
			return rect.top + (rect.height / 2);
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
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalX (A:Rectangle, B:Rectangle):Number {
			return check (A.left, B.left) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by the center pixel of each object in relation to the stage.
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalCenterX (A:Rectangle, B:Rectangle):Number {
			return check (A.x + (A.width/2) , B.x + (B.width/2)) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by the right edge in relation to the stage.
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalRight (A:Rectangle, B:Rectangle):Number {
			return check (A.right, B.right) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by their width.
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalWidth (A:Rectangle, B:Rectangle):Number {
			return check (A.width, B.width) ;
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
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalY (A:Rectangle, B:Rectangle):Number {
			return check (A.top, B.top) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by the center pixel in relation to the stage.
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalCenterY (A:Rectangle, B:Rectangle):Number {
			return check (A.top + (A.height/2), B.top + (B.height/2)) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by the bottom edge in relation to the stage.
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalBottom (A:Rectangle, B:Rectangle):Number {
			return check (A.bottom, B.bottom) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by their height.
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalHeight (A:Rectangle, B:Rectangle):Number {
			return check (A.height , B.height) ;
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
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortAdjacentLeft ( A:Rectangle, B:Rectangle ) :Number {
			var i:int = sortGlobalX ( A, B ) ;
			if ( i == 0 ) i = sortGlobalRight ( A, B ) ;
			return i;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by their right edge, if right edge matches, the items are then
		 * sorted by their left edge.
		 *
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortAdjacentRight (A:Rectangle, B:Rectangle):Number {
			var i:int = sortGlobalRight ( A, B ) ;
			if ( i == 0 ) i = sortGlobalX ( A, B ) ;
			return i;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by their top edge, if top edge matches, the items are then
		 * sorted by their bottom edge.
		 *
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortAdjacentTop (A:Rectangle, B:Rectangle):Number {
			var i:int = sortGlobalY ( A, B ) ;
			if ( i == 0 ) i = sortGlobalBottom ( A, B ) ;
			return i;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by their bottom edge, if bottom edge matches, the items are then
		 * sorted by their top edge.
		 *
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortAdjacentBottom (A:Rectangle, B:Rectangle):Number {
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