
package com.locatests.chronos.caching {
	import com.locatests.chronos.caching.assets.AssetCachingSuite;
	import com.locatests.chronos.caching.device.DeviceCacheTest;
	import com.locatests.chronos.caching.requests.RequestCachingSuite;
	
	/**
	 * ...
	 * @author ...
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]	
	public class CachingSuite {
		
		public var t1:DeviceCacheTest;
		public var t2:RequestCachingSuite;
		public var t3:AssetCachingSuite;
	}
}