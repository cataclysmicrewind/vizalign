package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the top property
	 * 
	 * this is a method to be used in Array.sort(). it expects Rectangle to be in the array.
	 * it sorts them based on the .top property
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_top(a:Rectangle, b:Rectangle):int {
		return compareNumber (a.top, b.top) ;
	}
	
}