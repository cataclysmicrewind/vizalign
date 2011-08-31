package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	public function sort_rectangle_left(a:Rectangle, b:Rectangle) {
		return compareNumber (a.left, b.left) ;
	}
	
}