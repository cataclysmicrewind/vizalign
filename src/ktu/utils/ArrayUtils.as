
package ktu.utils {
	
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Ktu
	 */
	public class ArrayUtils {
		
		/**
		 * 
		 * 	SHOULDN'T WORK WITH PRIMITIVES!
		 * 
		 * @param	array
		 * @return
		 */
		public static function preserveOrderWithDictionary(array:Array/*Object*/):Dictionary {
			var dic:Dictionary = new Dictionary(true);
			for (var i:int = 0; i < array.length; i++) {
				dic[array[i]] = i;
			}
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
		public static function reorderArray (array:Array/*Object*/, orderedDic:Dictionary):Array {
			var orderedArray:Array = [];
			for (var i:int = 0; i < array.length; i++) {
				var item:* = array[i];
				var index:int = orderedDic[item];
				orderedArray[index] = item;
			}
			return orderedArray;
		}
		
	}

}