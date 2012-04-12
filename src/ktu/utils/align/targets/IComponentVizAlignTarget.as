package ktu.utils.align.targets {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	/**
	 * ...
	 * @author ktu
	 */
	public class IComponentVizAlignTarget extends VizAlignTarget {
		
        /**
         * no origin, so we'll just set the value
         */
        override public function set ignoreOriginOffset(value:Boolean):void {
            _ignoreOriginOffset = value;
        }
        /**
         * 
         * @param	target IComponent target!
         * @param	ignoreOriginOffset
         */
		public function IComponentVizAlignTarget(target:*, ignoreOriginOffset:Boolean = false){
			super(target, ignoreOriginOffset);
		}
		
		/**
		 * pfshhh always 0,0 for us baby
		 * @param	target
		 * @return
		 */
		override protected function getOriginOffset(target:*):Point {
			return new Point();
		}
		/**
		 * return the offsetPaddedBounds - right?
		 * @param	target
		 * @return
		 */
		override protected function getTargetBounds(target:*):Rectangle {
			return super.getTargetBounds(target);
		}
		/**
		 * will set the x,y,width, height
		 * @param	target
		 * @param	rect
		 */
		override protected function setTargetBounds(target:Object, rect:Rectangle):void {
			super.setTargetBounds(target, rect);
		}
		
		override protected function isAcceptableType(duck:Object):Boolean {
			if (duck is IComponent) 
                return true;
            return false;
		}
	}

}