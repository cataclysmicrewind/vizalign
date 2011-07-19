
package com.locatests.chronos.caching.requests {
	
	/**
	 * ...
	 * @author ...
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]	
	public class RequestCachingSuite {

		public var t1:AAABeforeRequestSuite;		// clears the shared objects... only once, and first...
		public var t2:AppConfigTest;
		public var t3:MessagesTest;
		public var t4:LocationDataTest;
		
	}
}