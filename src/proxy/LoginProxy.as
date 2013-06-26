package proxy
{
//	import controllers.init.LoadServerListCommand;
//	import controllers.login.ShowServerMediatorCommand;
	
	import com.xgame.common.commands.CommandList;
	import com.xgame.common.commands.receiving.Receive_Info_QuickStart;
	import com.xgame.common.commands.sending.Send_Info_QuickStart;
	import com.xgame.configuration.GlobalContextConfig;
	import com.xgame.core.center.CommandCenter;
	
	import controllers.login.ShowServerMediatorCommand;
	
	import mediators.loader.LoadingIconMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LoginProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "LoginProxy";
		
		public static const QUICK_START: uint = 0x0080;
		
		public function LoginProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function quickStart(): void
		{
			sendNotification(LoadingIconMediator.LOADING_SHOW_NOTE);
			
			CommandList.instance.bind(QUICK_START, Receive_Info_QuickStart);
			CommandCenter.instance.add(QUICK_START, onQuickStart);
			
			var _protocol: Send_Info_QuickStart = new Send_Info_QuickStart();
			_protocol.GameId = GlobalContextConfig.GameId;
			CommandCenter.instance.send(_protocol);
		}
		
		private function onQuickStart(protocol: Receive_Info_QuickStart): void
		{
			facade.registerCommand(ShowServerMediatorCommand.CREATE_NOTE, ShowServerMediatorCommand);
			
			setData(protocol);
			sendNotification(LoadingIconMediator.LOADING_HIDE_NOTE);
			sendNotification(ShowServerMediatorCommand.CREATE_NOTE);
		}
	}
}