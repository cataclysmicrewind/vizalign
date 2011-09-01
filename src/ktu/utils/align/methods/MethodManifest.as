package ktu.utils.align.methods {
	/**
	 * ...
	 * @author ...
	 */
	public class MethodManifest {
		
		
		
		static public function get left ():LeftAligner { return new LeftAligner(); }
		static public function get horizontal ():HorizontalAligner { return new HorizontalAligner(); }
		static public function get right ():RightAligner { return new RightAligner(); }
		
		static public function get top ():TopAligner { return new TopAligner(); }
		static public function get vertical ():VerticalAligner { return new VerticalAligner(); }
		static public function get bottom ():BottomAligner { return new BottomAligner(); }
		
		static public function get center ():CenterAligner { return new CenterAligner (); }
		
		static public function get topLeft ():TopLeftAligner { return new TopLeftAligner(); }
		static public function get topRight ():TopRightAligner { return new TopRightAligner(); }
		static public function get bottomLeft ():BottomLeftAligner { return new BottomLeftAligner(); }
		static public function get bottomRight ():BottomRightAligner { return new BottomRightAligner(); }
		
		
		
		static public function get adjacentLeft ():AdjacentLeftAligner { return new AdjacentLeftAligner(); }
		static public function get adjacentHorizontalLeft ():AdjacentHorizontalLeftAligner { return new AdjacentHorizontalLeftAligner(); }
		static public function get adjacentHorizontalRight ():AdjacentHorizontalRightAligner { return new AdjacentHorizontalRightAligner(); }
		static public function get adjacentRight ():AdjacentRightAligner { return new AdjacentRightAligner(); }
		
		static public function get adjacentTop ():AdjacentTopAligner { return new AdjacentTopAligner(); }
		static public function get adjacentVerticalTop ():AdjacentVerticalTopAligner { return new AdjacentVerticalTopAligner(); }
		static public function get adjacentVerticalBottom ():AdjacentVerticalBottomAligner { return new AdjacentVerticalBottomAligner(); }
		static public function get adjacentBottom ():AdjacentBottomAligner { return new AdjacentBottomAligner(); }
		
		static public function get adjacentTopLeft ():AdjacentTopLeftAligner { return new AdjacentTopLeftAligner(); }
		static public function get adjacentTopRight ():AdjacentTopRightAligner { return new AdjacentTopRightAligner(); }
		static public function get adjacentBottomLeft ():AdjacentBottomLeftAligner { return new AdjacentBottomLeftAligner(); }
		static public function get adjacentBottomRight ():AdjacentBottomRightAligner { return new AdjacentBottomRightAligner(); }
		
		
		
		static public function get distributeLeft ():DistributeLeftAligner { return new DistributeLeftAligner(); }
		static public function get distributeHorizontal ():DistributeHorizontalAligner { return new DistributeHorizontalAligner(); }
		static public function get distributeRight ():DistributeRightAligner { return new DistributeRightAligner(); }
		
		static public function get distributeTop ():DistributeTopAligner { return new DistributeTopAligner(); }
		static public function get distributeVertical ():DistributeVerticalAligner { return new DistributeVerticalAligner(); }
		static public function get distributeBottom ():DistributeBottomAligner { return new DistributeBottomAligner(); }
		
		
		
		static public function get matchWidth ():MatchWidthAligner { return new MatchWidthAligner(); }
		static public function get matchHeight ():MatchHeightAligner { return new MatchHeightAligner(); }
		static public function get matchSize ():MatchSizeAligner { return new MatchSizeAligner(); }
		
		static public function get scaleToFit ():ScaleToFitAligner { return new ScaleToFitAligner(); }
		static public function get scaleToFill ():ScaleToFillAligner { return new ScaleToFillAligner(); }
		
		
		
		static public function get spaceHorizontal ():SpaceHorizontalAligner { return new SpaceHorizontalAligner(); }
		static public function get spaceVertical ():SpaceVerticalAligner { return new SpaceVerticalAligner(); }
		
		
		
		static public function get stackHorizontal ():StackHorizontalAligner { return new StackHorizontalAligner(); }
		static public function get stackVertical ():StackVerticalAligner { return new StackVerticalAligner(); }
	}
}