package ktu.utils {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Ktu
	 */
	public class RectangleUtils {
		
		
		public static function cloneRectangleArray (array:Array/*Rectangle*/):Array/*Rectangle*/ {
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
		public static function sortGlobalX (a:Rectangle, b:Rectangle):Number {
			return check (a.left, b.left) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by the center pixel of each object in relation to the stage.
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalCenterX (a:Rectangle, b:Rectangle):Number {
			return check (a.x + (a.width/2) , b.x + (b.width/2)) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by the right edge in relation to the stage.
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalRight (a:Rectangle, b:Rectangle):Number {
			return check (a.right, b.right) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by their width.
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalWidth (a:Rectangle, b:Rectangle):Number {
			return check (a.width, b.width) ;
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
		public static function sortGlobalY (a:Rectangle, b:Rectangle):Number {
			return check (a.top, b.top) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by the center pixel in relation to the stage.
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalCenterY (a:Rectangle, b:Rectangle):Number {
			return check (a.top + (a.height/2), b.top + (b.height/2)) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by the bottom edge in relation to the stage.
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalBottom (a:Rectangle, b:Rectangle):Number {
			return check (a.bottom, b.bottom) ;
		}
		/**
		 * Method to be used with Array.sort() for sorting objects by their height.
		 * Note: Array must be filled with AlignObject.
		 *
		 *  Array.sort()
		 */
		public static function sortGlobalHeight (a:Rectangle, b:Rectangle):Number {
			return check (a.height , b.height) ;
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
		public static function sortAdjacentLeft ( a:Rectangle, b:Rectangle ) :Number {
			var i:int = sortGlobalX ( a, b ) ;
			if ( i == 0 ) i = sortGlobalRight ( a, b ) ;
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
		public static function sortAdjacentRight (a:Rectangle, b:Rectangle):Number {
			var i:int = sortGlobalRight ( a, b ) ;
			if ( i == 0 ) i = sortGlobalX ( a, b ) ;
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
		public static function sortAdjacentTop (a:Rectangle, b:Rectangle):Number {
			var i:int = sortGlobalY ( a, b ) ;
			if ( i == 0 ) i = sortGlobalBottom ( a, b ) ;
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
		public static function sortAdjacentBottom (a:Rectangle, b:Rectangle):Number {
			var i:int = sortGlobalBottom ( a, b ) ;
			if ( i == 0 ) i = sortGlobalY ( a, b ) ;
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