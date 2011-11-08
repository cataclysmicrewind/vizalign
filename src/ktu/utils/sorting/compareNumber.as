package ktu.utils.sorting {
	
	/**
	 *  compares two numders and returns standard sort values
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