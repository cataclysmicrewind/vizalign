package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ktu
	 */
	public interface IAlignMethod {
		
		function alignTargetsToTCS(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void;
		
	}
	
}