package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	
	
	public class Paddle extends MovieClip 
	{
		public var _velY1:Number;
		public var _velY2:Number;
		private var _isLeft:Boolean;
		
		public function Paddle(isLeft:Boolean) 
		{
			_isLeft = isLeft;
			_velY1 = 0;
			_velY2 = 0;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function tick():void
		{
			y += _velY1;
			y += _velY2;
			checkBoundaries();
		}
		
		public function checkBoundaries():void
		{
			if (y <= 0)
			{
				y = 0;
			}
			else if (y + height > stage.stageHeight)
			{
				y = stage.stageHeight - height;
			}
		}
		
		public function onKeyPress(e:KeyboardEvent):void
		{
			if(_isLeft == true)
			{
				if( e.keyCode == Keyboard.W)
				{
					_velY1 = -5;
				}
				else if(e.keyCode == Keyboard.S)
				{
					_velY1 = 5;
				}
			}
			
			if(_isLeft == false)
			{

				if(e.keyCode == Keyboard.UP)
				{
					_velY2 = -5;
				}
				else if (e.keyCode == Keyboard.DOWN)
				{
					_velY2 = 5;
				}
			}
		}
		
		public function onKeyRelease(e:KeyboardEvent):void
		{
			
			if(e.keyCode == Keyboard.W || e.keyCode == Keyboard.S)
			{
				_velY1 = 0;
			}
			if(e.keyCode == Keyboard.UP || e.keyCode == Keyboard.DOWN)
			{
				_velY2 = 0;
			}
		}
		
		public function onAddedToStage(e:Event):void
		{
			if(_isLeft ==  true)
			{
				x = 20;
				y = (stage.stageHeight/2) - (height/2);
				gotoAndStop(1);
				
			}
			if(_isLeft == false)
			{
				x= stage.stageWidth - 35;
				y = (stage.stageHeight/2) - (height/2);
				gotoAndStop(2);
			}
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);

		}
	}
	
}
