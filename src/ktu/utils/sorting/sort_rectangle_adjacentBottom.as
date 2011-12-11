package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	
	/**
	 * sort method for Rectangle by the .bottom property then by the .top property if equal
	 * 
	 * this method is sorting rectangles but the bottom edge, but essentially accounts for the height of the target.
	 * if two targets share the same bottom but are two different heights, this function will sort accordingly.
	 * 
	 * example:
	 * 				 __
	 * 				|  |  __
	 * 				|  | |  |
	 * 				|__| |__|
	 * 
	 * the shorter one is considered 'closer' to the bottom because its height is smaller
	 * 
	 * 
	 * this is a method to be used in Array.sort(). it expects Rectangle to be in the array.
	 * it sorts them based on the .bottom property first. if two objects share that value, it then sorts them by the
	 * .top property which is essentially saying that who ever is smaller in height goes first, but starting from the bottom.
	 * 
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_adjacentBottom(a:Rectangle, b:Rectangle):int {
		var i:int = sort_rectangle_bottom ( a, b ) ;
		if ( i == 0 ) i = sort_rectangle_top ( a, b ) ;
		return i;
	}
	
}