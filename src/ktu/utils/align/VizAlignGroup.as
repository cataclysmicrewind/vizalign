
package ktu.utils.align {
	
	import flash.display.DisplayObject;
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
		
		public function get targets():Array/*VizAlignTarget*/ {
			return _targets;
		}
		
		override public function set applyOriginOffset(value:Boolean):void {
			_applyOriginOffset = value;
			if (value) {
				for each (var t:VizAlignTarget in _targets) 
					t.applyOriginOffset = true;
			} else {
				for each (var t:VizAlignTarget in _targets)
					t.applyOriginOffset = false;
			}
		}
		
		public function VizAlignGroup(targets:Array) {
			_targets = targets;
			super(new Sprite());
		}
		
		override protected function init ():void {
			var groupEnd:Rectangle = new Rectangle();
			for each (var t:VizAlignTarget in _targets) {
				groupEnd = groupEnd.union(t.end);
			}
			_orig = groupEnd.clone();
			_end = groupEnd;
			
			// TODO: consider the original offset of the top left object?
			_originOffset = new Point();
		}
		
		override public function applyOrigBounds():void {
			for each (var t:VizAlignTarget in _targets) {
				t.applyOrigBounds();
			}
		}
		
		override public function applyEndBounds():void {
			var s:Point = scale;
			for each (var t:VizAlignTarget in _targets) {
				var offset:Point = offsetFromGroupOrigin(t);
				t.target.x = _end.x + (offset.x * s.x);
				t.target.y = _end.y + (offset.y * s.y);
				t.target.scaleX += s.x - 1;
				t.target.scaleY += s.y - 1;
			}
		}
		
		override public function clone(target:DisplayObject = null):VizAlignTarget {
			var v:VizAlignGroup = new VizAlignGroup(_targets);
			return v;
		}
		
		private function applyOffsetToTargets():void {
			
		}
		
		private function removeOffsetFromTargets():void {
			
		}
		
		private function offsetFromGroupOrigin(t:VizAlignTarget):Point {
			var p:Point = new Point();
			p.x = t.orig.x - _orig.x;
			p.y = t.orig.y - _orig.y;
			return p;
		}
		
		
		
		/* @private */
		override public function toString ():String {
			var str:String = ""
			for (var i:int = 0; i < _targets.length; i++) {
				str += _target.toString() + "\n";
			}
			return str;
		}
	}
}