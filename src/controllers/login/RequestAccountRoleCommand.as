package controllers.login
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.login.RequestRoleProxy;
	
	public class RequestAccountRoleCommand extends SimpleCommand
	{
		public static const REQUEST_ACCOUNT_ROLE_NOTE: String = "RequestAccountRoleCommand.RequestAccountRoleNote";
		
		public function RequestAccountRoleCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _proxy: RequestRoleProxy;
			if(!facade.hasProxy(RequestRoleProxy.NAME))
			{
				_proxy = new RequestRoleProxy();
				facade.registerProxy(_proxy);
			}
			else
			{
				_proxy = facade.retrieveProxy(RequestRoleProxy.NAME) as RequestRoleProxy;
			}
			_proxy.requestAccountRole();
		}
	}
}