package {
	import org.flixel.*;
	public class Baddie extends FlxSprite {

		public function Baddie() {
			super();
			elasticity = 1;
		}

		public function randomSign():int {
			if(FlxG.random() > 0.5)
				return -1;
			else
				return 1;
		}

		public function create():Baddie {
			exists = true;
			visible = true;
			active = true;
			solid = true;

			makeGraphic(15,15,0xff1111aa);
			
			x = FlxG.random()*FlxG.width;
			y = FlxG.random()*FlxG.height;
			var randx:int = randomSign();
			var randy:int = randomSign();

			var totalvelocity:int = 200;
			var xysplit:Number = FlxG.random();

			velocity.x = randx*xysplit*totalvelocity;
			velocity.y = randy*(1-xysplit)*totalvelocity;

			return this;
		}
	}
}