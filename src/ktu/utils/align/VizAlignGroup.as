
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
		
		protected var _appliedOffsetOrig:Rectangle;
		protected var _appliedOffsetEnd:Rectangle;
		
		public function get targets():Array/*VizAlignTarget*/ {
			return _targets;
		}
		
		override public function set applyOriginOffset(value:Boolean):void {
			_applyOriginOffset = value;
			_targets[0].applyOriginOffset = value
			var groupEnd:Rectangle = _targets[0].end.clone();
			var groupOrig:Rectangle = targets[0].orig.clone();
			for (var i:int = 1; i < _targets.length; i++) {
				var t:VizAlignTarget = _targets[i];
				t.applyOriginOffset = value;
				groupEnd = groupEnd.union(t.end);
				groupOrig = groupOrig.union(t.orig);
			}
			if (value) {
				_end = groupEnd;
				_orig = groupOrig;
			}
		}
		
		public function VizAlignGroup(targets:Array) {
			_targets = targets;
			super(new Sprite());
		}
		
		override protected function init ():void {
			var groupEnd:Rectangle = _targets[0].end.clone();
			for (var i:int = 1; i < _targets.length; i++) {
				var t:VizAlignTarget = _targets[i];
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
				t.applyEndBounds();
			}
		}
		/**
		 * 	Update all of the target end rectangles to account for the end rectangle of the group
		 * 
		 */
		public function updateTargetsEnds ():void {
			for each (var t:VizAlignTarget in _targets) {
				figureTargetEnd(t);
			}
		}
		
		/**
		 * Needs updating to actually clone it, but I'm thinking no one  will ever clone and I should remove it
		 * 
		 * @param	target
		 * @return
		 */
		override public function clone(target:DisplayObject = null):VizAlignTarget {
			var v:VizAlignGroup = new VizAlignGroup(_targets);
			return v;
		}
		
		/**
		 * Not sure if I actually need this method yet... but might
		 * 
		 */
		private function applyOffsetToTargets():void {
			
		}
		/**
		 * Not sure if I actually need this method yet... but might
		 * 
		 */
		private function removeOffsetFromTargets():void {
			
		}
		
		/**
		 * figures the offset that the target has from the origin of the group
		 * 
		 * @param	t
		 * @return
		 */
		private function offsetFromGroupOrigin(t:VizAlignTarget):Point {
			var p:Point = new Point();
			p.x = t.orig.x - _orig.x;
			p.y = t.orig.y - _orig.y;
			return p;
		}
		/**
		 * 	update a target to have the appropriate end rectangle
		 * 
		 * @param	t
		 * @return
		 */
		private function figureTargetEnd (target:VizAlignTarget):void {
			var s:Point = scale;
			var offset:Point = offsetFromGroupOrigin(target);
			target.end.x = _end.x + (offset.x * s.x);
			target.end.y = _end.y + (offset.y * s.y);
			// this isn't right....
			target.end.width = target.target.width * s.x;
			target.end.height = target.target.height * s.y;
		}
		
		/** @private */
		override public function toString ():String {
			var str:String = ""
			for (var i:int = 0; i < _targets.length; i++) {
				str += _target.toString() + "\n";
			}
			return str;
		}
	}
}