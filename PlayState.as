package {

	import org.flixel.*;
	public class PlayState extends FlxState {
		public var player:Player;
		public var bullets:FlxGroup;
		public var baddies:FlxGroup;
		public var blocks:FlxGroup;

		override public function create():void {
			//whee define the variables i and sprite for happiness
			var i:uint;
			var sprite:FlxSprite;

			//get some color in here
			FlxG.bgColor = 0xffaaaaff;

			//I'd initialize and add her player to the layer if you know what i mean
			player = new Player();
			add(player);
			FlxG.camera.follow(player);
			var playerPoint:FlxPoint = new FlxPoint(player.x, player.y);
			//FlxG.camera.setBounds(0,0,FlxG.width,FlxG.height,true);
			//FlxG.camera.focusOn(playerPoint);

			//BULLETS
			var numBullets:uint = 200;
			bullets = new FlxGroup(numBullets);
			for(i = 0; i < numBullets; i++) {
				sprite = new FlxSprite(-100,-100); //makes a bullet far away from prying eyes
				sprite.makeGraphic(4,4,0xffffffff);

				sprite.exists = false; 
				bullets.add(sprite); //stick that sucker in the array
			}
			add(bullets);


			//MAP BUILDER
			var block:FlxSprite;
			blocks = new FlxGroup();
			for(i = 0; i < 300; i++) {
				block = new FlxSprite(FlxU.floor(FlxG.random()*40)*20,FlxU.floor(FlxG.random()*30)*20).makeGraphic(20,20,0xff233e58)
				block.immovable = true;
				block.moves = false;
				block.active = false;
				blocks.add(block);
			}
			add(blocks);
			//FlxG.worldBounds = new FlxRect(0,0,640,480)			

			//BADDIE SPAWNER (needs work)
			baddies = new FlxGroup();
			add(baddies);
			spawnBaddie();
			spawnBaddie();
			spawnBaddie();
			spawnBaddie();
			spawnBaddie();


		}

		protected function groupCollision(Object1:FlxObject, Object2:FlxObject):void {
			Object1.kill();
			Object2.kill();
		}

		protected function soloCollision(Object1:FlxObject, Object2:FlxObject):void {
			Object2.kill();
		}

		override public function update():void {
			super.update();
			FlxG.overlap(bullets, baddies, groupCollision);
			FlxG.overlap(blocks, bullets, soloCollision);
			FlxG.overlap(baddies, player, soloCollision);
			FlxG.collide(baddies);
			FlxG.collide(baddies, blocks);
			FlxG.collide(player, blocks);
		}

		private function spawnBaddie():void {
			var baddie:Baddie = baddies.recycle(Baddie) as Baddie;
			baddie.create();
		}
	}
}