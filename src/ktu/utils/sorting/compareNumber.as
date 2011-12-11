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