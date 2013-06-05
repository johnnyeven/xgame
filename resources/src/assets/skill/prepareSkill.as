package assets.skill {
	
	import flash.display.BitmapData;
	
	
	public class prepareSkill extends BitmapData {
		public var frameLine: uint = 1;
		public var frameTotal: uint = 6;
		public var fps: Number = 30;
		
		
		public function prepareSkill(_width: uint, _height: uint) {
			// constructor code
			super(_width, _height);
		}
	}
	
}
