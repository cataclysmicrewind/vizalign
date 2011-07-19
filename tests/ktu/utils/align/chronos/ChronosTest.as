package com.locatests.chronos {

	import com.locamoda.api.API;
	import com.locamoda.api.yfapi;
	import com.locamoda.chronos.Chronos;
	import flash.display.Stage;
	import org.osflash.signals.utils.SignalAsyncEvent;
	
	import org.flexunit.Assert;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.allOf;
	import org.hamcrest.object.hasProperty;
	import org.hamcrest.object.notNullValue;
	import org.osflash.signals.utils.handleSignal;
	import org.fluint.uiImpersonation.UIImpersonator;
	
	
	
   public class ChronosTest {
      	
	    public static var chronos:Chronos;
	   
		[After]
		public function afterEach():void {
			chronos = null;
		}
		
		[Test (description="make sure service is constructed")]
		public function constructorTest():void {
			chronos = new Chronos();
			assertThat(chronos, isA(Chronos));
		}
		
		[Test (async,description="make sure API.ready is called",ui)]
		public function checkReadyTest():void {
			chronos = new Chronos();
			handleSignal(this, API.newMessages, kairosMessagesReady, 4000, null);
			UIImpersonator.addChild(chronos);
		}
		public function kairosMessagesReady(event:SignalAsyncEvent, passThroughData:Object ):void {
			assertThat(event.args[0], allOf( notNullValue(), isA(Object), hasProperty("entries") ));
		}
		public function kairosMessagesTimeout( passThroughData:Object ):void {
			Assert.fail( "Timeout reached before event");			
		}
   }
}