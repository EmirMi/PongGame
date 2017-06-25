package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.text.engine.TextBaseline;
	
	public class Pong extends MovieClip
	{
		var _ball:Ball;
		var _paddle1:Paddle;
		var _paddle2:Paddle;
		var _scoreBoard:TextField;
		var _hits1:TextField;
		var _hits2:TextField;
		var _bounces1:Number;
		var _bounces2:Number;
		var _timeCounter:Number;
		var _myTimer:Timer; 
		var _info:TextField;
		var _countdown:TextField;
					
		public function Main()
		{
			_info = info;	
			_scoreBoard = scoreboard;
			_countdown = countdown;
			_hits1 = hits1;
			_hits2 = hits2;
			_bounces1 = 0;
			_bounces2 = 0;
			_timeCounter = 60;
			_ball = new Ball();
			addChild(_ball);
			_paddle1 = new Paddle(true);
			addChild(_paddle1);
			_paddle2 = new Paddle(false);
			addChild(_paddle2);
			_myTimer = new Timer(1000, _timeCounter);
			_ball.visible = false;
			addEventListener(Event.ENTER_FRAME, tick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, serve);
			_myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			_scoreBoard.text = "Welcome to PONG!";
			_info.text = "Press Space to Serve\nPlayer 1: W=up S=down\n Player 2: UP=up DOWN=down\n R=Restart game";
		}
		
		public function tick(e:Event):void
		{
			_ball.tick();
			_paddle1.tick();
			_paddle2.tick();
			score();
			
			if(isColliding(_ball, _paddle2) || isColliding(_ball, _paddle1))
				{
					if(_ball._velX > 0)
					{
						_bounces2++;
						_hits2.text= "Hits: " + String(_bounces2);
					}
					else if(_ball._velX < 0)
					{
						_bounces1++;
						_hits1.text= "Hits: " + String(_bounces1);
					}
					if(_ball._velX > 5)
					{
						_bounces2++;
						_hits2.text= "Hits: " + String(_bounces2);
					}
					else if(_ball._velX < -5)
					{
						_bounces1++;
						_hits1.text= "Hits: " + String(_bounces1);
					}
					if(_ball._velX > 7)
					{
						_bounces2++;
						_hits2.text= "Hits: " + String(_bounces2);
					}
					else if(_ball._velX < -7)
					{
						_bounces1++;
						_hits1.text= "Hits: " + String(_bounces1);
					}
					_ball._velX *= -1.1; 		
					if (Math.abs(_ball._velX) >= _paddle1.width)
					{
						_ball._velX *= 0.9;
					}
				}
				
		}

		public function score():void
		{
			if(_ball.x == 0)
			{
				_bounces2 += 10;
				_hits2.text= "Hits: " + String(_bounces2);
				_ball.reset();
			}
			if(_ball.x + _ball.width == stage.stageWidth)
			{
				_bounces1 += 10;
			    _hits1.text= "Hits: " + String(_bounces1);
				_ball.reset();
			}
		}
		
		public function serve(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE && _timeCounter > 0 && _ball._velX == 0)
			{
				_myTimer.start();
				_ball.visible = true;
				_ball.serve();
				_info.text = "";
				_scoreBoard.text = "";
				_countdown.text = "Time: " + String(_timeCounter); 
				_hits1.text= "Hits: " + String(_bounces1);
				_hits2.text= "Hits: " + String(_bounces2);
			}
			if (e.keyCode == Keyboard.R)
			{
				_bounces1 = 0;
				_bounces2 = 0;
				_timeCounter = 60;
				_myTimer.reset();
				_scoreBoard.text = "Welcome to PONG!";
				_countdown.text = "";
				_info.text = "Press Space to Serve\nPlayer 1: W=up S=down\n Player 2: UP=up DOWN=down\n R=Restart game";
				_hits1.text= "Hits: " + String(_bounces1);
				_hits2.text= "Hits: " + String(_bounces2);
				_ball.reset();
			
			}
		}
		
        public function timerHandler(event:TimerEvent):void 
		{
            _countdown.text = "Time: " + String(_timeCounter); 
			_timeCounter--;
			
			if(_timeCounter == 0 || _timeCounter < 0)
			{
				_ball._velX = 0;
				_ball._velY = 0;
				_countdown.text = "";
				_scoreBoard.text = "Game over";
				if (_bounces1 > _bounces2)
				{
					_info.text = "Player 1 is the winner!\nPress 'R' to restart!";
				}
				else if (_bounces1 == _bounces2)
				{
					_info.text = "It's a draw!\nPress 'R' to restart!";
				}
				else
				{
					_info.text = "Player 2 is the winner!\nPress 'R' to restart!";
				}
				_ball.visible = false;
				_myTimer.stop();
			}
        }
			
		public function isColliding(a:Ball, b:Paddle):Boolean
		{
			var colliding:Boolean = a.hitTestObject(b);
			return colliding;
		}
	}
}