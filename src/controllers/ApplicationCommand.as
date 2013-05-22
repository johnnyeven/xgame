package controllers
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.common.behavior.Behavior;
	import com.xgame.common.display.BitmapDisplay;
	import com.xgame.common.display.BitmapMovieDispaly;
	import com.xgame.common.display.ResourceData;
	import com.xgame.common.display.renders.Render;
	import com.xgame.common.pool.ResourcePool;
	import com.xgame.configuration.GlobalContextConfig;
	import com.xgame.core.Camera;
	import com.xgame.core.center.ResourceCenter;
	import com.xgame.core.scene.Scene;
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
			_scene = new Scene(_main.stage, _gameLayer);
			Camera.initialization(_scene);
			_scene.initializeMap(1003);
			TimerManager.instance.add(33, render);
			
			_main.stage.addEventListener(MouseEvent.CLICK, createPlayer);
//			_main.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
//			_main.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
//		private function onMouseDown(evt: MouseEvent): void
//		{
//			if(!_main.stage.hasEventListener(MouseEvent.MOUSE_MOVE))
//			{
//				_main.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
//			}
//			_mouseX = evt.stageX;
//			_mouseY = evt.stageY;
//		}
//		
//		private function onMouseMove(evt: MouseEvent): void
//		{
//			var offsetX: Number = _mouseX - evt.stageX;
//			var offsetY: Number = _mouseY - evt.stageY;
//			Camera.instance.x += offsetX;
//			Camera.instance.y += offsetY;
//			_mouseX = evt.stageX;
//			_mouseY = evt.stageY;
//		}
//		
//		private function onMouseUp(evt: MouseEvent): void
//		{
//			if(_main.stage.hasEventListener(MouseEvent.MOUSE_MOVE))
//			{
//				_main.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
//			}
//		}
		
		private function render(): void
		{
			if(_scene.initialized)
			{
				_scene.update();
			}
		}
		
		private function createPlayer(evt: Event = null): void
		{
			var _display: BitmapMovieDispaly = new BitmapMovieDispaly(new Behavior());
			
			_display.positionX = 20;
			_display.positionY = 20;
			_display.isLoop = true;
			var _index: uint = Math.floor((Math.random() * 14)) + 1;
			_display.graphic = ResourcePool.instance.getResourceData("assets.character.char" + _index);
			var _render: Render = new Render();
			_display.render = _render;
			_scene.addObject(_display);
		}
	}
}