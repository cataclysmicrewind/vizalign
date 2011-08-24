package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class AlignMethod {
		
		/**
		 * 
		 * 		ABSTRACT
		 * 
		 * 		override this in your own class to create your own alignment method
		 * 
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function align (targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void { }
		
		
		/**
		 * 
		 * 
		 * 	Static Methods:
		 * 
		 * 		Below are static methods that are super useful for aligning things.
		 * 		No need to reference them via AlignMethod.function, since you are extending this class
		 * 		just call the function
		 * 
		 * 
		 * 
		 */
		
		/**
		 * 
		 * 	SHOULDN'T WORK WITH PRIMITIVES!
		 * 
		 * @param	array
		 * @return
		 */
		public static function preserveOrderWithDictionary(array:Array/*Object*/):Dictionary {
			var dic:Dictionary = new Dictionary(true);
			for (var i:int = 0; i < array.length; i++)  dic[array[i]] = i;
			return dic;
		}
		
		/**
		 * 
		 * 	applys original order to array 
		 * 	use preserveOrderWithDictionary Dicitonary with this function
		 * 
		 * @param	array
		 * @param	orderedDic
		 * @return
		 */
		public static function reorderArray (array:Array/*Object*/, orderedDic:Dictionary):void {
			var unorderedArray:Array = array.concat();
			for (var i:int = 0, ln:int = array.length; i < ln; i++) {
				array[orderedDic[array[i]]] = unorderedArray[i];
			}
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
			return (a > b) ? 1 : (a < b) ? -1 : 0;
		}
		
		
	}

}