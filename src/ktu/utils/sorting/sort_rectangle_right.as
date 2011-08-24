package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	public function sort_rectangle_right(a:Rectangle, b:Rectangle) {
		return compareNumber (a.right, b.right) ;
	}
	
}