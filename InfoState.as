package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	
	public class InfoState extends State
	{
		private var _info:MovieClip = null;
		private var _infotxt:TextField;
		
		public function InfoState(fsm:FSM)
		{
			super(fsm);
		}

		override public function enter():void
		{
			_info = new InfoBackground();
			_infotxt = _info.infotxt;
			_infotxt.text = "Game length: 60 sec\nPress Space to Serve\nPlayer 1: W=up S=down\n Player 2: UP=up DOWN=down\nPress Esc for main menu";
			_fsm.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			_fsm.addChild(_info);
			_fsm.stage.focus = _fsm.stage;
		}
		
		private function onKeyPress(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.ESCAPE)
			{
				_fsm.setState (new MenuState(_fsm));
			}
		}
		
		override public function update():void
		{
			
		}
		
		override public function exit ():void
		{
			_fsm.removeChild(_info);
			_info = null;
			_fsm.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}
	}	
}


