package proxy.login
{
	import com.greensock.events.LoaderEvent;
	import com.xgame.common.commands.CommandList;
	import com.xgame.common.commands.receiving.Receive_Info_QuickStart;
	import com.xgame.common.commands.receiving.Receive_Info_RequestAccountRole;
	import com.xgame.common.commands.sending.Send_Info_RequestAccountRole;
	import com.xgame.core.center.CommandCenter;
	
	import controllers.login.ShowCreateRoleMediatorCommand;
	
	import mediators.loader.LoadingIconMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class RequestRoleProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "RequestRoleProxy";
		
		public static const REQUEST_ACCOUNT_ROLE: uint = 0x0040;
		public static const REGISTER_ACCOUNT_ROLE: uint = 0x0050;
		
		public function RequestRoleProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		public function requestAccountRole(): void
		{
			if(CommandCenter.instance.connected)
			{
				var protocol: Receive_Info_QuickStart = facade.retrieveProxy(LoginProxy.NAME).getData() as Receive_Info_QuickStart;
				if(protocol != null || !isNaN(protocol.GUID))
				{
					sendNotification(LoadingIconMediator.LOADING_SHOW_NOTE);
					
					CommandList.instance.bind(REQUEST_ACCOUNT_ROLE, Receive_Info_RequestAccountRole);
					CommandCenter.instance.add(REQUEST_ACCOUNT_ROLE, onRequestAccountRole);
					
					var data: Send_Info_RequestAccountRole = new Send_Info_RequestAccountRole();
					data.GUID = protocol.GUID;
					CommandCenter.instance.send(data);
				}
			}
		}
		
		private function onRequestAccountRole(protocol: Receive_Info_RequestAccountRole): void
		{
//			facade.registerCommand(ShowServerMediatorCommand.CREATE_NOTE, ShowServerMediatorCommand);
			sendNotification(LoadingIconMediator.LOADING_HIDE_NOTE);
			
			setData(protocol);
			if(protocol.accountId.toNumber() == -1)
			{
				facade.registerCommand(ShowCreateRoleMediatorCommand.SHOW_CREATE_ROLE_NOTE, ShowCreateRoleMediatorCommand);
				facade.sendNotification(ShowCreateRoleMediatorCommand.SHOW_CREATE_ROLE_NOTE);
			}
			else
			{
				//加载初始数据
			}
//			sendNotification(LoadingIconMediator.LOADING_HIDE_NOTE);
//			sendNotification(ShowServerMediatorCommand.CREATE_NOTE);
		}
		
		public function registerAccountRole(roleName: String): void
		{
			if(CommandCenter.instance.connected)
			{
				var protocol: Receive_Info_QuickStart = facade.retrieveProxy(LoginProxy.NAME).getData() as Receive_Info_QuickStart;
				if(protocol != null || !isNaN(protocol.GUID))
				{
					sendNotification(LoadingIconMediator.LOADING_SHOW_NOTE);
					
					CommandList.instance.bind(REGISTER_ACCOUNT_ROLE, Receive_Info_RequestAccountRole);
					CommandCenter.instance.add(REGISTER_ACCOUNT_ROLE, onRegisterAccountRole);
					
					var data: Send_Info_RequestAccountRole = new Send_Info_RequestAccountRole();
					data.GUID = protocol.GUID;
					CommandCenter.instance.send(data);
				}
			}
		}
		
		private function onRegisterAccountRole(evt: LoaderEvent): void
		{
			
		}
	}
}