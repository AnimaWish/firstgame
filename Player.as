package {
	import org.flixel.*;
	public class Player extends FlxSprite {

		public function Player() {
			super(100, 100);

			makeGraphic(10,10,0xffaa1111);
		}

		public function fireBullet(xDirection:int,yDirection:int):void {
			var bullet:FlxSprite = (FlxG.state as PlayState).bullets.recycle() as FlxSprite;
			bullet.reset(x + (width - bullet.width)/2, y + (height - bullet.height)/2);
			bullet.velocity.x = xDirection*200;
			bullet.velocity.y = yDirection*200;

			if( Math.pow(bullet.velocity.x,2) + Math.pow(bullet.velocity.y,2) >= 80000){ //slows the bullets down if they're diagonal (pythagoras)
				bullet.velocity.x = xDirection*200/Math.sqrt(2);
				bullet.velocity.y = yDirection*200/Math.sqrt(2);
			}
		}

		public var timer:uint;
		public function fireBulletDelay(xDirection:int,yDirection:int):void { //meters firing rate
			
			if(xDirection != 0 || yDirection != 0) { //if a key is being pressed
				if(timer == 0) //fire a bullet every 8 (or 9, computer stuff) ticks
					fireBullet(xDirection,yDirection);
				timer++;
			}

			if(timer == 8)
				timer = 0;

		}

		override public function update():void {
			acceleration.x = 0;
			acceleration.y = 0;
			maxVelocity.x = 150;
			maxVelocity.y = 150;
			if( Math.pow(velocity.x,2) + Math.pow(velocity.y,2) >= 10000){ //same as in fireBullet but for the player
				maxVelocity.x = 100/Math.sqrt(2);
				maxVelocity.y = 100/Math.sqrt(2);
			}
			drag.x = maxVelocity.x*4;
			drag.y = maxVelocity.y*4;

			//MOVEMENT
			if(FlxG.keys.W)
				acceleration.y = -maxVelocity.y*4;
			if(FlxG.keys.A)
				acceleration.x = -maxVelocity.x*4;
			if(FlxG.keys.S)
				acceleration.y = maxVelocity.y*4;
			if(FlxG.keys.D)
				acceleration.x = maxVelocity.x*4;


			//FIRING
			var directionArray:Array = new Array(0, 0);
			if(FlxG.keys.UP)
				directionArray[1] = -1;
			if(FlxG.keys.LEFT)
				directionArray[0] = -1;
			if(FlxG.keys.DOWN)
				directionArray[1] = 1;
			if(FlxG.keys.RIGHT)
				directionArray[0] = 1;
			fireBulletDelay(directionArray[0], directionArray[1]);

		}
	}
}