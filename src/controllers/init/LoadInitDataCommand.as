package controllers.init
{
	import com.xgame.common.commands.receiving.Receive_Base_VerifyMap;
	import com.xgame.core.Camera;
	import com.xgame.core.GameManager;
	import com.xgame.core.scene.Scene;
	import com.xgame.events.scene.SceneEvent;
	import com.xgame.utils.debug.Debug;
	import com.xgame.utils.debug.Stats;
	import com.xgame.utils.manager.LanguageManager;
	
	import flash.display.Sprite;
	
	import mediators.loader.LoadingIconMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.MapProxy;
	import proxy.SceneProxy;
	
	public class LoadInitDataCommand extends SimpleCommand
	{
		public static const LOAD_INIT_DATA_NOTE: String = "LoadInitDataCommand.LoadInitDataNote";
		public static const LOAD_SCENE: String = "LoadInitDataCommand.LoadScene";
		
		public function LoadInitDataCommand()
		{
			super();
			facade.registerCommand(LoadCharacterResourceCommand.LOAD_RESOURCE, LoadCharacterResourceCommand);
			facade.registerCommand(LoadSkillResourcesCommand.LOAD_RESOURCES, LoadSkillResourcesCommand);
			facade.registerCommand(LoadSkillResourcesCommand.LOAD_LOGIC, LoadSkillResourcesCommand);
			facade.registerCommand(LoadHotkeyConfigCommand.LOAD_HOTKEY_CONFIG_NOTE, LoadHotkeyConfigCommand);
			facade.registerCommand(StartGameCommand.START_GAME_NOTE, StartGameCommand);
		}
		
		override public function execute(notification:INotification):void
		{
			switch(notification.getName())
			{
				case LOAD_INIT_DATA_NOTE:
					facade.removeCommand(LOAD_INIT_DATA_NOTE);
					facade.sendNotification(LoadCharacterResourceCommand.LOAD_RESOURCE);
					break;
				case LOAD_SCENE:
					facade.removeCommand(LOAD_SCENE);
					facade.sendNotification(LoadingIconMediator.LOADING_SET_TITLE_NOTE, LanguageManager.getInstance().lang("load_scene"));
					loadScene();
					loadDebug();
					break;
			}
		}
		
		private function loadDebug(): void
		{
			var _debugLayer: Sprite = new Sprite();
			var _debugStats: Stats = new Stats();
			_debugLayer.addChild(_debugStats);
			GameManager.container.stage.addChild(_debugLayer);
		}
		
		private function loadScene(): void
		{
			var _protocol: Receive_Base_VerifyMap;
			var _proxy: MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			if(_proxy != null)
			{
				_protocol = _proxy.getData() as Receive_Base_VerifyMap;
			}
			if(_protocol == null)
			{
				Debug.error(this, "没有获取到地图数据");
				return;
			}
			
			var _gameLayer: Sprite = new Sprite();
			GameManager.container.stage.addChild(_gameLayer);
			var _scene: Scene = Scene.initialization(GameManager.container, _gameLayer);
			Camera.initialization(_scene);
			_scene.addEventListener(SceneEvent.SCENE_READY, onSceneReady);
			_scene.initializeMap(_protocol.mapId);
		}
		
		private function onSceneReady(evt: SceneEvent): void
		{
			var _scene: Scene = evt.currentTarget as Scene;
			_scene.removeEventListener(SceneEvent.SCENE_READY, onSceneReady);
			
			facade.sendNotification(StartGameCommand.START_GAME_NOTE, _scene);
			
			var _proxy: SceneProxy = facade.retrieveProxy(SceneProxy.NAME) as SceneProxy;
			if(_proxy != null)
			{
				_proxy.updatePlayerStatus();
			}
		}
	}
}