package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the .left property then by the .right property if equal
	 * 
	 * this is a method to be used in Array.sort(). it expects Rectangle to be in the array.
	 * it sorts them based on the .left property first. if two objects share that value, it then sorts them by the
	 * .right property which is essentially saying that who ever is smaller in width goes first, but starting from the left.
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_adjacentLeft(a:Rectangle, b:Rectangle):int {
		var i:int = sort_rectangle_left ( a, b ) ;
		if ( i == 0 ) i = sort_rectangle_right ( a, b ) ;
		return i;
	}
	
}