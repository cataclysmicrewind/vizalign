package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the .left property
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_left(a:Rectangle, b:Rectangle):int {
		return compareNumber (a.left, b.left) ;
	}
	
}