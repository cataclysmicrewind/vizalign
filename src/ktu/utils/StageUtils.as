package ktu.utils {
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Ktu
	 */
	public class StageUtils {
		
		public static function getStageBounds(stage:Stage):Rectangle {
			if (stage.displayState == StageDisplayState.FULL_SCREEN) {
				return new Rectangle (0, 0, stage.fullScreenSourceRect.width, stage.fullScreenSourceRect.height);
			} else {
				return new Rectangle (0, 0, stage.stageWidth, stage.stageHeight);
			}
		}
		
	}

}