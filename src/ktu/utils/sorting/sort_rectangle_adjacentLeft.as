package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the .left property then by the .right property if equal
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