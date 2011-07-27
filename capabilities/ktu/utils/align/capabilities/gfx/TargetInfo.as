package ktu.utils.align.capabilities.gfx {
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.Style;
	import com.bit101.components.Text;
	import com.bit101.components.TextArea;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import ktu.utils.align.AlignMethods;
	import ktu.utils.align.VizAlign;
	import ktu.utils.align.VizAlignment;
	/**
	 * 
	 * 	Displays Last Selected target information
	 * 
	 * 	TODO:
	 * 		Needs beautification!!!
	 * 
	 * ...
	 * @author Ktu
	 */
	public class TargetInfo extends Sprite {

		public var currentTarget:Target;
		
		private var panel:Panel;
		private var header:Label;
		private var targetDetails:Label;
		
		private var output:TextField = new TextField();
		private var bg:Shape = new Shape();
		private var targetName:Label;
		private var targetProps:Label;
		private var vrule:Sprite;
		
		private static const VRULE_COLOR:uint = Style.LIST_ROLLOVER
		
		
		
		public function TargetInfo() {
			addChild(bg);
			addChild(output);
			//drawBG();
			//setupTextField ();
			build();
		}
		
		private function drawBG():void {
			bg.graphics.lineStyle(1, 0x666666, 1, true, "none", "none", "none");
			bg.graphics.beginFill(0x66FFFF, .2);
			bg.graphics.drawRect (0, 0, 150, 200);
			bg.graphics.endFill();
		}
		
		private function setupTextField():void {
			output.width = 150;
			output.height = 200;
		}
		
		public function onTargetSelected (e:MouseEvent = null):void {
			currentTarget = Target(e.target);
			rewrite();
			// setup a timer to have it check again because of double click shit
		}
		
		private function rewrite ():void {
			
			var fmt:TextFormat = new TextFormat(null, null, currentTarget.color, true);
			fmt.align = "center";
			fmt.size = 16;
			targetName.textField.defaultTextFormat = fmt;
			
			var name:String = currentTarget.name;
			targetName.text = name;
			
			
			var props:String = "";
			props += "x";
			props += "\n";
			props += "y";
			props += "\n";
			props += "width";
			props += "\n";
			props += "height";
			props += "\n";
			props += "x offset";
			props += "\n";
			props += "y offset";
			props += "\n";
			props += "getBounds().x";
			props += "\n";
			props += "getBounds().y";
			
			fmt = targetProps.textField.getTextFormat();
			fmt.align = "right";
			targetProps.textField.defaultTextFormat = fmt;
			
			targetProps.text = props;
			
			
			
			
			var str:String = "";
			str += currentTarget.x;
			str += "\n";
			str += currentTarget.y;
			str += "\n";
			str += currentTarget.width;
			str += "\n";
			str += currentTarget.height;
			str += "\n";
			str += currentTarget.originX;
			str += "\n";
			str += currentTarget.originY;
			str += "\n";
			str += currentTarget.getBounds(stage).left;
			str += "\n";
			str += currentTarget.getBounds(stage).top;
			
			targetDetails.text = str;
			
			
			
			
			
			if (vrule && vrule.parent) return; 
			
			vrule = new Sprite();
			vrule.graphics.lineStyle(1, VRULE_COLOR, 1, true, "none", "none", "none");
			vrule.graphics.lineTo(0, 120);
			vrule.x = 90;//targetProps.x + targetProps.width + 3;
			vrule.y = targetProps.y;
			addChild(vrule);
			
			
		}
		
		private function build():void {
			panel = new Panel(this);
			panel.width = 150;
			panel.height = 200;
			panel.color = Style.BOTTOM;
			
			
			header = new Label(panel, 5, 5, "Target Info:");
			header.autoSize = false;
			header.width = panel.width - 10;
			
			var infoPanel:Panel = new Panel(panel, 5, header.y + header.height + 10);
			infoPanel.width = panel.width - 10;
			infoPanel.height = panel.height - infoPanel.y - 5
			
			
			
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			fmt.align = "center";
			header.textField.defaultTextFormat = fmt;
			header.text = "target info:";
			
			
			targetName = new Label(panel, 5, header.y + header.height + 10);
			targetName.autoSize = false;
			targetName.width = panel.width - 10;
			
			targetProps = new Label(panel, 0, header.y + header.height + 5 + 40);
			targetProps.textField.multiline = true;
			targetProps.x = 10;
			
			targetDetails = new Label(panel, 100, header.y + header.height + 5 + 40);
			targetDetails.width = panel.width - 110;
			targetDetails.height = panel.height - targetDetails.y - 5;
			targetDetails.textField.multiline = true;
			
		}
	}

}