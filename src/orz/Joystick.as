package orz
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.events.EventDispatcher;
	import laya.maths.Point;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;

	/**
	 * @author： WZX
	 * @E-mail：273452355@qq.com
	 * 创建时间：2018-8-22 下午12:07:28
	 * 摇杆控制器
	 */
	public class Joystick extends laya.events.EventDispatcher
	{
		
		private var _InitX: Number;
		private var _InitY: Number;
		private var _startStageX: Number;
		private var _startStageY: Number;
		private var _lastStageX: Number;
		private var _lastStageY: Number;
		private var _button:Box;
		private var _touchArea:Sprite;
		private var _thumb:Sprite;
		private var _center:Sprite;
		private var touchId:Number;
		private var _tweener:Tween;
		private var _curPos:Point;
		
		
		
		
		
		public static var JoystickMoving: String = "JoystickMoving";
		public static var JoystickUp: String = "JoystickUp";
		
		public var radius: Number;
		public function Joystick()
		{
			
			
			var content:Box = new Box();
			content.size(Laya.stage.width,Laya.stage.height);
			content.x = 0;
			content.y =0;
			Laya.stage.addChild(content);
			
			
			//摇杆的触发区域
			this._touchArea = new Box();
			var g_width:Number = Laya.stage.width/2.5;
			var g_height:Number = Laya.stage.height/2.5;
			this._touchArea.graphics.drawRect(0,0,g_width,g_height,"#000000");
			this._touchArea.alpha = 0.3;
			this._touchArea.size(g_width,g_height);
			this._touchArea.x =0;
			this._touchArea.y =Laya.stage.height -g_height;
			content.addChild(this._touchArea);
			
			this._touchArea.on( Event.MOUSE_DOWN,this,this.onTouchDown);
			
			
			this._center = new Image("res/ui/游戏杆外_2x(JoystickOut).png");
			this._center.size(162,161);
			this._center.x = (g_width - this._center.width) /2;
			this._center.y = (g_height + this._center.height)/2;
			this._center.visible = false;
			content.addChild(this._center);
			
			
			this._button = new Box();
			this._button.size(120,120);
			this._button.x = g_width /2;//(g_width - this._button.width) /2;
			this._button.y = g_height /2;//(g_height - this._button.height)/2;
			
			this._button.visible = false;
			content.addChild(this._button);
			
			this._thumb = new Sprite();
			this._thumb.x = 0;
			this._thumb.y = 0;
			this._button.addChild(this._thumb);
			
			var _thumb_child :Image = new Image("res/ui/游戏杆内_2x(JoystickInner).png");
			_thumb_child.size(120,120);
			_thumb_child.x = _thumb_child.width /-2;
			_thumb_child.y = _thumb_child.height/-2;
			this._thumb.addChild(_thumb_child);
		
			this._InitX = this._touchArea.x + this._touchArea.width / 2;
			this._InitY = this._touchArea.y + this._touchArea.height / 2;
			this.touchId = -1;
			this.radius = 150;
			
			this._curPos = new laya.maths.Point();
		}
		
		
		private var startPoint:Sprite;
		
		private function onTouchDown(evt: laya.events.Event):void {
			//trace("onTouchDown");
			if(this.touchId==-1){//First touch
				this.touchId = evt.touchId;
				
				if(this._tweener!=null){
					this._tweener.clear();
					this._tweener = null;
				}
			}
		
			this._curPos.setTo(Laya.stage.mouseX,Laya.stage.mouseY);
			var bx:Number = this._curPos.x;
			var by:Number = this._curPos.y;
			
			if(bx < 0)
				bx = 0;
			else if(bx > this._touchArea.width)
				bx = this._touchArea.width;
			if(by > Laya.stage.height)
				by = Laya.stage.height;
			else if(by < 0)
				by = 0;
			
			
			this._lastStageX = bx;
			this._lastStageY = by;
			this._startStageX = bx;
			this._startStageY = by;
			
			this._InitX = bx;
			this._InitY = by;
			
			this._center.visible = true;
			this._center.x = bx - this._center.width / 2;
			this._center.y = by - this._center.height / 2;
			
			this._button.visible = true;
			this._button.x = bx;// - this._button.width;
			this._button.y = by;// - this._button.height ;
			
			var deltaX: Number = bx - this._InitX;
			var deltaY: Number = by - this._InitY;
			var degrees: Number = Math.atan2(deltaY,deltaX) * 180 / Math.PI;
			this._thumb.rotation = degrees + 90;
			
			
			Laya.stage.on(laya.events.Event.MOUSE_MOVE,this,this.OnTouchMove);
			Laya.stage.on(laya.events.Event.MOUSE_UP,this,this.OnTouchUp);
			
		}
		
		private var _movePos:Point;
		
		private function OnTouchMove(evt: laya.events.Event):void {
			//trace("OnTouchMove" +evt.touchId  +"=="+ this.touchId);
		
			if(this.touchId != -1 && evt.touchId == this.touchId) {
				
				if(this._movePos==null){
					this._movePos = new Point(Laya.stage.mouseX,Laya.stage.mouseY);
				}else{
					this._movePos.setTo(Laya.stage.mouseX,Laya.stage.mouseY);
				}
				
				var bx: Number = this._movePos.x;
				var by: Number = this._movePos.y;
				var moveX: Number = bx - this._lastStageX;
				var moveY: Number = by - this._lastStageY;
				this._lastStageX = bx;
				this._lastStageY = by;
				var buttonX: Number = this._button.x + moveX;
				var buttonY: Number = this._button.y + moveY;
				
				var offsetX: Number = buttonX - this._startStageX;//  + this._button.width / 2 ;
				var offsetY: Number = buttonY - this._startStageY;// + this._button.height / 2;
				
				var rad: Number = Math.atan2(offsetY,offsetX);
				var degree: Number = rad * 180 / Math.PI;
				this._thumb.rotation = degree + 90;
				
				var maxX: Number = this.radius * Math.cos(rad);
				var maxY: Number = this.radius * Math.sin(rad);
				if(Math.abs(offsetX) > Math.abs(maxX))
					offsetX = maxX;
				if(Math.abs(offsetY) > Math.abs(maxY))
					offsetY = maxY;
				
				buttonX = this._startStageX + offsetX;
				buttonY = this._startStageY + offsetY;
				if(buttonX < 0)
					buttonX = 0;
				if(buttonY > Laya.stage.height)
					buttonY = Laya.stage.height;
				
				this._button.x = buttonX;// - this._button.width / 2;
				this._button.y = buttonY ;//- this._button.height / 2;
				this.event(JoystickModule.JoystickMoving,degree);
			}
		
		}
		
		private function OnTouchUp(evt: laya.events.Event):void {
			//trace("OnTouchUp");
			if(this.touchId != -1 && evt.touchId == this.touchId) {
				this.touchId = -1;
				this._thumb.rotation = this._thumb.rotation + 180;
				this._center.visible = false;
				this._tweener = laya.utils.Tween.to(this._button, { x: this._InitX ,y: this._InitY },
					300, laya.utils.Ease.circOut, laya.utils.Handler.create(this, function(): void {
						this._tweener = null;
						this._button.visible = false;
						this._thumb.rotation = 0;
						this._center.visible = true;
						this._center.x = this._InitX - this._center.width / 2;
						this._center.y = this._InitY - this._center.height / 2;
					}));
				
				Laya.stage.off(laya.events.Event.MOUSE_MOVE,this,this.OnTouchMove);
				Laya.stage.off(laya.events.Event.MOUSE_UP,this,this.OnTouchUp);
				
				this.event(JoystickModule.JoystickUp);
			}
		}
	}
}