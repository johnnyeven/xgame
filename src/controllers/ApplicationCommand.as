package controllers
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.common.display.BitmapDisplay;
	import com.xgame.common.display.BitmapMovieDispaly;
	import com.xgame.common.display.ResourceData;
	import com.xgame.common.display.renders.Render;
	import com.xgame.common.pool.ResourcePool;
	import com.xgame.configuration.GlobalContextConfig;
	import com.xgame.core.center.ResourceCenter;
	import com.xgame.utils.Reflection;
	import com.xgame.utils.debug.Stats;
	import com.xgame.utils.manager.TimerManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getTimer;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ApplicationCommand extends SimpleCommand
	{
		private var _main: main;
		private var _list: Array;
		
		private var world: b2World;
		private var body: b2Body;
		public function ApplicationCommand()
		{
			super();
			_list = new Array();
		}
		
		override public function execute(notification:INotification):void
		{
			_main = notification.getBody() as main;
			
			var _debugLayer: Sprite = new Sprite();
			var _debugStats: Stats = new Stats();
			_debugLayer.addChild(_debugStats);
			_main.stage.addChild(_debugLayer);
			
			var g: b2Vec2 = new b2Vec2(0, 20);
			world = new b2World(g, true);
			
			var debugSprite: Sprite = new Sprite();
			_main.addChild(debugSprite);
			var debugDraw: b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(30);
			debugDraw.SetFillAlpha(.7);
			debugDraw.SetLineThickness(1);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			world.SetDebugDraw(debugDraw);
			
//			LDEasyBox2D.createStaticBody(world, 0, _main.stage.stageHeight - 10, _main.stage.stageWidth, 10);
			LDEasyBox2D.createWrapWall(world, _main.stage);
			
			var physicsData: PhysicsData = new PhysicsData();
			var floor: b2Body = physicsData.createBody("floor", world, b2Body.b2_staticBody, null);
			var position: b2Vec2 = new b2Vec2(5, 10);
			floor.SetPosition(position);
			
			body = LDEasyBox2D.createBox(world, _main.stage.stageWidth / 2 - 15, _main.stage.stageHeight - 30, 30, 30);
			
			_main.addEventListener(Event.ENTER_FRAME, update);
//			_main.stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			_main.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(evt: KeyboardEvent): void
		{
			if(evt.keyCode == 90)
			{
				body.ApplyImpulse(new b2Vec2(0, -70), body.GetWorldCenter());
			}
			if(evt.keyCode == 37)
			{
				body.SetAwake(true);
				body.SetLinearVelocity(new b2Vec2(-2, 0));
			}
			if(evt.keyCode == 39)
			{
				body.SetAwake(true);
				body.SetLinearVelocity(new b2Vec2(2, 0));
			}
		}
		
		private function update(evt: Event): void
		{
			world.Step(1 / 30, 10, 10);
			
			world.ClearForces();
			world.DrawDebugData();
		}
		
//		override public function execute(notification:INotification):void
//		{
//			var _lc: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
//			LoaderMax.activate([ImageLoader, SWFLoader]);
//			LoaderMax.defaultContext = _lc;
//			
//			var _loader: XMLLoader = new XMLLoader("config/resources.xml", {name:"resourcesConfig", onComplete:completeHandler});
//			_loader.load();
//			_main = notification.getBody() as main;
//			
//			var _debugLayer: Sprite = new Sprite();
//			var _debugStats: Stats = new Stats();
//			_debugLayer.addChild(_debugStats);
//			_main.stage.addChild(_debugLayer);
//			_main.stage.addEventListener(MouseEvent.CLICK, createPlayer);
//		}
		
		private function completeHandler(evt: LoaderEvent): void
		{
			ResourceCenter.instance.load("loginResources", false, "", onLoadComplete);
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			for(var i: uint = 0; i < 1; i++)
			{
				createPlayer();
			}
			TimerManager.instance.add(33, render);
		}
		
		private function createPlayer(evt: Event = null): void
		{
			var _display: BitmapMovieDispaly = new BitmapMovieDispaly();
			_main.addChild(_display);
			
			_display.x = Math.random() * 1000;
			_display.y = Math.random() * 600;
			_display.inUse = true;
			_display.isLoop = true;
			var _index: uint = Math.floor((Math.random() * 14)) + 1;
			_display.graphic = ResourcePool.instance.getResourceData("assets.character.char" + _index);
			var _render: Render = new Render();
			_display.render = _render;
			_list.push(_display);
		}
		
		private function render(): void
		{
			var _display: BitmapMovieDispaly;
			for each(_display in _list)
			{
				_display.update();
			}
			GlobalContextConfig.Timer = getTimer();
		}
	}
}