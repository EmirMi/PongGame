package  
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class SimpleSound
	{
		private var _soundChannel:SoundChannel;
		private var _soundTransform:SoundTransform;
		public var _sound:Sound = new Sound();

		public function SimpleSound(url:String) 
		{
			_sound.load(new URLRequest(url));
		}
		public function playMusic():void
		{
			_soundChannel = _sound.play();
		}
		public function stop():void
		{
			_soundChannel.stop();
		}

	}	
}

