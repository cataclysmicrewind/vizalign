package com.locatests.chronos.services {
	import com.locamoda.api.API;
	import com.locamoda.chronos.services.MessageService;
	import org.flexunit.Assert;
	import org.flexunit.assertThat;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.hasProperty;
	import org.hamcrest.object.notNullValue;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.SignalAsyncEvent;

//Create service 
//add listener for new messages
//call initialize

	
	
	
   public class MessageServiceTest {
      	
	    public static var messageService:MessageService;
		
		public var testJSON:Object = {
	"message_streams": [ { 
		"http_url": "http://lms.alpha.locamoda.com/wiffiti/entries?apikey=&sinceDate=1298088000000&tags=pugs&tags=%23pugs&maxResults=14&messageTypes=0&messageTypes=1&messageTypes=2&context=5%3A4105&roboRating=G"
	} ]
};
		
		[AfterClass]
		public static function afterAll():void {
			messageService = null;
		}
		
		[Test (async,description="make sure API.newMessages is called")]
		public function newMessageTest():void {
			messageService = new MessageService();
			handleSignal(this, API.newMessages, onNewMessages, 2000, null, newMessagesTimeout);
			messageService.config = testJSON;
		}
		public function onNewMessages(event:SignalAsyncEvent, passThroughData:Object ):void {
			Assert.assertTrue();
			//assertThat(event.args[0], allOf( notNullValue(), isA(Object), hasProperty("entries") ));
		}
		public function newMessagesTimeout( passThroughData:Object ):void {
			Assert.fail( "Timeout reached before event");			
		}
   }
}