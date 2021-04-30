package ui.sheet 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    public class IPhoneScroll extends Object
    {
        public function IPhoneScroll(arg1:flash.display.DisplayObjectContainer, arg2:flash.display.Stage)
        {
            this._mouseDownPoint = new flash.geom.Point();
            this._lastMouseDownPoint = new flash.geom.Point();
            super();
            this._stage = arg2;
            this._myScrollElement = arg1;
            this._canvasHeight = this._myScrollElement.height;
            this.start();
            this._myScrollElement.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            this._myScrollElement.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.on_mouse_down);
            this._myScrollElement.addEventListener(flash.events.Event.ENTER_FRAME, this.on_enter_frame);
            return;
        }

        internal function on_enter_frame(arg1:flash.events.Event):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (this.started) 
            {
                if (this._mouseDown) 
                {
                    this._velocity = this._velocity * MOUSE_DOWN_DECAY;
                }
                else 
                {
                    this._velocity = this._velocity * DECAY;
                }
                if (!this._mouseDown) 
                {
                    loc1 = this._myScrollElement.height;
                    loc2 = this._myScrollElement.y;
                    loc3 = 0;
                    if (loc2 > 0 || loc1 <= this._canvasHeight) 
                    {
                        loc3 = (-loc2) * BOUNCING_SPRINGESS;
                    }
                    else if (loc2 + loc1 < this._canvasHeight) 
                    {
                        loc3 = (this._canvasHeight - loc1 - loc2) * BOUNCING_SPRINGESS;
                    }
                    if (Math.abs(this._velocity + loc3) > 0.5) 
                    {
                        this._myScrollElement.y = loc2 + this._velocity + loc3;
                    }
                }
            }
            return;
        }

        internal function onMouseWheel(arg1:flash.events.MouseEvent):void
        {
            if (this._stage.stage.displayState == flash.display.StageDisplayState.FULL_SCREEN) 
            {
                this._velocity = this._velocity + arg1.delta * 5 * SPEED_SPRINGNESS;
                if (this.callBack != null) 
                {
                    this.callBack();
                }
            }
            return;
        }

        internal function on_mouse_down(arg1:flash.events.MouseEvent):void
        {
            if (!this._mouseDown) 
            {
                this._mouseDownPoint = new flash.geom.Point(arg1.stageX, arg1.stageY);
                this._lastMouseDownPoint = new flash.geom.Point(arg1.stageX, arg1.stageY);
                this._mouseDown = true;
                this._mouseDownY = this._myScrollElement.y;
                this._stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.on_mouse_up);
                this._stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.on_mouse_move);
            }
            return;
        }

        internal function on_mouse_move(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            if (this._mouseDown) 
            {
                if (this.callBack != null) 
                {
                    this.callBack();
                }
                loc1 = new flash.geom.Point(arg1.stageX, arg1.stageY);
                this._myScrollElement.y = this._mouseDownY + (loc1.y - this._mouseDownPoint.y);
                this._velocity = this._velocity + (loc1.y - this._lastMouseDownPoint.y) * SPEED_SPRINGNESS;
                this._lastMouseDownPoint = loc1;
            }
            return;
        }

        internal function on_mouse_up(arg1:flash.events.MouseEvent):void
        {
            if (this._mouseDown) 
            {
                this._mouseDown = false;
                this._stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.on_mouse_up);
                this._stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.on_mouse_move);
            }
            return;
        }

        public function release():void
        {
            this._myScrollElement.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.on_mouse_down);
            this._myScrollElement.removeEventListener(flash.events.Event.ENTER_FRAME, this.on_enter_frame);
            this._myScrollElement = null;
            return;
        }

        public function start():void
        {
            this._started = true;
            return;
        }

        public function stop():void
        {
            this._started = false;
            this._velocity = 0;
            return;
        }

        public function set canvasHeight(arg1:Number):void
        {
            this._canvasHeight = arg1;
            return;
        }

        public function get canvasHeight():Number
        {
            return this._canvasHeight;
        }

        public function get percPosition():Number
        {
            var loc1:*=this._canvasHeight - this._myScrollElement.height;
            var loc2:*=this._myScrollElement.y;
            return loc2 / loc1;
        }

        public function get started():Boolean
        {
            return this._started;
        }

        public function set started(arg1:Boolean):void
        {
            if (arg1) 
            {
                this.start();
            }
            else 
            {
                this.stop();
            }
            return;
        }

        public function get myScrollElement():flash.display.DisplayObjectContainer
        {
            return this._myScrollElement;
        }

        
        {
            DECAY = 0.93;
            MOUSE_DOWN_DECAY = 0.5;
            SPEED_SPRINGNESS = 0.4;
            BOUNCING_SPRINGESS = 0.2;
        }

        internal var _mouseDown:Boolean=false;

        internal var _velocity:Number=0;

        internal var _mouseDownY:Number=0;

        internal var _mouseDownPoint:flash.geom.Point;

        internal var _lastMouseDownPoint:flash.geom.Point;

        internal var _canvasHeight:Number=0;

        internal var _myScrollElement:flash.display.DisplayObjectContainer;

        internal var _stage:flash.display.Stage;

        internal var _started:Boolean;

        public var callBack:Function;

        internal static var DECAY:Number=0.93;

        internal static var MOUSE_DOWN_DECAY:Number=0.5;

        internal static var SPEED_SPRINGNESS:Number=0.4;

        internal static var BOUNCING_SPRINGESS:Number=0.2;
    }
}
