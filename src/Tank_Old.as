package
{
	import fairygui.GComponent;
	import fairygui.UIObjectFactory;
	
	import laya.maths.Point;

	public class Tank_Old
	{
		public var sprite:GComponent;
		public var moveing :Boolean;
		public var _moveSpeed :Number= 2;
		
		public var firePoint:GComponent;
		public var bullet:GComponent ;
		public var bulletSpeed:Number = 4;
		public function Tank_Old(_x:Number,_y:Number)
		{
			
			sprite = fairygui.UIPackage.createObject("UI_Common","Tank").asCom;
			
			sprite.x = _x;
			sprite.y = _y;
			moveing = false;
			
			firePoint = sprite.getChild("shoot_position").asCom;
			
			Laya.timer.frameLoop(1, this, this.onLoop);

		}
		public function onLoop(): void {
			
			if(moveing == true){
				var _angle:Number =Math.PI / 180 * (sprite.rotation - 90);// _view.rotation + 180;
				//trace("_angle:"+_angle)
				 
				var _x:Number = sprite.x +_moveSpeed * Math.cos(_angle);
				var _y:Number = sprite.y+ _moveSpeed * Math.sin(_angle);
				
				var c_ling:Number = 45;// Math.sqrt(_view.width * _view.width + _view.height * _view.height) * 0.5;
				
				if(_x< c_ling){
					_x = c_ling;
				}
				if(_x >( Laya.stage.width - c_ling)){
					_x = Laya.stage.width - c_ling;
				}
				
				if(_y<c_ling){
					_y =c_ling;
				}
				if(_y >( Laya.stage.height - c_ling)){
					_y = Laya.stage.height - c_ling;
				}
				
				sprite.x = _x;
				sprite.y =_y;
			}
			if(bullet!=null){
				//trace("bullet move:"+bullet_angle)
//				var bullet_angle:Number =Math.PI / 180 * (bullet.rotation - 90);// _view.rotation + 180;
//				
//				
//				bullet.x = bullet.x +bulletSpeed * Math.cos(bullet_angle);
//				bullet.y =bullet.y+ bulletSpeed * Math.sin(bullet_angle);
				
				
			}
			
		}
		
		
		public function SetRotation(_r:Number):void{
			sprite.rotation = _r;
		}
		
		
		public function ShootBullet():GComponent{
			
			trace("Fair:::");
			bullet = fairygui.UIPackage.createObject("UI_Common","Comp_bullet").asCom;
		
			bullet.rotation = sprite.rotation;
			
			var resultPoint:Point = firePoint.localToGlobal(firePoint.x,firePoint.y);
			
			bullet.x = resultPoint.x
			bullet.y = resultPoint.y;
			return bullet;
			
		}
		
	}
}