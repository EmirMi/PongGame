package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.text.TextField;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class GameOverState extends State
	{
		private var _screen:MovieClip = null;
		private var _gameover:TextField;
		private var _credits:TextField;
		private var _bounces1: Number;
		private var _bounces2: Number;
		private var _gameoverMusic:SimpleSound = new SimpleSound("gameover.mp3");
		
		public function GameOverState(fsm:FSM, bounces1:Number, bounces2:Number)
		{
			_bounces1 = bounces1;
			_bounces2 = bounces2;
			super(fsm);
		}
		
		override public function enter():void
		{
			_screen = new GameOver();	
			_gameover = _screen.gameoverInfo;
			_credits = _screen.creditsInfo;
			_fsm.addChild(_screen);
			_gameoverMusic.playMusic();
			_credits.text = "All sounds are free for non-comercial use.\nwww.orangefreesounds.com";
			if (_bounces1 > _bounces2)
				{
					_gameover.text = "Player 1 is the winner!\nPress 'R' to play again!\nPress 'M' for main menu!\nPress 'I' for info screen!";
				}
				else if (_bounces1 == _bounces2)
				{
					_gameover.text = "It's a draw!\nPress 'R' to play again!\nPress 'M' for main menu!\nPress 'I' for info screen!";
				}
				else
				{
					_gameover.text = "Game Rules\n\nPlayer 2 is the winner!\nPress 'R' to play again!\nPress 'M' for main menu!\nPress 'I' for info screen!";
				}
			_fsm.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}

		private function onKeyPress(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.M)
			{
				_fsm.setState(new MenuState(_fsm));
				_gameoverMusic.stop();
			}
			else if(e.keyCode == Keyboard.I)
			{
				_fsm.setState(new InfoState(_fsm));
				_gameoverMusic.stop();
			}
			else if(e.keyCode == Keyboard.R) //game
			{
				_fsm.setState(new PlayState(_fsm));
				_gameoverMusic.stop();
			}
		}
		
		override public function update():void
		{
			
		}
		
		override public function exit():void
		{
			_fsm.removeChild(_screen);
			_screen = null;
			_fsm.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}
	}
	
}
