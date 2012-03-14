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
	
	/**
	 *  compares two numders and returns standard sort values
	 * 
	 * this function is a most common reusable function when sorting arrays.
	 * 
	 * 
	 * the most common thing to do when writing your own sort function for arrays is the write the code
	 * that exists in this function.
	 * 
	 * 
	 * taken directly from the Actionscript 3.0 Reference, this example shows a 'normal' sort function 
	 * 																																							
		<listing>function sortOnPrice(a:Vegetable, b:Vegetable):Number {
	 		var aPrice:Number = a.getPrice();
	 		var bPrice:Number = b.getPrice();
	 		
	 		if (aPrice (gt) bPrice) {
	 			return 1;
	 		} else if (aPrice (lt) bPrice) {
	 			return -1;
	 		} else {
	 			//aPrice == bPrice
	 			return 0;
	 		}
	 	}</listing>
	 * 
	 * as you can see, if aPrice and bPrice were sent to this function we would get the same results.
	 * here is what the function would look like using compareNumber:
	 *
	 	<listing>function sortOnPrice(a:Vegetable, b:Vegetable):Number {
	 		return compareNumber(a.getPrice(), b.getPrice());
	 	}</listing>
	 * 
	 * 
	 * 
	 * 
	 * 
	 * @param	a
	 * @param	b
	 * @return the relationship between the two numbers
	 */
	public function compareNumber(a:Number, b:Number):int {
		return (a > b) ? 1 : (a < b) ? -1 : 0;
	}
}