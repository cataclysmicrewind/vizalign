
package com.locatests.chronos.caching.requests  {
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
	[TestCase(order=1)]
	[RunWith("org.flexunit.runners.Parameterized")]
	public class AppConfigTest {
		
		private var foo:Parameterized;
		
		public static var requestCache:RequestCache;
		
		
		[Embed(source='../../../../../../bin/AppConfig_Combo.json', mimeType='application/octet-stream')]
		public static var ComboConfig:Class;
		[Embed(source='../../../../../../bin/AppConfig_Photo.json', mimeType='application/octet-stream')]
		public static var PhotoConfig:Class;
		[Embed(source='../../../../../../bin/FenrirConfig.json', mimeType='application/octet-stream')]
		public static var FenrirConfig:Class;
		
		public static var appConfigs:Array = [
			[JSON.decode(String(new ComboConfig())), "appConfig_comboConfig"],
			[JSON.decode(String(new PhotoConfig())), "appConfig_photoConfig"],
			[JSON.decode(String(new FenrirConfig())), "appConfig_fenrirConfig"]
		];
		/**
		 * 
		 */
		[BeforeClass]	
		public static function beforeClass ():void {
			requestCache = new RequestCache();
		}
		/**
		 * 
		 */
		[AfterClass]
		public static function afterClass ():void {
			requestCache = null;
		}
		
		
		
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
		[Test ( order = 0,
				async,
				dataProvider = "appConfigs",
				description = "try to grab app config that does not exist in LSO"
		)]
		public function grabBadAppConfig(appConfig:Object, configID:String):void {
			trace("AppConfigTest::grabBadAppConfig() - " + configID);
			var op:CacheOperation = new CacheOperation();
			op.url = "requestƒ" + configID;
			handleSignal(this, op.stateChanged, onGrabBadAppConfigStateChanged, 500, null, onGrabBadAppConfigStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabBadAppConfigStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			trace("AppConfigTest::onGrabBadAppConfigStateChanged()");
			var op:Operation = event.args[0];
			assertThat(op.state, OperationState.ERROR);
		}
		private function onGrabBadAppConfigStateChangedTimeout():void {
			trace("AppConfigTest::onGrabBadAppConfigStateChangedTimeout()");
			Assert.fail("grabbing app config from cache took more than 500ms!!!!!?");
		}
		
		
		
		
		[Test (	order = 1,
				dataProvider = "appConfigs",
				description = "store a app config in the LSO"
		)]
		public function storeAppConfig(appConfig:Object, configID:String):void {
			trace("AppConfigTest::storeAppConfig() - " + configID);
			var op:CacheOperation = new CacheOperation();
			op.url = CacheDeterminant.REQUEST_CACHE + CacheDeterminant.URL_SEPERATOR + configID;
			
			op.dataToCache = appConfig
			requestCache.execute(op);
			
			var lso:SharedObject = SharedObject.getLocal("com/locamoda/request", "/");
			var configData:Object = lso.data[configID];
			assertThat(configData.gc, isA(Object));
			assertThat(configData.gc.lastAccessed, isA(Number));
			assertThat(configData.gc.size, isA(Number));
			assertThat(configData.data, isA(Object));
			assertThat(configData.data.config, notNullValue());
			assertThat(configData.data.config.chronos, notNullValue());
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
		[Test (	order = 2,
				async,
				dataProvider = "appConfigs",
				description = "try to grab app config that should exist in LSO"
		)]
		public function grabAppConfig(appConfig:Object, configID:String):void {
			trace("AppConfigTest::grabAppConfig() - " + configID);
			var op:CacheOperation = new CacheOperation();
			op.url = "requestƒ" + configID;
			handleSignal(this, op.stateChanged, onGrabAppConfigStateChanged, 500, null, onGrabAppConfigStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabAppConfigStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			trace("AppConfigTest::onGrabAppConfigStateChanged()");
			var op:Operation = event.args[0];
			
			assertThat(op.state, OperationState.COMPLETE);
			assertThat(op.data, notNullValue());
			assertThat(op.data.chronos, isA(Object));
		}
		private function onGrabAppConfigStateChangedTimeout():void {
			trace("AppConfigTest::onGrabAppConfigStateChangedTimeout()");
			Assert.fail("grabbing device id from cache took more than 500ms!!!!!?");
		}
		
		
	
	}
}