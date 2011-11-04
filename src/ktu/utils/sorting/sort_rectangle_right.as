package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the .right property
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_right(a:Rectangle, b:Rectangle):int {
		return compareNumber (a.right, b.right) ;
	}
	
}