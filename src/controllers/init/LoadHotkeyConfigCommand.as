package controllers.init
{
	import mediators.loader.LoadingIconMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadHotkeyConfigCommand extends SimpleCommand
	{
		public static const LOAD_HOTKEY_CONFIG_NOTE: String = "LoadHotkeyConfigCommand.LoadHotkeyConfigNote";
		
		public function LoadHotkeyConfigCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			facade.removeCommand(LOAD_HOTKEY_CONFIG_NOTE);
			facade.sendNotification(LoadingIconMediator.LOADING_SET_TITLE_NOTE, "加载热键配置信息");
		}
	}
}