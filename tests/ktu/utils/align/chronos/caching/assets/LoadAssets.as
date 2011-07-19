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
	public class LoadAssets {
		
		
		public static var assetCache:AssetCache = new AssetCache();
		
		
		
		public static var loadComplete:Signal = new Signal();
		public static var loadCount:int = 0;
		public static var loadCompleted:int = 0;
		
		static public function loadAsset(loader:Loader, urlRequest:URLRequest, testCase:Class):String {
			trace("AssetCacheTest::loadAsset() - url = " + urlRequest.url);
			try {
				loader.load(urlRequest);
				loadCount ++;
				trace("loading " + urlRequest.url);
			} catch (error:Error) {
				return "Loader attempting to load: " + urlRequest.url + " threw: "+ error;
			}
		 
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoadComplete, false, 0, true);
			return "good";
		}
		
		
		static private function onLoadComplete (e:Event):void {
			var loader:Loader = LoaderInfo(e.target).loader;
			trace("AssetCacheTest::onLoadComplete() - " + e +" = " + loader.content);
			loadCompleted ++;
			if (loadCompleted == loadCount) loadComplete.dispatch();
		}
	}
}