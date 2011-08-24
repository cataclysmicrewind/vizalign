package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	public function sort_rectangle_adjacentTop(a:Rectangle, b:Rectangle) {
		var i:int = sort_rectangle_top ( a, b ) ;
		if ( i == 0 ) i = sort_rectangle_bottom ( a, b ) ;
		return i;
	}
	
}