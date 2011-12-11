package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the middle point on the x axis
	 * 
	 * this is a method to be used in Array.sort(). it expects Rectangle to be in the array.
	 * it sorts them based on the middle point on the x axis. (calculated as rect.left + rect.width/2)
	 * 
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_centerX(a:Rectangle, b:Rectangle):int {
		return compareNumber (a.left + (a.width / 2) , b.left + (b.width / 2));
	}
	
}