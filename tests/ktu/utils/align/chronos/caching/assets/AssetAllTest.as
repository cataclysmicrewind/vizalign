package com.locatests.chronos.caching.assets {
	import com.locamoda.chronos.caching.AssetCache;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import org.flexunit.runners.Parameterized;
	import org.hamcrest.core.isA;
	import org.osflash.signals.utils.handleSignal;
	/**
	 * ...
	 * @author Ktu
	 */
	[RunWith("org.flexunit.runners.Parameterized")]
	public class AssetAllTest {
		
		private var foo:Parameterized;
		
		
		public static var as2Loader				:Loader 	= new Loader();
		public static var as2URLRequest			:URLRequest = new URLRequest("http://www.rrrrthats5rs.com/media/swfs/timer.swf");
		
		public static var as3DocLoader			:Loader 	= new Loader();
		public static var as3DocURLRequest		:URLRequest = new URLRequest("http://cataclysmicrewind.com/child.swf");
		
		public static var as3TimeLoader			:Loader 	= new Loader();
		public static var as3TimeURLRequest		:URLRequest = new URLRequest("http://cataclysmicrewind.com/noclass.swf");
		
		public static var jpgLoader				:Loader 	= new Loader();
		public static var jpgURLRequest			:URLRequest = new URLRequest("http://www.cataclysmicrewind.com/avatar.jpg");
		
		public static var pngLoader				:Loader 	= new Loader();
		public static var pngURLRequest			:URLRequest = new URLRequest("http://www.cataclysmicrewind.com/avatarSmall.png");
		
		public static var profErnestoLoader		:Loader 	= new Loader();
		public static var profErnestoURLRequest	:URLRequest = new URLRequest("foursquare_ernesto.jpg");
		
		public static var profLoveLoader		:Loader 	= new Loader();
		public static var profLoveURLRequest	:URLRequest = new URLRequest("foursquare_love.jpg");
		
		public static var profMCLoader			:Loader 	= new Loader();
		public static var profMCURLRequest		:URLRequest = new URLRequest("twitter_Minecraft_bigger.jpg");
		
		public static var profMCBigLoader		:Loader 	= new Loader();
		public static var profMCBigURLRequest	:URLRequest = new URLRequest("twitter_minecraftx_bigger.jpg");
		
		public static var profMCSmallLoader		:Loader 	= new Loader();
		public static var profMCSmallURLRequest	:URLRequest = new URLRequest("twitter_WC_reasonably_small.jpg");
		
		
		
		
		public static var beforeClassLoadingAssets:Array = [
			[ {loader:as2Loader , urlRequest:as2URLRequest } ],
			[ {loader:as3DocLoader , urlRequest:as3DocURLRequest } ],
			[ {loader:as3TimeLoader , urlRequest:as3TimeURLRequest } ],
			[ {loader:jpgLoader , urlRequest:jpgURLRequest } ],
			[ {loader:pngLoader , urlRequest:pngURLRequest } ],
			[ {loader:profErnestoLoader , urlRequest:profErnestoURLRequest } ],
			[ {loader:profLoveLoader , urlRequest:profLoveURLRequest } ],
			[ {loader:profMCLoader , urlRequest:profMCURLRequest } ],
			[ {loader:profMCBigLoader , urlRequest:profMCBigURLRequest } ],
			[ {loader:profMCSmallLoader , urlRequest:profMCSmallURLRequest } ]
		];
		public static var loadCount:int = 0;
		public static var loadCompleted:int = 0;
		
		/**
		 * 
		 */
		[BeforeClass(async,
					timeout = "30000"
		)]
		public static function beforeClass ():void {
			trace("AssetAllTest::BeforeClass()");
			flushSO();
			
			loadCount = beforeClassLoadingAssets.length-1;
			handleSignal(AssetAllTest, LoadAssets.loadComplete, onAssetsLoaded, 30000);
			
			for (var i:int = 0; i < beforeClassLoadingAssets.length; i++) {
				loadAsset(i);
			}
		}
		
		public static function flushSO():void {
			trace("AssetAllTest::flushSO()");
			var lso:SharedObject = SharedObject.getLocal("com/locamoda/assets", "/");
			// loop through all props, open the lso and clear it
			var data:Object = lso.data;
			for (var prop:String in data) {
				var so:SharedObject = SharedObject.getLocal("com/locamoda/assets/" + data[prop].data, "/");
				so.clear();
			}
			lso.clear();
		}
		
		static public function loadAsset(index:int):void {
			var data:Object = beforeClassLoadingAssets[index][0];
			LoadAssets.loadAsset(data.loader, data.urlRequest, AssetAllTest);
		}
		static private function onAssetsLoaded(a:*, b:*):void {
			trace("AssetAllTest::onAssetsLoaded()");
			var loaded:int = 0;
			for (var i:int = 0; i < beforeClassLoadingAssets.length; i++) {
				var data:Object = beforeClassLoadingAssets[i][0];
				if (data.loader.content is DisplayObject) {
					loaded++;
				} else {
					trace("AssetAllTest::onAssetsLoaded() - loaded content is not a DisplayObject");
					Assert.fail("A asset was not loaded completely");
				}
			}
			if (loaded == loadCount) {
				trace("AssetAllTest::onAssetsLoaded() - all assets loaded");
				assertTrue(data.loader.content, isA(DisplayObject));
			}
		}
		
		/**
		 * 
		 */
		[AfterClass]
		public static function sack ():void {
			trace("AssetAllTest::AfterClass()");
		}
		
		
		
		
		
		
		
		[Test ( order = 0,
				async,
				timeout = "20000",
				dataProvider = "beforeClassLoadingAssets",
				description = "try to grab AS3Time asset that does not exist in LSO"
		)]
		public function grabBadAsset(data:Object):void {
			trace("AssetAllTest::grabBadAsset()");
			data.testCase = this ;
			var grabAssetTester:GrabAsset = new GrabAsset();
			grabAssetTester.grabBadAsset(data);
			data.testCase = null;
		}
		
		[Test ( order = 1,
				dataProvider = "beforeClassLoadingAssets",
				description = "try to store AS3Time asset in LSO"
		)]
		public function storeAsset (data:Object):void {
			trace("AssetAllTest::storeAsset()");
			data.data = data.loader.contentLoaderInfo.bytes;
			var storeAssetTester:StoreAsset = new StoreAsset();
			storeAssetTester.storeAsset(data);
			delete data.data;
		}
		
		[Test ( order = 2,
				async,
				timeout = "40000",
				dataProvider = "beforeClassLoadingAssets",
				description = "retrieve AS3Time asset in LSO"
		)]
		public function grabAsset (data:Object):void {
			trace("AssetAllTest::grabeAsset()");
			data.testCase = this ;
			var grabAssetTester:GrabAsset = new GrabAsset();
			grabAssetTester.grabAsset(data);
			delete data.testCase;
		}
	}
}