package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	public function sort_rectangle_adjacentBottom(a:Rectangle, b:Rectangle):int {
		var i:int = sort_rectangle_bottom ( a, b ) ;
		if ( i == 0 ) i = sort_rectangle_top ( a, b ) ;
		return i;
	}
	
}