

package ktu.utils.align.targets {
	
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ktu.utils.align.targets.VizAlignTarget;
	
	
	/**
	 * ...
	 * @author ktu
	 */
	public class StageVizAlignTarget extends VizAlignTarget {
		
		/**
		 * no math needed here, the origin is always 0,0
		 */
		override public function set ignoreOriginOffset(value:Boolean):void {
			_ignoreOriginOffset = value;
		}
		
		/**
		 * pass that shit along!
		 * @param	target
		 */
		public function StageVizAlignTarget(target:*, ignoreOriginOffset:Boolean = false) {
            _badTargetMessage = "StageVizAlignTarget : target must be a Stage";
			super(target, ignoreOriginOffset);
		}
		
		
		/**
		 * overriding getTargetBounds only is called when retreiving the original bounds
		 *
		 * this allows for custom implementation of gather the original bounds of a target
		 * @param	target
		 * @return
		 */
		override protected function getTargetBounds(target:*):Rectangle {
			var stage:Stage = target as Stage;
			var bounds:Rectangle;
			
			if (stage.displayState == StageDisplayState.FULL_SCREEN)
				bounds = new Rectangle(0, 0, stage.fullScreenSourceRect.width, stage.fullScreenSourceRect.height);
			else
				bounds = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			return bounds;
		}
		
		/**
		 * stage origin is always 0,0
		 * @param	target
		 * @return
		 */
		override protected function getOriginOffset(target:*):Point {
			return new Point();
		}
		
        /**
         * overriding setTargetBounds to do nothign, you can't change the stage.
         *  stop it
         * @param	target
         * @param	rect
         */
		override protected function setTargetBounds(target:Object, rect:Rectangle):void {
			// empty on purpose
		}
		
		/**
		 * override this to check if the target you were given is cool.
		 * @param	duck
		 * @return
		 */
		override protected function isAcceptableType(duck:Object):Boolean {
			if (duck is Stage)
				return true;
			return false;
		}
	}
}