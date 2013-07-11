package controllers.init
{
	import com.xgame.utils.manager.LanguageManager;
	
	import mediators.loader.LoadingIconMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.HotkeyProxy;
	
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
			facade.sendNotification(LoadingIconMediator.LOADING_SET_TITLE_NOTE, LanguageManager.getInstance().lang("load_hotkey_config"));
			
			var _proxy: HotkeyProxy = new HotkeyProxy();
			facade.registerProxy(_proxy);
			
			_proxy.requestHotkey();
		}
	}
}