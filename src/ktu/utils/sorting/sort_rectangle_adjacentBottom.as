package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the .bottom property then by the .top property if equal
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