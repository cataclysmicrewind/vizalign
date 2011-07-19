
package com.locatests.chronos.caching.requests  {
	import com.adobe.serialization.json.JSON;
	import com.locamoda.chronos.caching.CacheDeterminant;
	import com.locamoda.chronos.caching.RequestCache;
	import com.locamoda.chronos.services.operations.CacheOperation;
	import com.locamoda.chronos.services.operations.Operation;
	import com.locamoda.chronos.services.states.OperationState;
	import com.locatests.chronos.caching.requests.AppConfigRequests;
	import com.locatests.chronos.caching.requests.MessagesRequests;
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
	[RunWith("org.flexunit.runners.Parameterized")]
	public class RequestCacheTest {
		
		private var foo:Parameterized;
		
		public static var requestCache:RequestCache;
		
		/**
		 * 
		 */
		[BeforeClass]	
		public static function nuts ():void {
			var lso:SharedObject = SharedObject.getLocal("com/locamoda/request", "/");
			lso.clear();
			lso = SharedObject.getLocal("com/locamoda/messages", "/");
			lso.clear();
			requestCache = new RequestCache();
		}
		/**
		 * 
		 */
		[AfterClass]
		public static function sack ():void {
			requestCache = null;
		}
		
		
		
		/*********************************************************************************
		 *********************************************************************************
		 *********************************************************************************
		 *********************************************************************************
		 * 
		 * 
		 * 						Device Config Tests
		 * 
		 * 
		 *********************************************************************************
		 *********************************************************************************
		 *********************************************************************************
		 *********************************************************************************/
		/**
		 * 
		 * 
		 * 
		 * Before doing anything, try to gra b a non existant device config...
		 * 
		 * 
		 * 
		 * 
		 */
		[Test (async, description="try to grab device config that does not exist in LSO", order=0)]
		public function grabBadDeviceConfig():void {
			var op:CacheOperation = new CacheOperation();
			op.url = "requestƒdeviceConfig_01";
			handleSignal(this, op.stateChanged, onGrabBadDeviceConfigStateChanged, 500, null, onGrabBadDeviceConfigStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabBadDeviceConfigStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var op:Operation = event.args[0];
			assertThat(op.state, OperationState.ERROR);
		}
		private function onGrabBadDeviceConfigStateChangedTimeout():void {
			Assert.fail("grabbing device id from cache took more than 500ms!!!!!?");
		}
		
		
		/**
		 * 
		 * 
		 * 
		 * Try to put a device config in the cache
		 * 
		 * 
		 * 
		 * 
		 */
		[Test (order=1, 			description="store a device config in the LSO")]
		public function storeDeviceConfig():void {
			var op:CacheOperation = new CacheOperation();
			op.url = CacheDeterminant.REQUEST_CACHE + CacheDeterminant.URL_SEPERATOR + "deviceConfig";
			op.dataToCache = { poop:"feels nice" };
			requestCache.execute(op);
			
			var lso:SharedObject = SharedObject.getLocal("com/locamoda/request", "/");
			Assert.assertEquals(lso.data.deviceConfig.poop, "feels nice");
		}
		
		/**
		 * 
		 * 
		 * 
		 * try to grab the device config from cache
		 * 
		 * 
		 * 
		 * 
		 */
		[Test (async, description="try to grab device config that does not exist in LSO", order=2)]
		public function grabDeviceConfig():void {
			var op:CacheOperation = new CacheOperation();
			op.url = "requestƒdeviceConfig_01";
			handleSignal(this, op.stateChanged, onGrabDeviceConfigStateChanged, 500, null, onGrabDeviceConfigStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabDeviceConfigStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var op:Operation = event.args[0];
			assertThat(op.state, OperationState.COMPLETE);
			assertThat(op.data.poop, "feels nice");
		}
		private function onGrabDeviceConfigStateChangedTimeout():void {
			Assert.fail("grabbing device id from cache took more than 500ms!!!!!?");
		}
		
		
		/*********************************************************************************
		 *********************************************************************************
		 *********************************************************************************
		 *********************************************************************************
		 * 
		 * 
		 * 						App Config Tests
		 * 
		 * 
		 *********************************************************************************
		 *********************************************************************************
		 *********************************************************************************
		 *********************************************************************************/
		/**
		 * 
		 * 
		 * 
		 * try to gra b a non existant app config...
		 * 
		 * 
		 * 
		 * 
		 */
		[Test (async, description="try to grab app config that does not exist in LSO", order=3)]
		public function grabBadAppConfig():void {
			var op:CacheOperation = new CacheOperation();
			op.url = "requestƒappConfig_01";
			handleSignal(this, op.stateChanged, onGrabBadAppConfigStateChanged, 500, null, onGrabBadAppConfigStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabBadAppConfigStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var op:Operation = event.args[0];
			assertThat(op.state, OperationState.ERROR);
		}
		private function onGrabBadAppConfigStateChangedTimeout():void {
			Assert.fail("grabbing app config from cache took more than 500ms!!!!!?");
		}
		
		
		/**
		 * 
		 * 
		 * 
		 * Try to put a app config in the cache
		 * 
		 * 
		 * 
		 * 
		 */
		
		public static var appConfigs:Array = [
			[JSON.decode(String(new AppConfigRequests.comboConfig())), "appConfig_comboConfig"],
			[JSON.decode(String(new AppConfigRequests.photoConfig())), "appConfig_photoConfig"],
			[JSON.decode(String(new AppConfigRequests.fenrirConfig())), "appConfig_fenrirConfig"]
		];
		
		
		[Test (	order = 4,
				dataProvider = "appConfigs",
				description = "store a app config in the LSO"
		)]
		public function storeAppConfig(appConfig:Object, id:String):void {
			var op:CacheOperation = new CacheOperation();
			op.url = CacheDeterminant.REQUEST_CACHE + CacheDeterminant.URL_SEPERATOR + id;
			
			op.dataToCache = appConfig
			requestCache.execute(op);
			
			var lso:SharedObject = SharedObject.getLocal("com/locamoda/request", "/");
			assertThat(lso.data[id].data.config.chronos, notNullValue());
		}
		
		/**
		 * 
		 * 
		 * 
		 * try to grab the app config from cache
		 * 
		 * 
		 * 
		 * 
		 */
		[Test (	async,
				description = "try to grab app config that should exist in LSO", order = 5
		)]
		public function grabAppConfig():void {
			var op:CacheOperation = new CacheOperation();
			op.url = "requestƒappConfig_01";
			handleSignal(this, op.stateChanged, onGrabAppConfigStateChanged, 500, null, onGrabAppConfigStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabAppConfigStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var op:Operation = event.args[0];
			assertThat(op.state, OperationState.COMPLETE);
			assertThat(op.data.pee, "feels good");
		}
		private function onGrabAppConfigStateChangedTimeout():void {
			Assert.fail("grabbing device id from cache took more than 500ms!!!!!?");
		}
		
		
		
		
		/*********************************************************************************
		 *********************************************************************************
		 *********************************************************************************
		 *********************************************************************************
		 * 
		 * 
		 * 						Message Tests
		 * 
		 * 
		 *********************************************************************************
		 *********************************************************************************
		 *********************************************************************************
		 *********************************************************************************/
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
		[Test (async, description="try to grab app config that does not exist in LSO", order=6)]
		public function grabBadMessages():void {
			var op:CacheOperation = new CacheOperation();
			op.url = "messagesƒappConfig_01";
			handleSignal(this, op.stateChanged, onGrabBadMessagesStateChanged, 500, null, onGrabBadMessagesStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabBadMessagesStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var op:Operation = event.args[0];
			assertThat(op.state, OperationState.ERROR);
		}
		private function onGrabBadMessagesStateChangedTimeout():void {
			Assert.fail("grabbing app config from cache took more than 500ms!!!!!?");
		}
		
		
		
		
		
		
		public static var messages:Array = [
			[ JSON.decode(String(new MessagesRequests.peterPanMessages())).entries, "appConfig_photoConfig" ], 
			[ JSON.decode(String(new MessagesRequests.clientsFromHellMessages())).entries, "appConfig_comboConfig" ], 
			[ JSON.decode(String(new MessagesRequests.babsonMessages())).entries, "appConfig_fenrirConfig" ]
		];
		/**
		 * 			MESSAGES
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
		[Test (	order=7,
				dataProvider = "messages",
				description = "store a app config in the LSO"
		)]
		public function storeMessages(messages:Array, configID:String):void {
			var op:CacheOperation = new CacheOperation();
			op.url = CacheDeterminant.MESSAGE_CACHE + CacheDeterminant.URL_SEPERATOR + configID;
			op.dataToCache = messages;
			requestCache.execute(op);
			
			var lso:SharedObject = SharedObject.getLocal("com/locamoda/request", "/");
			for (var i:int = 0 ; i < messages.length; i ++) {
				var item:Object = messages[i];
				Assert.assertEquals(lso.data[configID].data.messages[item.id], item.id);
				
			}
			
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
		[Test (async, description="try to grab messages that should exist in LSO", order=8)]
		public function grabMessages():void {
			var op:CacheOperation = new CacheOperation();
			op.url = "messagesƒappConfig_01";
			handleSignal(this, op.stateChanged, onGrabMessagesStateChanged, 500, null, onGrabMessagesStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabMessagesStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var op:Operation = event.args[0];
			assertThat(op.state, OperationState.COMPLETE);
			assertThat(op.data, isA(Array));
			assertThat(op.data.length, greaterThan(0));
		}
		private function onGrabMessagesStateChangedTimeout():void {
			Assert.fail("grabbing messages from cache took more than 500ms!!!!!?");
		}
		
		
		/*********************************************************************************
		 *********************************************************************************
		 *********************************************************************************
		 *********************************************************************************
		 * 
		 * 
		 * 						3rd Party Data Tests
		 * 
		 * 
		 *********************************************************************************
		 *********************************************************************************
		 *********************************************************************************
		 *********************************************************************************/
		
		public static var locationDataURLs:Array = [
			[ { url:"locamoda.com", data:{prop:"locamoda.com"}} ], 
			[ { url:"4[].com", data:{prop:"4[].com"}} ], 
			[ { url:"google.com", data:{prop:"google.com"}} ], 
			[ { url:"facebook.com", data: { prop:"facebook.com" }} ]
		];
			
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
		[Test (dataProvider="locationDataURLs", async, description="try to grab location data that should exist in LSO", order=9)]
		public function grabBadLocationData(data:Object):void {
			var op:CacheOperation = new CacheOperation();
			op.url = "requestƒ" + data.url;
			handleSignal(this, op.stateChanged, onGrabBadLocationDataStateChanged, 500, null, onGrabBadLocationDataStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabBadLocationDataStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var op:Operation = event.args[0];
			assertThat(op.state, OperationState.ERROR);
		}
		private function onGrabBadLocationDataStateChangedTimeout():void {
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
		[Test ( order=10,
				dataProvider = "locationDataURLs", 
				description = "store a app config in the LSO" )
		]
		public function storeLocationData(data:Object):void {
			var op:CacheOperation = new CacheOperation();
			op.url = CacheDeterminant.REQUEST_CACHE + CacheDeterminant.URL_SEPERATOR + data.url;
			op.dataToCache = data.data;
			requestCache.execute(op);
			
			var lso:SharedObject = SharedObject.getLocal("com/locamoda/request", "/");
			Assert.assertEquals(lso.data[data.url], data.data);
			Assert.assertEquals(lso.data[data.url].prop, data.data.prop);
			
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
		[Test (async, dataProvider="locationDataURLs", description="try to grab messages that should exist in LSO", order=11)]
		public function grabLocationData(data:Object):void {
			var op:CacheOperation = new CacheOperation();
			op.url = CacheDeterminant.REQUEST_CACHE + CacheDeterminant.URL_SEPERATOR + data.url;
			handleSignal(this, op.stateChanged, onGrabLocationDataStateChanged, 500, null, onGrabLocationDataStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabLocationDataStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var op:Operation = event.args[0];
			assertThat(op.state, OperationState.COMPLETE);
			assertThat(op.data, isA(Object));
			assertThat(op.data.prop, isA(String));
		}
		private function onGrabLocationDataStateChangedTimeout():void {
			Assert.fail("grabbing location data from cache took more than 500ms!!!!!?");
		}
	}
}