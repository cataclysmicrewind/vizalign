
package ktu.utils.align {
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ktu.utils.align.VizAlignTarget;


	/**
	* ...
	* @author ...
	*/
	public class VizAlignGroup extends VizAlignTarget {
		
		protected var _targets:Array/*VizAlignTarget*/;
		public function get targets():Array/*VizAlignTarget*/ { return _targets; }
		
		
		override public function set applyOriginOffset(value:Boolean):void {
			_applyOriginOffset = value;
			_targets[0].applyOriginOffset = value;
			var groupEnd:Rectangle = _targets[0].end.clone();
			var groupOrig:Rectangle = targets[0].orig.clone();
			for (var i:int = 1; i < _targets.length; i++) {
				var t:VizAlignTarget = _targets[i];
				t.applyOriginOffset = value;
				groupOrig = groupOrig.union(t.orig);
				groupEnd = groupEnd.union(t.end);
			}
			_end = groupEnd;
			_orig = groupOrig;
		}
		
		public function VizAlignGroup(targets:Array) {
			_targets = targets;
			super(new Sprite());
		}
		
		override protected function init ():void {
			var groupEnd:Rectangle = _targets[0].end.clone();
			for (var i:int = 1; i < _targets.length; i++) 
				groupEnd = groupEnd.union((_targets[i] as VizAlignTarget).orig);
			_orig = groupEnd.clone();
			_end = groupEnd;
		}
		override public function applyOrigBounds():void {
			for each (var t:VizAlignTarget in _targets) t.applyOrigBounds();
		}
		override public function applyEndBounds():void {
			for each (var t:VizAlignTarget in _targets) t.applyEndBounds();
		}
		/**
		 * 	Update all of the target end rectangles to account for the end rectangle of the group
		 * 
		 */
		public function updateTargetsEnds ():void {
			var s:Point = scale;
			var offset:Point;
			for each (var t:VizAlignTarget in _targets) {
				if (t is VizAlignGroup) 
					VizAlignGroup(t).updateTargetsEnds();
				else {
					offset = new Point(t.orig.x - _orig.x, t.orig.y - _orig.y);	// offset from group Origin
					t.end.x = _end.x + (offset.x * s.x);
					t.end.y = _end.y + (offset.y * s.y);
					t.end.width = t.orig.width * s.x;
					t.end.height = t.orig.height * s.y;
				}
			}
		}
		
		
		
		
		/** @private */
		override public function toString ():String {
			var str:String = "VizAlignGroup:: "
			for (var i:int = 0; i < _targets.length; i++) {
				str += _target.toString() + "\n";
			}
			return str;
		}
	}
}