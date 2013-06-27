package proxy.login
{
	import com.xgame.common.commands.CommandList;
	import com.xgame.common.commands.receiving.Receive_Info_QuickStart;
	import com.xgame.common.commands.receiving.Receive_Info_RequestAccountRole;
	import com.xgame.common.commands.sending.Send_Info_RequestAccountRole;
	import com.xgame.core.center.CommandCenter;
	
	import mediators.loader.LoadingIconMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class RequestRoleProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "RequestRoleProxy";
		
		public static const REQUEST_ACCOUNT_ROLE: uint = 0x0040;
		
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
//			
			setData(protocol);
//			sendNotification(LoadingIconMediator.LOADING_HIDE_NOTE);
//			sendNotification(ShowServerMediatorCommand.CREATE_NOTE);
		}
	}
}