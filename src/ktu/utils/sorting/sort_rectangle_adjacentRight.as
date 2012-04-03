/* MIT License

Copyright (c) 2012 ktu <ktu@cataclysmicrewind.com>

Permission is hereby granted, free of charge, to any person obtaining a 
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be 
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
THEAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
DEALINGS IN THE SOFTWARE.

*/
package ktu.utils.sorting {
	
	import flash.geom.Rectangle;
	import ktu.utils.sorting.compareNumber;
	
	/**
	 * sort method for Rectangle by the .right property, then by the .left property if they are equal
	 * 
	 * this is a method to be used in Array.sort(). it expects Rectangle to be in the array.
	 * it sorts them based on the .right property first. if two objects share that value, it then sorts them by the
	 * .left property which is essentially saying that who ever is smaller in width goes first, but starting from the right.
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function sort_rectangle_adjacentRight(a:Rectangle, b:Rectangle):int {
		var i:int = sort_rectangle_right ( a, b ) ;
		if ( i == 0 ) i = sort_rectangle_left ( a, b ) ;
		return i;
	}
	
}