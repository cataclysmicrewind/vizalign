
package ktu.utils.align {
	
	import flash.display.DisplayObject;


	/**
	* ...
	* @author ...
	*/
	public class VizAlignGroup extends VizAlignTarget {
		
		private var _targets:Array/*VizAlignTarget*/;
		
		public function VizAlignGroup(targets:Array) {
			_targets = targets;
			
		}
		
		private function init ():void {
			_orig.x 		= _end.x 		= target.x;
			_orig.y 		= _end.y 		= target.y;
			_orig.width 	= _end.width 	= target.width;
			_orig.height 	= _end.height 	= target.height;
			
			_originOffset = new Point(target.getBounds(target).x, target.getBounds(target).y);
		}
	}
}