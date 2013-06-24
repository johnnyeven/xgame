package
{
	import com.xgame.core.GameManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Security;
	
	[SWF(width="1028", height="600", backgroundColor="0xffffff",frameRate="30")]
	public class main extends GameManager
	{
		public function main()
		{
			Security.allowDomain("*");
		}

		public function init(evt: Event = null): void
		{
			if(evt)
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			ApplicationFacade.getInstance().start(this);
		}
	}
}