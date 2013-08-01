package proxy.login
{
	import com.xgame.common.commands.CommandList;
	import com.xgame.common.commands.receiving.Receive_BindSession;
	import com.xgame.common.commands.receiving.Receive_Info_QuickStart;
	import com.xgame.common.commands.sending.Send_Info_BindSession;
	import com.xgame.configuration.SocketContextConfig;
	import com.xgame.core.center.CommandCenter;
	import com.xgame.utils.debug.Debug;
	
	import controllers.login.RequestAccountRoleCommand;
	
	import mediators.loader.LoadingIconMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class SessionProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "SessionProxy";
		
		public function SessionProxy()
		{
			super(NAME);
		}
		
		public function requestBindSession(): void
		{
			var _proxy: LoginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
			if(_proxy != null)
			{
				var _protocol: Receive_Info_QuickStart = _proxy.getData() as Receive_Info_QuickStart;
				if(_protocol != null)
				{
					if(CommandCenter.instance.connected)
					{
						sendNotification(LoadingIconMediator.LOADING_SHOW_NOTE);
						
						CommandList.instance.bind(SocketContextConfig.INFO_BIND_SESSION, Receive_BindSession);
						CommandCenter.instance.add(SocketContextConfig.INFO_BIND_SESSION, onBindSession);
						
						var _send: Send_Info_BindSession = new Send_Info_BindSession();
						_send.accountName = _protocol.accountName;
						CommandCenter.instance.send(_send);
					}
				}
				else
				{
					Debug.error(this, "LoginProxy.getData()为空，用户数据不存在");
				}
			}
			else
			{
				Debug.error(this, "LoginProxy未注册");
			}
		}
		
		private function onBindSession(protocol: Receive_BindSession): void
		{
			if(protocol.result == 1)
			{
				setData(protocol);
				
				if(!facade.hasCommand(RequestAccountRoleCommand.REQUEST_ACCOUNT_ROLE_NOTE))
				{
					facade.registerCommand(RequestAccountRoleCommand.REQUEST_ACCOUNT_ROLE_NOTE, RequestAccountRoleCommand);
				}
				facade.sendNotification(RequestAccountRoleCommand.REQUEST_ACCOUNT_ROLE_NOTE);
			}
		}
	}
}