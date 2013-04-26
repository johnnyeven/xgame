package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	
	public class main extends Sprite
	{
		public function main()
		{
			Security.allowDomain("*");
			init();
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