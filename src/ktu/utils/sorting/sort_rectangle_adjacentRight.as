package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	public function sort_rectangle_adjacentRight(a:Rectangle, b:Rectangle)int {
		var i:int = sort_rectangle_right ( a, b ) ;
		if ( i == 0 ) i = sort_rectangle_left ( a, b ) ;
		return i;
	}
	
}