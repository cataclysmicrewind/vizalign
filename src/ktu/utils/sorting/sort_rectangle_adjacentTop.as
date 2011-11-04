package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the .top property, then by .bottom property if equal
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