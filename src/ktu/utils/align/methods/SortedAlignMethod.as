package ktu.utils.align.methods {
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class SortedAlignMethod extends AlignMethod {
		
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
		
		
	}

}