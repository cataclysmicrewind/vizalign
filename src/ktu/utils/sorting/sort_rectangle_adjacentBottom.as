/*

				DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
						Version 2, December 2004
	
	Copyright (C) 2012 ktu <ktu@cataclysmicrewind.com>
	
	Everyone is permitted to copy and distribute verbatim or modified
	copies of this license document, and changing it is allowed as long
	as the name is changed.
	
				DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
	   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
		
		0. You just DO WHAT THE FUCK YOU WANT TO.


	This program is free software. It comes without any warranty, to
	the extent permitted by applicable law. You can redistribute it
	and/or modify it under the terms of the Do What The Fuck You Want
	To Public License, Version 2, as published by Sam Hocevar. See
	http://sam.zoy.org/wtfpl/COPYING for more details.

*/
package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	
	/**
	 * sort method for Rectangle by the .bottom property then by the .top property if equal
	 * 
	 * this method is sorting rectangles but the bottom edge, but essentially accounts for the height of the target.
	 * if two targets share the same bottom but are two different heights, this function will sort accordingly.
	 * 
	 * example:
	 * 				 __
	 * 				|  |  __
	 * 				|  | |  |
	 * 				|__| |__|
	 * 
	 * the shorter one is considered 'closer' to the bottom because its height is smaller
	 * 
	 * 
	 * this is a method to be used in Array.sort(). it expects Rectangle to be in the array.
	 * it sorts them based on the .bottom property first. if two objects share that value, it then sorts them by the
	 * .top property which is essentially saying that who ever is smaller in height goes first, but starting from the bottom.
	 * 
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_adjacentBottom(a:Rectangle, b:Rectangle):int {
		var i:int = sort_rectangle_bottom ( a, b ) ;
		if ( i == 0 ) i = sort_rectangle_top ( a, b ) ;
		return i;
	}
	
}