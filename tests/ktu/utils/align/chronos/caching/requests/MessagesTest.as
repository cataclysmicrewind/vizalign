
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
	import org.hamcrest.number.greaterThan;
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
	[TestCase(order=2)]
	[RunWith("org.flexunit.runners.Parameterized")]
	public class MessagesTest {
		
		private var foo:Parameterized;
		
		public static var requestCache:RequestCache;
		
		
		[Embed(source='../../../../../../bin/peterPanMessages.json', mimeType='application/octet-stream')]
		public static var PeterPanMessages:Class;
		[Embed(source='../../../../../../bin/clientsFromHellMessages.json', mimeType='application/octet-stream')]
		public static var ClientsFromHellMessages:Class;
		[Embed(source='../../../../../../bin/babsonMessages.json', mimeType='application/octet-stream')]
		public static var BabsonMessages:Class;
		
		public static var messagesList:Array = [
			[ JSON.decode(String(new PeterPanMessages())).entries, "appConfig_photoConfig" ], 
			[ JSON.decode(String(new ClientsFromHellMessages())).entries, "appConfig_comboConfig" ], 
			[ JSON.decode(String(new BabsonMessages())).entries, "appConfig_fenrirConfig" ]
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
		 * try to grab a non existant messages
		 * 
		 * 
		 * 
		 * 
		 */
		[Test ( order = 0,
				async,
				dataProvider = "messagesList",
				description = "try to grab messages that do not exist in LSO"
		)]
		public function grabBadMessages(messages:Object, configID:String):void {
			trace("MessagesTest::grabBadMessages() - " + configID);
			var op:CacheOperation = new CacheOperation();
			op.url = "messagesƒ" + configID;;
			handleSignal(this, op.stateChanged, onGrabBadMessagesStateChanged, 500, null, onGrabBadMessagesStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabBadMessagesStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var op:Operation = event.args[0];
			trace("MessagesTest::onGrabBadMessagesStateChanged() - op.state = " + op.state);
			assertThat(op.state, OperationState.ERROR);
		}
		private function onGrabBadMessagesStateChangedTimeout():void {
			trace("MessagesTest::onGrabBadMessagesStateChangedTimeout()");
			Assert.fail("grabbing app config from cache took more than 500ms!!!!!?");
		}
		
		
		
		[Test (	order = 1,
				dataProvider = "messagesList",
				description = "store a app config in the LSO"
		)]
		public function storeMessages(messages:Array, configID:String):void {
			trace("MessagesTest::storeMessages() - " + configID);
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
		[Test ( order = 2,
				async,
				dataProvider = "messagesList",
				description = "try to grab messages that should exist in LSO"
		)]
		public function grabMessages(messages:Object, configID:String):void {
			trace("MessagesTest::grabMessages() - " + configID);
			var op:CacheOperation = new CacheOperation();
			op.url = "messagesƒ" + configID;
			handleSignal(this, op.stateChanged, onGrabMessagesStateChanged, 500, null, onGrabMessagesStateChangedTimeout);
			requestCache.execute(op);
		}
		private function onGrabMessagesStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			trace("MessagesTest::onGrabMessagesStateChanged()");
			var op:Operation = event.args[0];
			assertThat(op.state, OperationState.COMPLETE);
			assertThat(op.data, isA(Array));
			assertThat(op.data.length, greaterThan(0));
		}
		private function onGrabMessagesStateChangedTimeout():void {
			trace("MessagesTest::onGrabMessagesStateChangedTimeout()");
			Assert.fail("grabbing messages from cache took more than 500ms!!!!!?");
		}
	}
}