package orz
{
	import laya.display.Sprite;

	/**
	 * @author： WZX
	 * @E-mail：273452355@qq.com
	 * 创建时间：2018-8-22 上午11:52:33
	 * 炮弹基类
	 */
	public class Bomb
	{
		/**
		 *炮弹主体 
		 */		
		public var body:Sprite;
		
		/**
		 *炮弹速度 
		 */		
		public var speed:Number;
		/**
		 *炮弹角度 
		 */		
		public var angle:Number
		
		/**
		 *炮弹伤害 
		 */		
		public var damage:Number;
		/**
		 *炮弹伤害半径 
		 */		
		public var damage_radius:Number;
		public function Bomb()
		{
		}
		
		public function Init():void{
			
		}
		/**
		 *子弹飞行 飞行过程中要检查是否命中
		 * 
		 */		
		public function BombFly():void{
			
		}
		/**
		 *检查炮弹 出屏幕.. 
		 * 
		 */		
		public function CheckOutRange():void{
			
		}
		/**
		 *命中 坦克 
		 * 
		 */		
		public function CheckDamageOnTank():void{
			
		}
	}
}