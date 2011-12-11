package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the middle point on the y axis
	 * 
	 * this is a method to be used in Array.sort(). it expects Rectangle to be in the array.
	 * it sorts them based on the middle point on the y axis. (calculated as rect.top + rect.height/2)
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_centerY(a:Rectangle, b:Rectangle):int {
		return compareNumber (a.top + (a.height / 2), b.top + (b.height / 2));
	}
	
}