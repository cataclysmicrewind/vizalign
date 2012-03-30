package ktu.utils.align.capabilities.gfx {
	import flash.text.Font;
	
	/**
	 * ...
	 * @author ktu
	 */
	public class Fonts {
		
		
		[Embed( source = '../../../../../../assets/CORBEL.TTF',
				embedAsCFF = 'false',
				fontName = 'corbel'
		)]
		static public var CORBEL:Class;
		Font.registerFont(CORBEL);
		
		
		
		
		public function Fonts(){
			
		}
		
	}

}