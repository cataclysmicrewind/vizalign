package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the .top property, then by .bottom property if equal
	 * 
	 * this is a method to be used in Array.sort(). it expects Rectangle to be in the array.
	 * it sorts them based on the .top property first. if two objects share that value, it then sorts them by the
	 * .bottom property which is essentially saying that who ever is smaller in height goes first, but starting from the top.
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_adjacentTop(a:Rectangle, b:Rectangle):int {
		var i:int = sort_rectangle_top ( a, b ) ;
		if ( i == 0 ) i = sort_rectangle_bottom ( a, b ) ;
		return i;
	}
	
}