package com.locatests.chronos.caching.assets {
	
	import com.adobe.utils.StringUtil;
	import com.locamoda.chronos.caching.AssetCache;
	import com.locamoda.chronos.caching.CacheDeterminant;
	import com.locamoda.chronos.services.operations.CacheOperation;
	import com.locamoda.chronos.services.operations.Operation;
	import com.locamoda.chronos.services.states.OperationState;
	import com.locamoda.obscure.root;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.flexunit.runners.Parameterized;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.notNullValue;
	import org.osflash.signals.Signal;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.SignalAsyncEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class StoreAsset {
		
		
		public static var assetCache:AssetCache = new AssetCache();
		
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
		public function storeAsset(data:Object):void {
			trace("StoreAsset::storeAsset()");
			// store tjhe asset
			var op:CacheOperation = new CacheOperation();
			op.url = CacheDeterminant.ASSET_CACHE + CacheDeterminant.URL_SEPERATOR + data.urlRequest.url;
			op.dataToCache = data.data;
			assetCache.execute(op);
			
			// Table SO checks
			var tableLSO:SharedObject = CacheDeterminant.getLSO(CacheDeterminant.ASSET_CACHE);
			var assetData:Object = tableLSO.data[data.urlRequest.url];
			assertThat(assetData, notNullValue());
			assertThat(assetData, isA(Object));
			assertThat(assetData.gc, isA(Object));
			assertThat(assetData.gc.lastAccessed, isA(Number));
			assertThat(assetData.gc.size, isA(Number));
			assertThat(assetData.data, isA(String));
			
			// Asset SO checks
			
			var assetLSO:SharedObject = SharedObject.getLocal ("com/locamoda/assets/" + assetData.data, root.uri);
			assertThat(assetLSO, notNullValue());
			assertThat(assetLSO, isA(SharedObject));
			assertThat(assetLSO.data.data, isA(ByteArray));
			
		}
	}
}