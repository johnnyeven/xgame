package
{
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	
	[SWF(width="1028", height="600", backgroundColor="0xffffff",frameRate="30")]
	public class main extends Sprite
	{
		public function main()
		{
			Security.allowDomain("*");
			init();
		}

		public function init(evt: Event = null): void
		{
			MonsterDebugger.initialize(this);
			MonsterDebugger.trace(this, "hello world");
			if(evt)
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			ApplicationFacade.getInstance().start(this);
		}
	}
}