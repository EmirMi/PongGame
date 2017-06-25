package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class Ball extends MovieClip
	{
		public var _velX:Number;
		public var _velY:Number;
		private var _wallhit:SimpleSound = new SimpleSound("wallhit.mp3");		
		private var _whistle:SimpleSound = new SimpleSound("whistle.mp3");
		public function Ball()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(e:Event):void
		{
			reset();
		}
		
		public function reset():void
		{
			x = (stage.stageWidth/2) - (width/2);
			y = (stage.stageHeight/2) - (height/2);
			_velX = 0;
			_velY = 0;
		}
		
		public function tick():void
		{
			x += _velX;
			y += _velY;
			checkBoundaries();
		}
		
		public function serve():void
		{
			_velX = rndSpeed();
			_velY = rndSpeed();
			_whistle.playMusic();
		}
		
		public function rndSpeed():Number
		{
			var speed = Math.floor(Math.random() * 4);
			if (speed <= 1)
			{
				speed -= 3
			}
			return speed
		}
		
		public function checkBoundaries():void
		{
			if (x <= 0)
			{
				x = 0;
				_velX = _velX * -1;
			}
			else if (x + width > stage.stageWidth)
			{
				x = stage.stageWidth - width;
				_velX = _velX * -1;
			}
			if (y <= 0)
			{
				y = 0;
				_velY = _velY * -1;
				_wallhit.playMusic();
			}
			else if (y + width > stage.stageHeight)
			{
				y = stage.stageHeight - height;
				_velY = _velY * -1;
				_wallhit.playMusic();
			}
		}
	}
	
}
