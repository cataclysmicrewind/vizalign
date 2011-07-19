
package com.locatests.chronos.caching.requests  {
	import flash.net.SharedObject;
	/**
	 * 
	 * [Ignore]
			// put above a test function to temporarily ignore the test (so you don't need to comment it out.
	 * 
	 * 
	 * 
	 * ...
	 * @author ...
	 */
	[TestCase(order=0)]
	public class AAABeforeRequestSuite {
		
		
		[Test]
		public function clearSO():void {
			trace("BeforeRequestSuite::clearSO()");
			var lso:SharedObject = SharedObject.getLocal("com/locamoda/request", "/");
			lso.clear();
			lso = SharedObject.getLocal("com/locamoda/messages", "/");
			lso.clear();
		}
	}
}