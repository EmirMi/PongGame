package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
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
		var _pause:Boolean = false;
		var _info:TextField;
		var _countdown:TextField;
		var _gameBackground:MovieClip = null;
		public static const GAME_OVER: String = "gameOver";
		private var _hitSound:SimpleSound = new SimpleSound("ballhit.mp3");
		private var _cheer:SimpleSound = new SimpleSound("swish.mp3");
					
		public function Pong()
		{
			_gameBackground = new GameBackground();
			_info = _gameBackground.info;	
			_scoreBoard = _gameBackground.scoreboard;
			_countdown = _gameBackground.countdown;
			_hits1 = _gameBackground.hits1;
			_hits2 = _gameBackground.hits2;
			_bounces1 = 0;
			_bounces2 = 0;
			_timeCounter = 60;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage (e:Event):void
		{
			addChild(_gameBackground);
			_ball = new Ball();
			addChild(_ball);
			_paddle1 = new Paddle(true);
			addChild(_paddle1);
			_paddle2 = new Paddle(false);
			addChild(_paddle2);
			_myTimer = new Timer(1000, _timeCounter);
			_myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			_hits1.text = "Player 1";
			_hits2.text = "Player 2";
			_scoreBoard.text = "Welcome to PONG!";
			_info.text = "Press Space to Serve\nPress 'R' for restart";
			stage.addEventListener(KeyboardEvent.KEY_DOWN, serve);
		}
		
		public function tick():void
		{
			if (_pause == false)
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
						_hitSound.playMusic();
					}
					else if(_ball._velX < 0)
					{
						_bounces1++;
						_hits1.text= "Hits: " + String(_bounces1);
						_hitSound.playMusic();
						
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
				
		}

		public function score():void
		{
			if(_ball.x == 0)
			{
				_bounces2 += 10;
				_hits2.text= "Hits: " + String(_bounces2);
				_cheer.playMusic();
				_ball.reset();
				
			}
			if(_ball.x + _ball.width == stage.stageWidth)
			{
				_bounces1 += 10;
			    _hits1.text= "Hits: " + String(_bounces1);
				_cheer.playMusic();
				_ball.reset();
			}
		}
		
		public function serve(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE && _ball._velX == 0 && _pause == false)
			{

				_myTimer.start();
				_ball.visible = true;
				_ball.serve();
				_info.text = "";
				_scoreBoard.text = "";
				_countdown.text = "Time left: " + String(_timeCounter); 
				_hits1.text= "Hits: " + String(_bounces1);
				_hits2.text= "Hits: " + String(_bounces2);
			}
			else if (e.keyCode == Keyboard.R)
			{
				_bounces1 = 0;
				_bounces2 = 0;
				_timeCounter = 60;
				_myTimer.reset();
				_scoreBoard.text = "Welcome to PONG!";
				_countdown.text = "";
				_info.text = "Press Space to Serve\nPress 'R' for restart";
				_hits1.text= "Player 1";
				_hits2.text= "Player 2";
				_ball.reset();
			
			}
			else if (e.keyCode == Keyboard.P)
			{
				if (_pause == true)
				{
					_pause = false;
					_myTimer.start();
					_countdown.text = "Time left: " + String(_timeCounter); 
				}
				else
				{
					_pause = true;
					if (_timeCounter > 0)
					{
						_myTimer.stop();
					}
					_countdown.text = "Paused";
					
				}
			}

		}
		
        public function timerHandler(event:TimerEvent):void 
		{
			_countdown.text = "Time left: " + String(_timeCounter); 
			_timeCounter--;
			
			if(_timeCounter == 0 || _timeCounter < 0)
			{
				_ball.visible = false;
				_myTimer.stop();
				_myTimer.removeEventListener(TimerEvent.TIMER, timerHandler);	
				removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, serve);
				dispatchEvent(new Event(Pong.GAME_OVER));
			}
        }
		
		public function isColliding(a:Ball, b:Paddle):Boolean
		{
			var colliding:Boolean = a.hitTestObject(b);
			return colliding;
		}
	}
}