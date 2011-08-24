package ktu.utils.align.methods {
	/**
	 * ...
	 * @author ...
	 */
	public class MethodManifest {
		
		
		
		static public function get left ():Left { return new Left(); }
		static public function get horizontal ():Horizontal { return new Horizontal(); }
		static public function get right ():Right { return new Right(); }
		
		static public function get top ():Top { return new Top(); }
		static public function get vertical ():Vertical { return new Vertical(); }
		static public function get bottom ():Bottom { return new Bottom(); }
		
		static public function get center ():Center { return new Center (); }
		
		static public function get topLeft ():TopLeft { return new TopLeft(); }
		static public function get topRight ():TopRight { return new TopRight(); }
		static public function get bottomLeft ():BottomLeft { return new BottomLeft(); }
		static public function get bottomRight ():BottomRight { return new BottomRight(); }
		
		
		
		static public function get adjacentLeft ():AdjacentLeft { return new AdjacentLeft(); }
		static public function get adjacentHorizontalLeft ():AdjacentHorizontalLeft { return new AdjacentHorizontalLeft(); }
		static public function get adjacentHorizontalRight ():AdjacentHorizontalRight { return new AdjacentHorizontalRight(); }
		static public function get adjacentRight ():AdjacentRight { return new AdjacentRight(); }
		
		static public function get adjacentTop ():AdjacentTop { return new AdjacentTop(); }
		static public function get adjacentVerticalTop ():AdjacentVerticalTop { return new AdjacentVerticalTop(); }
		static public function get adjacentVerticalBottom ():AdjacentVerticalBottom { return new AdjacentVerticalBottom(); }
		static public function get adjacentBottom ():AdjacentBottom { return new AdjacentBottom(); }
		
		static public function get adjacentTopLeft ():AdjacentTopLeft { return new AdjacentTopLeft(); }
		static public function get adjacentTopRight ():AdjacentTopRight { return new AdjacentTopRight(); }
		static public function get adjacentBottomLeft ():AdjacentBottomLeft { return new AdjacentBottomLeft(); }
		static public function get adjacentBottomRight ():AdjacentBottomRight { return new AdjacentBottomRight(); }
		
		
		
		static public function get distributeLeft ():DistributeLeft { return new DistributeLeft(); }
		static public function get distributeHorizontal ():DistributeHorizontal { return new DistributeHorizontal(); }
		static public function get distributeRight ():DistributeRight { return new DistributeRight(); }
		
		static public function get distributeTop ():DistributeTop { return new DistributeTop(); }
		static public function get distributeVertical ():DistributeVertical { return new DistributeVertical(); }
		static public function get distributeBottom ():DistributeBottom { return new DistributeBottom(); }
		
		
		
		static public function get matchWidth ():MatchWidth { return new MatchWidth(); }
		static public function get matchHeight ():MatchHeight { return new MatchHeight(); }
		static public function get matchSize ():MatchSize { return new MatchSize(); }
		
		static public function get scaleToFit ():ScaleToFit { return new ScaleToFit(); }
		static public function get scaleToFill ():ScaleToFill { return new ScaleToFill(); }
		
		
		
		static public function get spaceHorizontal ():SpaceHorizontal { return new SpaceHorizontal(); }
		static public function get spaceVertical ():SpaceVertical { return new SpaceVertical(); }
		
		
		
		static public function get stackHorizontal ():StackHorizontal { return new StackHorizontal(); }
		static public function get stackVertical ():StackVertical { return new StackVertical(); }
	}
}