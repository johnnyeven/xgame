package controllers
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.common.behavior.Behavior;
	import com.xgame.common.behavior.MainPlayerBehavior;
	import com.xgame.common.display.ActionDisplay;
	import com.xgame.common.display.BitmapDisplay;
	import com.xgame.common.display.BitmapMovieDispaly;
	import com.xgame.common.display.CharacterDisplay;
	import com.xgame.common.display.ResourceData;
	import com.xgame.common.display.renders.Render;
	import com.xgame.common.pool.ResourcePool;
	import com.xgame.configuration.GlobalContextConfig;
	import com.xgame.core.Camera;
	import com.xgame.core.center.ResourceCenter;
	import com.xgame.core.scene.Scene;
	import com.xgame.enum.Action;
	import com.xgame.enum.Direction;
	import com.xgame.events.scene.SceneEvent;
	import com.xgame.ns.NSCamera;
	import com.xgame.utils.Reflection;
	import com.xgame.utils.debug.Stats;
	import com.xgame.utils.manager.TimerManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getTimer;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ApplicationCommand extends SimpleCommand
	{
		private var _main: main;
		private var _scene: Scene;
		private var _mouseX: Number;
		private var _mouseY: Number;
		private var _gameLayer: Sprite;
		private var _player: ActionDisplay;
		
		public function ApplicationCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _lc: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			LoaderMax.activate([ImageLoader, SWFLoader]);
			LoaderMax.defaultContext = _lc;
			
			var _loader: XMLLoader = new XMLLoader("config/resources.xml", {name:"resourcesConfig", onComplete:completeHandler});
			_loader.load();
			_main = notification.getBody() as main;
			
			_gameLayer = new Sprite();
			_main.stage.addChild(_gameLayer);
			
			var _debugLayer: Sprite = new Sprite();
			var _debugStats: Stats = new Stats();
			_debugLayer.addChild(_debugStats);
			_main.stage.addChild(_debugLayer);
		}
		
		private function completeHandler(evt: LoaderEvent): void
		{
			ResourceCenter.instance.load("loginResources", null, onLoadComplete);
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			_scene = Scene.initialization(_main.stage, _gameLayer);
			Camera.initialization(_scene);
			_scene.addEventListener(SceneEvent.SCENE_READY, onSceneReady);
			_scene.initializeMap(1003);
		}
		
		private function onSceneReady(evt: SceneEvent): void
		{
			_scene.removeEventListener(SceneEvent.SCENE_READY, onSceneReady);
			TimerManager.instance.add(33, render);
			createPlayer();
			createMonster();
		}
		
		private function render(): void
		{
			_scene.update();
		}
		
		private function createMonster(): void
		{
			var _monster: ActionDisplay = new ActionDisplay(new Behavior());
			_monster.speed = 7;
			_monster.positionX = 800;
			_monster.positionY = 600;
			_monster.graphic = ResourcePool.instance.getResourceData("assets.character.char5");
			var _render: Render = new Render();
			_monster.render = _render;
			_scene.addObject(_monster);
			_monster.followDistance = 50;
			_monster.follow = _player;
		}
		
		private function createPlayer(): void
		{
			_player = new CharacterDisplay(new MainPlayerBehavior());
			_player.speed = 7;
			_player.positionX = 700;
			_player.positionY = 700;
			_player.graphic = ResourcePool.instance.getResourceData("assets.character.char4");
			var _render: Render = new Render();
			_player.render = _render;
			_scene.addObject(_player);
			
			Camera.instance.focus = _player;
		}
	}
}