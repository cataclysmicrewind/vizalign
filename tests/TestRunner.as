package {
	
	import flash.display.Sprite;
	import ktu.utils.align.AllSuite;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;
	
	
	public class TestRunner extends Sprite {
		
		public function TestRunner():void {
			super();
			init();
		}
		public function init():void {
			var core:FlexUnitCore = new FlexUnitCore();
			core.visualDisplayRoot = this;
			core.addListener(new CIListener());
			core.run(AllSuite);
		}
	}
}