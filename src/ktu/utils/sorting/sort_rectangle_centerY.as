package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	public function sort_rectangle_centerY(a:Rectangle, b:Rectangle) {
		return compareNumber (a.top + (a.height / 2), b.top + (b.height / 2));
	}
	
}