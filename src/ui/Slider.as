package ui 
{
    import flash.display.*;
    import flash.events.*;
    
    public class Slider extends flash.display.Sprite
    {
        public function Slider(arg1:Number=120, arg2:Number=12)
        {
            this.sp1 = new flash.display.Sprite();
            this.sp2 = new flash.display.Sprite();
            super();
            this._width = arg1;
            this._height = arg2;
            addChild(this.sp1);
            addChild(this.sp2);
            this.bbb();
            this.sp2.mouseEnabled = false;
            var loc1:*;
            this.sp2.mouseEnabled = loc1 = false;
            this.sp2.mouseChildren = loc1;
            this.sp1.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onSeek);
            this.buttonMode = true;
            return;
        }

        public function set w(arg1:Number):void
        {
            this._width = arg1;
            this.bbb();
            this.value = this._value;
            return;
        }

        internal function bbb():void
        {
            this.sp1.graphics.clear();
            this.sp1.graphics.beginFill(6908265);
            this.sp1.graphics.drawRect(0, 0, this._width, this._height);
            this.sp1.graphics.beginFill(8421504);
            this.sp1.graphics.drawRect(0, 1, this._width, (this._height - 1));
            this.sp1.graphics.beginFill(9145227);
            this.sp1.graphics.drawRect(0, 2, this._width, this._height - 2);
            this.sp1.graphics.endFill();
            return;
        }

        internal function onSeek(arg1:flash.events.MouseEvent):void
        {
            stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onSeek2);
            stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onUp);
            this.onSeek2(arg1);
            this.isMove = true;
            this.bbb();
            return;
        }

        internal function onSeek2(arg1:flash.events.MouseEvent):void
        {
            this.value = this.sp1.mouseX / this.sp1.width;
            dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
            arg1.updateAfterEvent();
            return;
        }

        internal function onUp(arg1:flash.events.Event):void
        {
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onSeek2);
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.onUp);
            this.isMove = false;
            this.bbb();
            return;
        }

        public function get value():Number
        {
            return this._value;
        }

        public function set value(arg1:Number):void
        {
            if (arg1 < 0) 
            {
                arg1 = 0;
            }
            if (arg1 > 1) 
            {
                arg1 = 1;
            }
            this._value = arg1;
            this.sp2.graphics.clear();
            this.sp2.graphics.beginFill(16556124);
            this.sp2.graphics.drawRect(1, 1, (this._width - 2) * arg1, this._height - 2);
            this.sp2.graphics.endFill();
            return;
        }

        internal var sp1:flash.display.Sprite;

        internal var sp2:flash.display.Sprite;

        internal var _value:Number=0;

        internal var isOver:Boolean=false;

        internal var isMove:Boolean=false;

        internal var _width:Number;

        internal var _height:Number;
    }
}
