package ktu.utils.align.capabilities.utils {
	/**
	 * ...
	 * @author Ktu
	 */
	public class ColorUtils {
		
		public function ColorUtils() {
			
		}
		
		
		public static function darken(color:Number, ratio:Number):Number{
            var rgb:Object = getRGB(color);
            for (var ele:String in rgb){
                rgb[ele] = rgb[ele] * (1-ratio);
            }
            return (getHex(rgb.r, rgb.g, rgb.b));
        }
		public static function getRGB(color:Number):Object{
            var r:Number = color >> 16 & 0xFF;
            var g:Number = color >> 8 & 0xFF;
            var b:Number = color & 0xFF;
            return {r:r, g:g, b:b};
        }
		public static function getHex(r:Number, g:Number, b:Number):Number{
            var rgb:String = "0x" + (r<16?"0":"") + r.toString(16) + (g<16?"0":"") + g.toString(16) + (b<16?"0":"") + b.toString(16);
            return Number(rgb);
        }
	}

}