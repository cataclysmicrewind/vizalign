package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the middle point on the x axis
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_centerX(a:Rectangle, b:Rectangle):int {
		return compareNumber (a.x + (a.width / 2) , b.x + (b.width / 2));
	}
	
}