package ktu.utils.align.capabilities {
	import com.bit101.components.HScrollBar;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import flash.utils.describeType;
	import ktu.utils.align.VizAlignment;
	
	/**
	 * ...
	 * @author ktu
	 */
	public class SyntaxVisualizer extends Sprite {
		private var scrollBar:HScrollBar;
		private var txt:TextField;
		private var slideBounds:Rectangle;
		
		public function SyntaxVisualizer() {
			txt = new TextField();
			txt.x = 5
			addChild(txt);
			
			scrollBar = new HScrollBar(this, 0, 0);
			scrollBar.addEventListener(Event.CHANGE, onScroll);
			scrollBar.setSize(750, 12);
			scrollBar.setSliderParams(0, 10, 0);
			scrollBar.autoHide = true;
		}
		
		public function setSize(w:int, h:int):void {
			txt.width = w - 10;
			fitTextFieldHeightAroundText(txt);
			txt.scrollRect = new Rectangle(0, 0, w, h + 12);
			scrollBar.y = h;
			scrollBar.width = w;
		}
		/**
		 * takes in vizalign params and generates the syntax it would require
		 * @param	obj
		 * @return resulting string of the syntax
		 */
		public function visualize(obj:Object):String {
			txt.background = true;
			txt.backgroundColor = 0x000C0F
			var str:String = generateString(obj);
			
			txt.htmlText = str;
			trace(txt.htmlText);
			scrollBar.setSliderParams(0, txt.maxScrollH, 0); 
			scrollBar.setThumbPercent(txt.width / txt.textWidth);
			scrollBar.pageSize = 1;
			scrollBar.lineSize = 1;
			return str;
		}
		
		
		public function set defaultTextFormat(value:TextFormat):void {
			txt.defaultTextFormat = value;
		}
		
		
		
		
		
		private function onScroll(e:Event):void {
			txt.scrollH = scrollBar.value;
		}
		
		private function generateString(obj:Object):String {
			var str:String = "";
			str += color("VizAlign", "23AFA5") + ".align(["
			str += targets(obj.targets);
			str += "], ["
			str += alignments(obj.alignments);
			str += "], "
			str += String(obj.ignoreOrigins);
			str += ", "
			str += String(obj.applyResults);
			str += ", "
			str += String (obj.pixelHinting);
			str += ");";
			return str;
		}
		
		
		private function targets(targets:Array):String {
			var ret:String = "";
			for (var i:int = 0; i < targets.length; i++) {
				var o:DisplayObject = targets[i];
				ret += o.name;
				ret += i == targets.length -1 ? "" : ", "
			}
			return ret;
		}
		private function alignments(alignments:Array):String {
			var ret:String = ""
			for (var i:int = 0; i < alignments.length; i++) {
				var a:VizAlignment = alignments[i];
				var type:XML = describeType(a.rectangleAligner);
				ret += color("new", "4E94E0") + " " + color("VizAlignment", "23AFA5") + "(" + color("new", "4E94E0") + " " + color(type.@name.split("::")[1], "23AFA5") + "(), " + a.tcs.name + ")";
				ret += (i == alignments.length - 1) ? "" : ", ";
			}
			ret += ")";
			return ret;
		}
		private function color(string:String, color:String):String {
			var str:String = "";
			str += "<FONT FACE=\"_typewriter\" SIZE=\"12\" COLOR=\"#" + color + "\" LETTERSPACING=\"0\" KERNING=\"0\">"
			str += string + "</FONT>";
			return str;
		}
		
		
		
		
		
		
		static public function fitTextFieldHeightAroundText (tf:TextField, maxheight:Number = 10000):void {
			tf.height = Math.min(getTextFieldTextHeight(tf), maxheight); // end if
		}
		static public function getTextFieldTextHeight(tf:TextField):Number {
			if (tf.numLines == 1) { // if only 1 line in textfield
				var met:TextLineMetrics = tf.getLineMetrics(0); // get the metrics for the line
				return met.ascent + met.descent + 2 * 2 + 4 // set the height of the textfield the ascent + decent + gutters
			} else { // else (more than one line)
				return tf.textHeight + 2 * 2 // set the height to the height of the text + the gutters
			}
		}
		
	}
}