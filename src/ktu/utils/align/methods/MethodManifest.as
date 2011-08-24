package ktu.utils.align.methods {
	/**
	 * ...
	 * @author ...
	 */
	public class MethodManifest {
		
		
		
		static public function get left ():LeftAlignMethod { return new LeftAlignMethod(); }
		static public function get horizontal ():HorizontalAlignMethod { return new HorizontalAlignMethod(); }
		static public function get right ():RightAlignMethod { return new RightAlignMethod(); }
		
		static public function get top ():TopAlignMethod { return new TopAlignMethod(); }
		static public function get vertical ():VerticalAlignMethod { return new VerticalAlignMethod(); }
		static public function get bottom ():BottomAlignMethod { return new BottomAlignMethod(); }
		
		static public function get center ():CenterAlignMethod { return new CenterAlignMethod (); }
		
		static public function get topLeft ():TopLeftAlignMethod { return new TopLeftAlignMethod(); }
		static public function get topRight ():TopRightAlignMethod { return new TopRightAlignMethod(); }
		static public function get bottomLeft ():BottomLeftAlignMethod { return new BottomLeftAlignMethod(); }
		static public function get bottomRight ():BottomRightAlignMethod { return new BottomRightAlignMethod(); }
		
		
		
		static public function get adjacentLeft ():AdjacentLeftAlignMethod { return new AdjacentLeftAlignMethod(); }
		static public function get adjacentHorizontalLeft ():AdjacentHorizontalLeftAlignMethod { return new AdjacentHorizontalLeftAlignMethod(); }
		static public function get adjacentHorizontalRight ():AdjacentHorizontalRightAlignMethod { return new AdjacentHorizontalRightAlignMethod(); }
		static public function get adjacentRight ():AdjacentRightAlignMethod { return new AdjacentRightAlignMethod(); }
		
		static public function get adjacentTop ():AdjacentTopAlignMethod { return new AdjacentTopAlignMethod(); }
		static public function get adjacentVerticalTop ():AdjacentVerticalTopAlignMethod { return new AdjacentVerticalTopAlignMethod(); }
		static public function get adjacentVerticalBottom ():AdjacentVerticalBottomAlignMethod { return new AdjacentVerticalBottomAlignMethod(); }
		static public function get adjacentBottom ():AdjacentBottomAlignMethod { return new AdjacentBottomAlignMethod(); }
		
		static public function get adjacentTopLeft ():AdjacentTopLeftAlignMethod { return new AdjacentTopLeftAlignMethod(); }
		static public function get adjacentTopRight ():AdjacentTopRightAlignMethod { return new AdjacentTopRightAlignMethod(); }
		static public function get adjacentBottomLeft ():AdjacentBottomLeftAlignMethod { return new AdjacentBottomLeftAlignMethod(); }
		static public function get adjacentBottomRight ():AdjacentBottomRightAlignMethod { return new AdjacentBottomRightAlignMethod(); }
		
		
		
		static public function get distributeLeft ():DistributeLeftAlignMethod { return new DistributeLeftAlignMethod(); }
		static public function get distributeHorizontal ():DistributeHorizontalAlignMethod { return new DistributeHorizontalAlignMethod(); }
		static public function get distributeRight ():DistributeRightAlignMethod { return new DistributeRightAlignMethod(); }
		
		static public function get distributeTop ():DistributeTopAlignMethod { return new DistributeTopAlignMethod(); }
		static public function get distributeVertical ():DistributeVerticalAlignMethod { return new DistributeVerticalAlignMethod(); }
		static public function get distributeBottom ():DistributeBottomAlignMethod { return new DistributeBottomAlignMethod(); }
		
		
		
		static public function get matchWidth ():MatchWidthAlignMethod { return new MatchWidthAlignMethod(); }
		static public function get matchHeight ():MatchHeightAlignMethod { return new MatchHeightAlignMethod(); }
		static public function get matchSize ():MatchSizeAlignMethod { return new MatchSizeAlignMethod(); }
		
		static public function get scaleToFit ():ScaleToFitAlignMethod { return new ScaleToFitAlignMethod(); }
		static public function get scaleToFill ():ScaleToFillAlignMethod { return new ScaleToFillAlignMethod(); }
		
		
		
		static public function get spaceHorizontal ():SpaceHorizontalAlignMethod { return new SpaceHorizontalAlignMethod(); }
		static public function get spaceVertical ():SpaceVerticalAlignMethod { return new SpaceVerticalAlignMethod(); }
		
		
		
		static public function get stackHorizontal ():StackHorizontalAlignMethod { return new StackHorizontalAlignMethod(); }
		static public function get stackVertical ():StackVerticalAlignMethod { return new StackVerticalAlignMethod(); }
	}
}