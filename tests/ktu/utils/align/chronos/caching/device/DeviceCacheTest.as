
package com.locatests.chronos.caching.device  {
	import com.locamoda.chronos.caching.DeviceCache;
	import com.locamoda.chronos.services.factories.ConfigOperationFactory;
	import com.locamoda.chronos.services.operations.CacheOperation;
	import com.locamoda.chronos.services.states.OperationState;
	import flash.net.SharedObject;
	import org.flexunit.Assert;
	import org.flexunit.runners.Parameterized;
	import org.hamcrest.assertThat;
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
	[RunWith("org.flexunit.runners.Parameterized")]
	public class DeviceCacheTest {
		
		private var foo:Parameterized;
		
		public static var deviceCache:DeviceCache;
		public static var factory:ConfigOperationFactory;
		/**
		 * 
		 */
		[BeforeClass]	
		public static function nuts ():void {
			var lso:SharedObject = SharedObject.getLocal("com/locamoda/device", "/");
			lso.clear();
			deviceCache = new DeviceCache();
			factory = new ConfigOperationFactory();
		}
		/**
		 * 
		 */
		[AfterClass]
		public static function sack ():void {
			deviceCache = null;
			factory = null;
		}
		
		
		
		/**
		 * 
		 * 
		 * 
		 * Before doing anything, try to gra b a non existant ID...
		 * 
		 * 
		 * 
		 * 
		 */
		[Test (async, description="try to grab device ID that does not exist in LSO", order=0)]
		public function grabBadDeviceID():void {
			var op:CacheOperation = factory.getDeviceID();
			handleSignal(this, op.stateChanged, onGrabBadDeviceIDStateChanged, 500, null, onGrabBadDeviceIDStateChangedTimeout);
			deviceCache.execute(op);
		}
		private function onGrabBadDeviceIDStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var cacheOperation:CacheOperation = event.args[0];
			assertThat(cacheOperation.state, OperationState.ERROR);
		}
		private function onGrabBadDeviceIDStateChangedTimeout():void {
			Assert.fail("grabbing device id from cache took more than 500ms!!!!!?");
		}
		
		
		/**
		 * 
		 * 
		 * 
		 * 
		 * @return
		 */
		public static function deviceIDArray():Array {
			return [["A31415"], ["A42424"], ["A0666"], ["A01230026570"], ["A9296"]];
		}
		/**
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 */
		[Test (dataProvider="deviceIDArray", order=1, 			description="store a device ID in the LSO")]
		public function storeDeviceID(id:String):void {
			var op:CacheOperation = factory.getDeviceID();
			op.dataToCache = id;
			deviceCache.execute(op);
			
			var lso:SharedObject = SharedObject.getLocal("com/locamoda/device", "/");
			Assert.assertEquals(lso.data.deviceID, id);
		}
		/**
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 */
		[Test (async, description="grab deivce ID from LSO, expecting a proper value", order=2)]
		public function grabDeviceID():void {
			var op:CacheOperation = factory.getDeviceID();
			handleSignal(this, op.stateChanged, onGrabDeviceIDStateChanged, 500, null, onGrabDeviceIDStateChangedTimeout);
			deviceCache.execute(op);
		}
		private function onGrabDeviceIDStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var cacheOperation:CacheOperation = event.args[0];
			Assert.assertEquals(cacheOperation.data, "A9296");
		}
		private function onGrabDeviceIDStateChangedTimeout():void {
			Assert.fail("grabbing device id from cache took more than 500ms!!!!!?");
		}
		
		
		
		
		
		
		
		/**
		 * 
		 * 
		 * 
		 * try to grab a non existant network ID
		 * 
		 * 
		 * 
		 * 
		 */
		[Test (async, description="try to grab network ID that does not exist in LSO", order=3)]
		public function grabBadNetworkID():void {
			var op:CacheOperation = factory.getDeviceID();
			handleSignal(this, op.stateChanged, onGrabBadNetworkIDStateChanged, 500, null, onGrabBadNetworkIDStateChangedTimeout);
			deviceCache.execute(op);
		}
		private function onGrabBadNetworkIDStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var cacheOperation:CacheOperation = event.args[0];
			assertThat(cacheOperation.state, OperationState.ERROR);
		}
		private function onGrabBadNetworkIDStateChangedTimeout():void {
			Assert.fail("grabbing network id from cache took more than 500ms!!!!!?");
		}
		
		
		/**
		 * 
		 * 
		 * 
		 * 
		 * @return
		 */
		public static function networkIDArray():Array {
			return [["ecast"], ["zoom"], ["danoo"], ["locatest"], ["locamoda"]];
		}
		/**
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 */
		[Test (dataProvider="networkIDArray", order=4, 			description="store a device ID in the LSO")]
		public function storeNetworkID(id:String):void {
			var op:CacheOperation = factory.getNetworkID();
			op.dataToCache = id;
			deviceCache.execute(op);
			
			var lso:SharedObject = SharedObject.getLocal("com/locamoda/device", "/");
			Assert.assertEquals(lso.data.networkID, id);
		}
		/**
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 */
		[Test (async, description="grab network ID from LSO, expecting a proper value", order=5)]
		public function grabNetworkID():void {
			var op:CacheOperation = factory.getNetworkID();
			handleSignal(this, op.stateChanged, onGrabNetworkIDStateChanged, 500, null, onGrabNetworkIDStateChangedTimeout);
			deviceCache.execute(op);
		}
		private function onGrabNetworkIDStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var cacheOperation:CacheOperation = event.args[0];
			Assert.assertEquals(cacheOperation.data, "locamoda");
		}
		private function onGrabNetworkIDStateChangedTimeout():void {
			Assert.fail("grabbing network id from cache took more than 500ms!!!!!?");
		}
	}
}