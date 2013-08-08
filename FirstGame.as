package {
	import org.flixel.*;
	[SWF(width = "640", height = "480", backgroundColor = "#00000000")];
	
	public class FirstGame extends FlxGame {
	
		public function FirstGame() {
			//FlxG.stage.stageWidth(640);
			//FlxG.stage.stageHeight(480);
			super(640, 480, PlayState, 1);
		}

	}

}