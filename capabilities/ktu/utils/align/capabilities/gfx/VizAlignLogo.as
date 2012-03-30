package ktu.utils.align.capabilities.gfx {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 *
	 *  This is an embedded asset. for display only.
	 *
	 * ...
	 * @author Keelan
	 */
	//[Embed(source = "../assets/logo.png")]
	public class VizAlignLogo extends Sprite{
		
		[Embed(source = '../../../../../../assets/logo.png')]
		private var logo_src:Class;
		
		public function VizAlignLogo() {
			addChild(new logo_src());
		}
		
	}

}