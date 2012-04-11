

package ktu.utils.align.targets {
    
    import com.bit101.components.Component;
    import flash.geom.Point;
    import flash.geom.Rectangle;
	
	
	/**
	 * ...
	 * @author ktu
	 */
	public class MinimalCompsVizAlignTarget extends VizAlignTarget {
		
        /**
		 * no math needed here, the origin is always 0,0
		 */
		override public function set ignoreOriginOffset(value:Boolean):void {
			_ignoreOriginOffset = value;
		}
        
		public function MinimalCompsVizAlignTarget(target:*, ignoreOriginOffset:Boolean = false) {
            _badTargetMessage = "MinimalCompsVizAlignTarget : target must be a Component";
			super(target, ignoreOriginOffset);
		
		}
        
		/**
		 * minimal comp origins are always 0,0
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
			var comp:Component = target as Component;
            comp.move(rect.x, rect.y);
            comp.setSize(rect.width, rect.height);
		}
		
		/**
		 * override this to check if the target you were given is cool.
		 * @param	duck
		 * @return
		 */
		override protected function isAcceptableType(duck:Object):Boolean {
			if (duck is Component)
				return true;
			return false;
		}
	}

}