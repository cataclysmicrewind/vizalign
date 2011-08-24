package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	public function sort_rectangle_top(a:Rectangle, b:Rectangle) {
		return compareNumber (a.top, b.top) ;
	}
	
}