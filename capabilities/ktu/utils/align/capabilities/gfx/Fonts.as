package ktu.utils.align.capabilities.gfx {
	import flash.text.Font;
	
	/**
	 * ...
	 * @author ktu
	 */
	public class Fonts {
		
		
		[Embed(source = "../../../../../../assets/CORBEL.TTF", fontName = "Corbel")]
		static public var CORBEL:Class;
		Font.registerFont(CORBEL);
		
		
		
		
		public function Fonts(){
			
		}
		
	}

}