package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the .bottom property
	 * 
	 * this is a method to be used in Array.sort(). it expects Rectangle to be in the array.
	 * it sorts them based on the .bottom property. 
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_bottom(a:Rectangle, b:Rectangle):int {
		return compareNumber (a.bottom, b.bottom) ;
	}
	
}