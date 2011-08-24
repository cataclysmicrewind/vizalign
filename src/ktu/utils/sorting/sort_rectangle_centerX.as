package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	public function sort_rectangle_centerX(a:Rectangle, b:Rectangle) {
		return compareNumber (a.x + (a.width / 2) , b.x + (b.width / 2));
	}
	
}