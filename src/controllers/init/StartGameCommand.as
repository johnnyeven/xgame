package controllers.init
{
	import com.xgame.common.commands.receiving.ReceivingBase;
	import com.xgame.common.display.MainPlayerDisplay;
	import com.xgame.common.display.renders.Render;
	import com.xgame.common.pool.ResourcePool;
	import com.xgame.core.Camera;
	import com.xgame.core.center.HotkeyCenter;
	import com.xgame.core.scene.Scene;
	import com.xgame.utils.manager.TimerManager;
	
	import mediators.loader.LoadingIconMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.login.RequestRoleProxy;
	
	public class StartGameCommand extends SimpleCommand
	{
		public static const START_GAME_NOTE: String = "StartGameCommand.StartGameNote";
		private var scene: Scene;
		
		public function StartGameCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			scene = notification.getBody() as Scene;
			if(scene != null)
			{
				facade.sendNotification(LoadingIconMediator.LOADING_HIDE_NOTE);
				createPlayer();
				TimerManager.instance.add(33, render);
				HotkeyCenter.GlobalEnabled = true;
			}
		}
		
		private function render(): void
		{
			scene.update();
		}
		
		private function createPlayer(): void
		{
			var _proxy: RequestRoleProxy = facade.retrieveProxy(RequestRoleProxy.NAME) as RequestRoleProxy;
			if(_proxy != null)
			{
				var _protocol: * = _proxy.getData();
				if(_protocol != null)
				{
					var _player: MainPlayerDisplay = new MainPlayerDisplay();
					_player.speed = 7;
					_player.positionX = _protocol.x;
					_player.positionY = _protocol.y;
					_player.graphic = ResourcePool.instance.getResourceData("assets.character.char4");
					var _render: Render = new Render();
					_player.render = _render;
					scene.addObject(_player);
					scene.player = _player;
					
					Camera.instance.focus = _player;
				}
			}
		}
	}
}