package com.locatests.chronos.caching.assets {
	
	import com.locamoda.chronos.caching.AssetCache;
	import com.locamoda.chronos.caching.CacheDeterminant;
	import com.locamoda.chronos.services.operations.CacheOperation;
	import com.locamoda.chronos.services.operations.Operation;
	import com.locamoda.chronos.services.states.OperationState;
	import flash.display.DisplayObject;
	import org.flexunit.Assert;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.nullValue;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.SignalAsyncEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class GrabAsset {
		
		
		public static var assetCache:AssetCache = new AssetCache();
		
		
		/**********************************************************************
		 **********************************************************************
		 * 
		 * 		Test grabbing an asset that does not exist in cache
		 * 
		 **********************************************************************
		 **********************************************************************
		 */
		public function grabBadAsset(data:Object):void {
			trace("AssetCacheTest::grabBadAsset() - Attempting : \"" + data.urlRequest.url + "\"");
			var op:CacheOperation = new CacheOperation();
			op.url = CacheDeterminant.ASSET_CACHE + CacheDeterminant.URL_SEPERATOR + data.urlRequest.url;
			handleSignal(data.testCase, op.stateChanged, onGrabBadAssetStateChanged, 50000, null, onGrabBadAssetStateChangedTimeout);
			assetCache.execute(op);
		}
		private function onGrabBadAssetStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var op:Operation = event.args[0];
			trace("AssetCacheTest::onGrabBadAssetStateChanged() - op.state = " + op.state);
			assertThat(op.state, OperationState.ERROR);
			assertThat(op.data, nullValue());
		}
		private function onGrabBadAssetStateChangedTimeout(obj:*):void {
			trace("AssetCacheTest::onGrabBadAssetStateChangedTimeout() - took longer than 500ms to grab asset");
			Assert.fail("grabbing asset from cache took more than 500ms!!!!!?");
		}
		 
		 
		
		 /*********************************************************************
		 **********************************************************************
		 * 
		 * 		Test grabbing an asset that does exist in cache
		 * 
		 **********************************************************************
		 **********************************************************************
		 */
		public function grabAsset(data:Object):void {
			var op:CacheOperation = new CacheOperation();
			op.url = CacheDeterminant.ASSET_CACHE + CacheDeterminant.URL_SEPERATOR + data.urlRequest.url;
			handleSignal(data.testCase, op.stateChanged, onGrabAssetStateChanged, 50000, data, onGrabAssetStateChangedTimeout);
			assetCache.execute(op);
		}
		private function onGrabAssetStateChanged(event:SignalAsyncEvent, passThroughData:Object ):void {
			var op:Operation = event.args[0];
			trace("AssetCacheTest::onGrabAssetStateChanged() - op.state = " + op.state);
			assertThat(op.state, OperationState.COMPLETE);
			assertThat(op.data, isA(DisplayObject));
		}
		private function onGrabAssetStateChangedTimeout(obj:*):void {
			trace("AssetCacheTest::onGrabAssetStateChangedTimeout() - took longer than 500ms to grab asset");
			Assert.fail("grabbing asset from cache took more than 500ms!!!!!?");
		}
	}
}