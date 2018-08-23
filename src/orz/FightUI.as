package orz
{
	import laya.ui.Label;

	/**
	 * @author： WZX
	 * @E-mail：273452355@qq.com
	 * 创建时间：2018-8-22 下午12:05:19
	 * 
	 */
	public class FightUI
	{
		
		private var _joystick:Joystick;
		
		private var angleLabel:Label;
		private var _tank:Tank;
		public function FightUI()
		{
			
			
			angleLabel= new Label();
			angleLabel.x = 100;
			angleLabel.y = 100;
			angleLabel.fontSize = 30;
			angleLabel.color = "#FFFFFF";
			angleLabel.borderColor = "#000000";
			angleLabel.text = "Angle:"
			Laya.stage.addChild(angleLabel);
			
			this._joystick = new Joystick();
			this._joystick.on(JoystickModule.JoystickMoving,this,this.onJoystickMoving);
			this._joystick.on(JoystickModule.JoystickUp,this,this.onJoystickUp);
			
			
			
			
			_tank = new Tank();
			_tank.x = 100;
			_tank.y = 100;
			Laya.stage.addChild(_tank);
			
		}
		
		
		private function onJoystickMoving(degree:Number): void {
			
			_tank.SetRotation( degree + 90);
			_tank.MoveStart();
			angleLabel.text = "Angle:" + degree;
			
		}
		
		private function onJoystickUp(): void {
			_tank.MoveStop();
			//onShootBullet();
			
			angleLabel.text = "Angle:--";
		}
	}
}