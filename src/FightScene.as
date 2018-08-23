package
{
	import fairygui.GButton;
	import fairygui.GComponent;
	import fairygui.GImage;
	import fairygui.GTextField;
	import fairygui.display.Image;

	public class FightScene
	{
		private var _view:GComponent;
		private var scene_view:GComponent;
		private var tank_canvas:GComponent;
		private var bullet_canvas:GComponent;
		
		
		private var _joystick:JoystickModule;
		public var tank:Tank_Old;
		public function FightScene()
		{
//			Laya.loader.load([
//				{ url: "res/Joystick@atlas0.png", type: Loader.IMAGE },
//				{ url: "res/Joystick.fui", type: Loader.BUFFER }
//			], Handler.create(this, this.onLoaded));
			this.onLoaded();
		}
		
		private function onLoaded():void{
			//Laya.stage.addChild(fairygui.GRoot.inst.displayObject);
			//fairygui.UIPackage.addPackage("res/Joystick");
			
			
			scene_view = fairygui.UIPackage.createObject("UI_Common","FightScene").asCom;
			fairygui.GRoot.inst.addChild(scene_view);
			
			bullet_canvas = scene_view.getChild("BulletCanvas").asCom;
			tank_canvas = scene_view.getChild("TankCanvas").asCom;
			
			tank =new Tank_Old(Laya.stage.width /2,Laya.stage.height/2);
			
			tank_canvas.addChild(tank.sprite);
			
			
			_view = fairygui.UIPackage.createObject("UI_Common","JoyStickMain").asCom;
			fairygui.GRoot.inst.addChild(_view);
			
			
			this._joystick = new JoystickModule(this._view);
			this._joystick.on(JoystickModule.JoystickMoving,this,this.onJoystickMoving);
			this._joystick.on(JoystickModule.JoystickUp,this,this.onJoystickUp);
			
			
			var fireBtn:GButton = scene_view.getChild("btn_fire").asButton;
			fireBtn.onClick(this,this.onShootBullet);
			trace("fireBtn"+fireBtn);
			
			var refreshBtn:GButton = scene_view.getChild("refreshBtn").asButton;
			refreshBtn.onClick(this,this.onRefresh);
			
			
			
		}
		
		private function onJoystickMoving(degree:Number): void {
			tank.SetRotation( degree + 90);
			tank.moveing = true;
		}
		
		private function onJoystickUp(): void {
			tank.moveing = false;
			onShootBullet();
		}
		
		public function onShootBullet():void{
			trace("ShootBullet");
			var bullet:GComponent = tank.ShootBullet();
			bullet_canvas.addChild(bullet);
		}
		
		public function onRefresh():void{
			
			trace("onRefresh");
		
		}
	}
}