
package com.locatests.chronos.caching.requests  {
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	import com.locamoda.chronos.caching.CacheDeterminant;
	import com.locamoda.chronos.caching.RequestCache;
	import com.locamoda.chronos.services.operations.CacheOperation;
	import com.locamoda.chronos.services.operations.Operation;
	import com.locamoda.chronos.services.states.OperationState;
	import flash.net.SharedObject;
	import org.flexunit.Assert;
	import org.flexunit.runners.Parameterized;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.number.greaterThan;
	import org.hamcrest.object.notNullValue;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.SignalAsyncEvent;
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
	[TestCase(order = 3)]
	[RunWith("org.flexunit.runners.Parameterized")]
	public class LocationDataTest {
		
		private var foo:Parameterized;
		
		public static var requestCache:RequestCache;
		
		
		[Embed(source = '../../../../../../bin/frousquare_venueDetails_746537.json', mimeType = 'application/octet-stream')]
		public static var FoursquareVenueDetails746537:Class;
		[Embed(source = '../../../../../../bin/frousquare_venueDetails_81107.json', mimeType = 'application/octet-stream')]
		public static var FoursquareVenueDetails81107:Class;
		[Embed(source = '../../../../../../bin/frousquare_venueDetails_95549.json', mimeType = 'application/octet-stream')]
		public static var FoursquareVenueDetails95549:Class;
		
		public static var locationDataURLs:Array = [
			[ { url:"http://api.foursquare.com/v1/venue.json?vid=7465371", data:JSON.decode(String(new FoursquareVenueDetails746537()))} ], 
			[ { url:"http://api.foursquare.com/v1/venue.json?vid=81107", data:JSON.decode(String(new FoursquareVenueDetails81107()))} ], 
			[ { url:"http://api.foursquare.com/v1/venue.json?vid=95549", data:JSON.decode(String(new FoursquareVenueDetails95549()))} ]
		];
		
		
		
		/**
		 * 
		 */
		[BeforeClass]	
		public static function nuts ():void {
			trace("LocationDataTest::beforeClass()");
			requestCache = new RequestCache();
		}
		/**
		 * 
		 */
		[AfterClass]
		public static function sack ():void {
			trace("LocationDataTest::afterClass()");
			requestCache = null;
		}
		
		
		
		
		
			
		/**
		 * 
		 * 
		 * 
		 * try to grab a non existant messages
		 * 
		 * 
		 * 
		 * 
		 */
		[Test ( order = 0,
				async,
				dataProvider = "locationDataURLs",
				description = "try to grab location data that should exist in LSO"
		)]
		public function grabBadLocationData(data:Object):void {
			trace("LocationDataTest::grabBadLocationData()");
			var op:CacheOperation = new CacheOperation();
			op.url = "requestƒ" + data.url;
			handleSignal(this, op.stateChanged, onGrabBadLocationDataStateChanged, 500, null, onGrabBadLocationDataStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabBadLocationDataStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			trace("LocationDataTest::onGrabBadLocationDataStateChanged()");
			var op:Operation = event.args[0];
			assertThat(op.state, OperationState.ERROR);
		}
		private function onGrabBadLocationDataStateChangedTimeout():void {
			trace("LocationDataTest::onGrabBadLocationDataStateChangedTimeout()");
			Assert.fail("grabbing location data from cache took more than 500ms!!!!!?");
		}
		
		
		
		
		
		
		/**
		 * 			
		 * 
		 * 
		 * 
		 * 
		 * 
		 * try to store some messages
		 * 
		 * 
		 * 
		 * 
		 */
		[Test ( order = 1,
				dataProvider = "locationDataURLs", 
				description = "store a app config in the LSO" )
		]
		public function storeLocationData(data:Object):void {
			trace("LocationDataTest::storeLocationData()");
			var op:CacheOperation = new CacheOperation();
			op.url = CacheDeterminant.REQUEST_CACHE + CacheDeterminant.URL_SEPERATOR + data.url;
			op.dataToCache = data.data;
			requestCache.execute(op);
			
			var url:String = "X" + MD5.hash(data.url);
			var responseData:Object = data.data;
			
			var lso:SharedObject = SharedObject.getLocal("com/locamoda/request", "/");
			assertThat(lso.data[url], isA(Object));
			assertThat(lso.data[url].gc, isA(Object));
			assertThat(lso.data[url].gc.lastAccessed, isA(Number));
			assertThat(lso.data[url].gc.size, isA(Number));
			assertThat(lso.data[url].data, responseData);
		}
		
		/**
		 * 
		 * 
		 * 
		 * try to grab messages from the cache
		 * 
		 * 
		 * 
		 * 
		 */
		[Test ( order = 2,
				async,
				dataProvider = "locationDataURLs", 
				description = "try to grab messages that should exist in LSO"
		)]
		public function grabLocationData(data:Object):void {
			trace("LocationDataTest::grabLocationData()");
			var op:CacheOperation = new CacheOperation();
			op.url = CacheDeterminant.REQUEST_CACHE + CacheDeterminant.URL_SEPERATOR + data.url;
			handleSignal(this, op.stateChanged, onGrabLocationDataStateChanged, 500, null, onGrabLocationDataStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabLocationDataStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			trace("LocationDataTest::onGrabLocationDataStateChanged()");
			var op:Operation = event.args[0];
			assertThat(op.state, OperationState.COMPLETE);
			assertThat(op.data, isA(Object));
		}
		private function onGrabLocationDataStateChangedTimeout():void {
			trace("LocationDataTest::onGrabLocationDataStateChangedTimeout()");
			Assert.fail("grabbing location data from cache took more than 500ms!!!!!?");
		}
	}
}