/**
 *
 *
 *
 *
*/
package ktu.utils {

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class BrowserStatusBar {

		private static var regObjects:Dictionary = new Dictionary ();
		private static var length:int = 0;
		
		private static const JSCall:String = "window.status";
		
		public static function registerEvent (obj:*, type:String, url:String):void {
			obj.addEventListener (type, onEvent);								// add an event listener to the obj
			var objVals:Array = (regObjects[obj]) ? regObjects[obj] : [];		// get reference to the array of events stored for this obj
			objVals[objVals.length] = { type:type, url:url };					// push in the type and url for this obj
			regObjects[obj] = objVals;											// resave the new array
			checkLength (1);													// one more event stored
		}
		public static function unregisterEvent (obj:*, type:String):void {
			var objVals:Array = regObjects[obj];								// get reference to the array of events stored for this obj
			if (!objVals || objVals.length == 0) return;						// if undefined or length of 0, return, this was an accidental call
			obj.removeEventListener (type, onEvent);							// remove the event listener for this object 
			for (var i:int = 0; i < objVals.length; i++) {						// loop through all events stored for this obj
				if (objVals[i].type == type) {									// 		if current event matches the one passed in
					objVals.splice(i, 1);										//			remove if from the array
					break;														// 			we found it, so get out of here
				}																//		end if
			}																	// end loop
			if (objVals.length == 0) delete regObjects[obj];					// if after removing, length is 0, delete ref in dic
			checkLength ( -1);													// subtract one from length
		}
		private static function onEvent (e:Event):void {
			var values:Array = regObjects[e.target];							// get reference to the array of events stored for this obj
			for (var i:int = 0; i < values.length; i++) {						// loop through each event stored for this obj
				if (values[i].type == e.type) break;							// 		if current event matches the event for this obj STOP;
			}																	// end loop
			ExternalInterface.call (JSCall, values[i].url);						// update status bar to say the apporpriate thing
		}
		
		
		/********************************************************
		 * 	TextField Specifics
		 * @param	txt
		 ********************************************************/
		
		public static function registerTextField (txt:TextField):void {
			if (regObjects[txt]) return;													// if txt already registered no need for it again
			regObjects[txt] = true;															// add txt field to registered objects
			txt.addEventListener (MouseEvent.MOUSE_OVER, txtHandler);						// add event listener for mouseOver
			checkLength (1);																// add one to total obj registered
		}
		public static function unregisterTextField (txt:TextField):void {
			txt.removeEventListener (MouseEvent.MOUSE_OVER, txtHandler);					// remove mouseOver
			txt.removeEventListener (MouseEvent.MOUSE_OUT, txtHandler);						// remove mouseOut
			txt.removeEventListener (Event.ENTER_FRAME, txtHandler);						// remove enterFrame
			delete regObjects[txt];															// remove txt from registered objects
			checkLength ( -1);																// minus one from total obj registered
		}
		
		private static function txtHandler (e:Event):void {
			switch (e.type) {
				case MouseEvent.MOUSE_OVER:
					e.target.addEventListener (MouseEvent.MOUSE_OUT, txtHandler);
					e.target.addEventListener (Event.ENTER_FRAME, txtHandler);
				break;
				case MouseEvent.MOUSE_OUT:
					e.target.removeEventListener (MouseEvent.MOUSE_OUT, txtHandler);
					e.target.removeEventListener (Event.ENTER_FRAME, txtHandler);
					ExternalInterface.call (JSCall, "");
				break;
				case Event.ENTER_FRAME:
					var txt:TextField = TextField (e.target);
					var ind = txt.getCharIndexAtPoint (txt.mouseX, txt.mouseY);
					var url = "";
					if (ind >= 0) {
						var fmt:TextFormat = txt.getTextFormat (ind, ind + 1);
						if (fmt.url) url = fmt.url;
					}
					ExternalInterface.call (JSCall, url);
				break;
			}
		}
		
		private static function checkLength(add:int):void {
			length += add;
			if (length == 0) ExternalInterface.call (JSCall, "");				// if there are no events registered at all, put Status bar back to ""
		}
	}	
}