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