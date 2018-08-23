package
{
	import fairygui.GComponent;
	
	import laya.events.EventDispatcher;
	import laya.maths.Point;
	import laya.utils.Tween;

	public class JoystickModule extends laya.events.EventDispatcher
	{
		private var _InitX: Number;
		private var _InitY: Number;
		private var _startStageX: Number;
		private var _startStageY: Number;
		private var _lastStageX: Number;
		private var _lastStageY: Number;
		private var _button: fairygui.GButton;
		private var _touchArea: fairygui.GObject;
		private var _thumb: fairygui.GObject;
		private var _center: fairygui.GObject;
		private var touchId: Number;
		private var _tweener: Tween;
		private var _curPos: Point;
		
		public static var JoystickMoving: String = "JoystickMoving";
		public static var JoystickUp: String = "JoystickUp";
		
		public var radius: Number;
		
	
		
		public function JoystickModule(mainView :fairygui.GComponent):void {
			//super();
			
			this._button = mainView.getChild("joystick").asButton;
			this._button.changeStateOnClick = false;
			this._thumb = this._button.getChild("thumb");
			this._touchArea = mainView.getChild("joystick_touch");
			this._center = mainView.getChild("joystick_center");
			
			this._InitX = this._center.x + this._center.width / 2;
			this._InitY = this._center.y + this._center.height / 2;
			this.touchId = -1;
			this.radius = 150;
			
			this._curPos = new laya.maths.Point();
			
			this._touchArea.on(laya.events.Event.MOUSE_DOWN,this, this.onTouchDown);
		}
		
		public function Trigger(evt: laya.events.Event): void {
			this.onTouchDown(evt);
		}
		
		private function onTouchDown(evt: laya.events.Event):void {
			if(this.touchId == -1) {//First touch
				this.touchId = evt.touchId;
				
				if(this._tweener != null) {
					this._tweener.clear();
					this._tweener = null;
				}
				
				fairygui.GRoot.inst.globalToLocal(Laya.stage.mouseX, Laya.stage.mouseY,this._curPos);
				var bx: Number = this._curPos.x;
				var by: Number = this._curPos.y;
				this._button.selected = true;
				
				if(bx < 0)
					bx = 0;
				else if(bx > this._touchArea.width)
					bx = this._touchArea.width;
				
				if(by > fairygui.GRoot.inst.height)
					by = fairygui.GRoot.inst.height;
				else if(by < this._touchArea.y)
					by = this._touchArea.y;
				
				this._lastStageX = bx;
				this._lastStageY = by;
				this._startStageX = bx;
				this._startStageY = by;
				
				this._center.visible = true;
				this._center.x = bx - this._center.width / 2;
				this._center.y = by - this._center.height / 2;
				this._button.x = bx - this._button.width / 2;
				this._button.y = by - this._button.height / 2;
				
				var deltaX: Number = bx - this._InitX;
				var deltaY: Number = by - this._InitY;
				var degrees: Number = Math.atan2(deltaY,deltaX) * 180 / Math.PI;
				this._thumb.rotation = degrees + 90;
				
				Laya.stage.on(laya.events.Event.MOUSE_MOVE,this,this.OnTouchMove);
				Laya.stage.on(laya.events.Event.MOUSE_UP,this,this.OnTouchUp);
			}
		}
		
		private function OnTouchUp(evt:laya.events.Event): void {
			if(this.touchId != -1 && evt.touchId == this.touchId) {
				this.touchId = -1;
				this._thumb.rotation = this._thumb.rotation + 180;
				this._center.visible = false;
				this._tweener = laya.utils.Tween.to(this._button, { x: this._InitX - this._button.width / 2,y: this._InitY - this._button.height / 2 },
					300, laya.utils.Ease.circOut, laya.utils.Handler.create(this, function(): void {
						this._tweener = null;
						this._button.selected = false;
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
		
		private function OnTouchMove(evt: laya.events.Event): void {
			if(this.touchId != -1 && evt.touchId == this.touchId) {
				var bx: Number = Laya.stage.mouseX;
				var by: Number = Laya.stage.mouseY;
				var moveX: Number = bx - this._lastStageX;
				var moveY: Number = by - this._lastStageY;
				this._lastStageX = bx;
				this._lastStageY = by;
				var buttonX: Number = this._button.x + moveX;
				var buttonY: Number = this._button.y + moveY;
				
				var offsetX: Number = buttonX + this._button.width / 2 - this._startStageX;
				var offsetY: Number = buttonY + this._button.height / 2 - this._startStageY;
				
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
				if(buttonY > fairygui.GRoot.inst.height)
					buttonY = fairygui.GRoot.inst.height;
				
				this._button.x = buttonX - this._button.width / 2;
				this._button.y = buttonY - this._button.height / 2;
				
				this.event(JoystickModule.JoystickMoving,degree);
			}
		}
	}
}