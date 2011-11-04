package ktu.utils.sorting {
	
	/**
	 *  compares two numders and returns standard sort values.
	 * 
	 * if a > b return 1
	 * if a = b return 0
	 * if a < b return -1
	 * 
	 * @param	a
	 * @param	b
	 * @return
	 */
	public function compareNumber(a:Number, b:Number):int {
		return (a > b) ? 1 : (a < b) ? -1 : 0;
	}
}