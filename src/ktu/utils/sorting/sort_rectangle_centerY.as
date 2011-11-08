package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the middle point on the y axis
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_centerY(a:Rectangle, b:Rectangle):int {
		return compareNumber (a.top + (a.height / 2), b.top + (b.height / 2));
	}
	
}