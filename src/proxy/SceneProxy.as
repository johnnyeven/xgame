package proxy
{
	import com.xgame.common.commands.CommandList;
	import com.xgame.common.commands.receiving.Receive_Info_RegisterAccountRole;
	import com.xgame.common.commands.receiving.Receive_Info_RequestAccountRole;
	import com.xgame.common.commands.receiving.Receive_Scene_ShowPlayer;
	import com.xgame.common.commands.sending.Send_Base_UpdatePlayerStatus;
	import com.xgame.common.display.PlayerDisplay;
	import com.xgame.common.display.renders.Render;
	import com.xgame.common.pool.ResourcePool;
	import com.xgame.configuration.GlobalContextConfig;
	import com.xgame.configuration.SocketContextConfig;
	import com.xgame.core.center.CommandCenter;
	import com.xgame.core.scene.Scene;
	import com.xgame.utils.debug.Debug;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import proxy.login.RequestRoleProxy;
	
	public class SceneProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "SceneProxy";
		
		public function SceneProxy(data:Object=null)
		{
			super(NAME, data);
			
			CommandCenter.instance.add(SocketContextConfig.SCENE_SHOW_PLAYER, onPlayerShow);
			CommandList.instance.bind(SocketContextConfig.SCENE_SHOW_PLAYER, Receive_Scene_ShowPlayer);
		}
		
		public function updatePlayerStatus(): void
		{
			var _p: RequestRoleProxy = facade.retrieveProxy(RequestRoleProxy.NAME) as RequestRoleProxy;
			if(_p == null)
			{
				Debug.error(this, "RequestRoleProxy为空，无法获取AccountId");
				return;
			}
			var _protocol: Send_Base_UpdatePlayerStatus = new Send_Base_UpdatePlayerStatus();
			_protocol.accountId = _p.accountId;
			CommandCenter.instance.send(_protocol);
		}
		
		private function onPlayerShow(protocol: Receive_Scene_ShowPlayer): void
		{
			var _player: PlayerDisplay = new PlayerDisplay();
			_player.speed = protocol.speed / GlobalContextConfig.FrameRate;
			_player.positionX = protocol.x;
			_player.positionY = protocol.y;
			_player.graphic = ResourcePool.instance.getResourceData("assets.character.char4");
			var _render: Render = new Render();
			_player.render = _render;
			
			Scene.instance.addObject(_player);
		}
	}
}