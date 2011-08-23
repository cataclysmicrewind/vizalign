package ktu.utils.align.methods {
	/**
	 * ...
	 * @author ...
	 */
	public class MethodManifest {
		
		public function get left ():Left { return new Left(); }
		public function get horizontal ():Horizontal { return new Horizontal(); }
		public function get right ():Right { return new Right(); }
		
		public function get top ():Top { return new Top(); }
		public function get vertical ():Vertical { return new Vertical(); }
		public function get bottom ():Bottom { return new Bottom(); }
		
		public function get topLeft ():TopLeft { return new TopLeft(); }
		public function get topRight ():TopRight { return new TopRight(); }
		public function get bottomLeft ():BottomLeft { return new BottomLeft(); }
		public function get bottomRight ():BottomRight { return new BottomRight(); }
		
		public function get adjacentLeft ():AdjacentLeft { return new AdjacentLeft(); }
		
		
		
	}

}