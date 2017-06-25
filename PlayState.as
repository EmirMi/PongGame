package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class PlayState extends State
	{
		private var _pong:Pong = null;
		
		public function PlayState(fsm:FSM)
		{
			super(fsm);
		}
		
		override public function enter():void
		{
			_pong = new Pong();
			_pong.addEventListener(Pong.GAME_OVER, gameOver);
			_fsm.addChild(_pong);
			_fsm.stage.focus = _fsm.stage;
		}
		
		private function gameOver(e:Event):void
		{
			_fsm.setState(new GameOverState(_fsm, _pong._bounces1, _pong._bounces2));
		}
		
		override public function update():void
		{
			_pong.tick();
		}
		
		override public function exit():void
		{
			_fsm.removeChild(_pong);
			_pong.removeEventListener(Pong.GAME_OVER, gameOver);
			_pong = null;
		}
	}
	
}
