package ktu.utils.align.capabilities {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import ktu.utils.align.AlignMethods;
	import ktu.utils.align.capabilities.gfx.Grid;
	import ktu.utils.align.capabilities.gfx.Target;
	import ktu.utils.align.capabilities.gfx.TargetInfo;
	import ktu.utils.align.capabilities.gfx.VizAlignArena;
	import ktu.utils.align.capabilities.gfx.VizAlignLogo;
	import ktu.utils.align.capabilities.ui.CapabilitiesControls;
	import ktu.utils.align.VizAlign;
	import ktu.utils.align.VizAlignment;
	
	/**
	 * 	This class is the Document class for the Capabilities SWF.
	 *
	 * 	This swf is designed to show off what VizAlign can do
	 *
	 *
	 *
	 *
	 * Coding Concept:
	 *
	 * 		This class will put a TargetArena in the stage,
	 * 		then a ControlPanel. The control panel is told about
	 * 		all possible Targets and TCSs in the TargetArena
	 * 		The ControlPanel has some TCSs of its own (STAGE, inputs?)
	 *
	 * 		That is all that this class has to do.
	 *
	 *
	 * ...
	 * @author Keelan
	 */
	public class VizAlignCapabilities extends Sprite{
		
		public function VizAlignCapabilities() {
			
			var arena:VizAlignArena = new VizAlignArena();
			arena.setSize(750, 500);
			addChild(arena);
			
			addTCS(arena);
			addTargets(arena);
			addTargetInfo(arena);
			
			var controlPanel:CapabilitiesControls = new CapabilitiesControls();
			controlPanel.y = 500;
			addChild(controlPanel);
			
			//
			var alignments:Array = [new VizAlignment(AlignMethods.adjacentLeft, arena.targetCoordinateSpaces[2])]
									//new VizAlignment(AlignMethods.scaleToFit, arena.targetCoordinateSpaces[1]) ];
			VizAlign.align (arena.targets, alignments, true, true);
			
		}
		
		
		
		private function addTCS(arena:VizAlignArena):void{
			var l:VizAlignLogo = new VizAlignLogo();
			l.x = 10;
			l.y = 10;
			arena.addTCS(l);
			
			
			var g:Grid = new Grid();
			g.x = 190;
			g.y = 70;
			g.setSize(360, 360);
			g.addInterval(2, 0x999999);
			g.addInterval(4, 0x666666);
			arena.addTCS(g);
		}
		
		private function addTargets(arena:VizAlignArena):void {
			t = new Target();
			t.name = "yellow";
			t.x = 450 - 200;
			t.y = 290 - 200;
			t.setSize(60, 100);
			t.setOriginOffset(-200, -200);
			t.setColor(0xCCFF32);
			arena.addTarget(t);
			
			var t:Target = new Target();
			t.name = "green";
			t.x = 230 + 70;
			t.y = 110 + 90;
			t.setSize(60, 60);
			t.setOriginOffset(70, 90);
			t.setColor(0x009966);
			arena.addTarget(t);
			
			t = new Target();
			t.name = "cyan";
			t.x = 340;
			t.y = 250 + 50;
			t.setSize(60, 40);
			t.setOriginOffset(0, 50);
			t.setColor(0x09AABB);
			arena.addTarget(t);
			
			t = new Target();
			t.name = "red";
			t.x = 410;
			t.y = 170;
			t.setSize(40, 40);
			t.setOriginOffset(0, 0);
			t.setColor(0xB41D00);
			arena.addTarget(t);
			
			t = new Target();
			t.name = "blue";
			t.x = 300 + 20;
			t.y = 210 - 20;
			t.setSize(20, 40);
			t.setOriginOffset(20, -20);
			t.setColor(0x3064FF);
			arena.addTarget(t);
		}
		
		private function addTargetInfo(arena:VizAlignArena):void {
			var targetInfo:TargetInfo = new TargetInfo();
			targetInfo.x = 580;
			targetInfo.y = 230;
			
			for (var i:int = 0; i < arena.targets.length; i++) {
				var target:Target = arena.targets[i];
				target.addEventListener(MouseEvent.CLICK, targetInfo.onTargetSelected);
				target.addEventListener(MouseEvent.DOUBLE_CLICK, targetInfo.onTargetSelected);
			}
			
			arena.addTCS(targetInfo);
		}
	}
}