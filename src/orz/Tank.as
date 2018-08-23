package orz
{
	import laya.display.Sprite;
	import laya.ui.Image;

	/**
	 * @author： WZX
	 * @E-mail：273452355@qq.com
	 * 创建时间：2018-8-22 上午11:16:52
	 * 坦克基类
	 */
	public class Tank extends Sprite
	{
		
		/**
		 *坦克主体 
		 */		
		public var tank_body:Sprite;
		/**
		 *坦克炮口 
		 */		
		public var tank_gun:Sprite;
		
		
		/**
		 *移动速度 
		 */		
		public var move_speed:Number;
		
		
		/**
		 *加速 系数 
		 */		
		public var speed_up:Number
		
		
		/**
		 *炮口角度 
		 */		
		public var angle_body:Number;
		/**
		 *炮口角度 
		 */		
		public var angle_gun:Number;
		
		/**
		 *护甲值 
		 */		
		public var shield:Number;
		/**
		 *炮弹发射冷却时间 
		 */		
		public var cooling_time_now:Number;
		
		public var moveing :Boolean;
		public function Tank()
		{
			Init();
			Assembly();
		}
		
		public function Init():void{
			move_speed = 1;
			shield = 100;
		}
		
		
		public function Assembly():void{
			this.tank_body = new Sprite();
			this.tank_gun = new Sprite();
			this.addChild(this.tank_body);
			this.addChild(this.tank_gun);
			
			
			
			
			
			
			var body_img :Image = new Image("res/ui/运力1_2x(tankE1_2x).png");
			body_img.size(60,60);
			body_img.x = body_img.width /-2;
			body_img.y = body_img.height/-2 + 5;
			this.tank_body.addChild(body_img);
			
			
			var gun_img:Image = new Image("res/ui/turretE1_2x.png");
			gun_img.size(38,67);
			gun_img.x = gun_img.width /-2;
			gun_img.y =gun_img.height / -2 - 5;
			this.tank_gun.addChild(gun_img);
			
			
			//this.graphics.drawCircle(0,0,50,"#FFFFFF");
		}
		
		public function SetRotation(_r:Number):void{
			
			this.rotation = _r;
		}
		
		/**
		 *检查坦克的健康状态. 
		 * 
		 */		
		public function CheckHealth():void{
			
			
		}
		/**
		 *炮弹发射CD 
		 * 
		 */		
		public function CheckCoolingTime():void{
			
			
		}
		
		
		
		public function MoveStart():void{
			
			Laya.timer.frameLoop(1, this, this.MoveForward);
			
			
		}
		
		public function MoveStop():void{
			Laya.timer.clear(this,this.MoveForward);
		}
		
		/**
		 *向前移动 
		 * 
		 */		
		public function MoveForward():void{
			
			//if(moveing == true){
				var _angle:Number =Math.PI / 180 * (this.rotation - 90);// _view.rotation + 180;
				//trace("_angle:"+_angle)
				
				var _x:Number = this.x +move_speed * Math.cos(_angle);
				var _y:Number = this.y+ move_speed * Math.sin(_angle);
				
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
				
				this.x = _x;
				this.y =_y;
			//}
		}
		/**
		 *开火 
		 * 
		 */		
		public function Fire():void{
			
		}
	}
}