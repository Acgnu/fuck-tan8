package ui.piano 
{
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;
    import utils.*;
    
    public class PianoKey extends flash.display.Sprite
    {
        public function PianoKey(arg1:Class, arg2:Class, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:String="")
        {
            var loc1:*=null;
            this.rectSp = new flash.display.Shape();
            super();
            this.x1 = arg3;
            this.y1 = arg4;
            this.w1 = arg5;
            this.h1 = arg6;
            this.mouseChildren = false;
            this.buttonMode = true;
            this.keyNormalBmp = new arg1();
            this.keyDownBmp = new arg2();
            this.keyNormalBmp.smoothing = true;
            this.keyDownBmp.smoothing = true;
            addChild(this.keyNormalBmp);
            addChild(this.keyDownBmp);
            addChild(this.rectSp);
            this.isBlack = arg7 == "";
            if (this.isBlack) 
            {
                this.rectSp.filters = [new flash.filters.GlowFilter(16777215)];
            }
            else 
            {
                this.rectSp.filters = [new flash.filters.BlurFilter()];
            }
            if (arg7 != "") 
            {
                (loc1 = new flash.text.TextFormat(null, 24, 0, true)).align = flash.text.TextFormatAlign.CENTER;
                this.txt = new flash.text.TextField();
                this.txt.defaultTextFormat = loc1;
                this.txt.selectable = false;
                this.txt.width = 30;
                this.txt.height = 35;
                this.txt.y = 90;
                this.txt.text = arg7;
                this.txt.visible = false;
                addChild(this.txt);
            }
            this.update();
            return;
        }

        public function downKey():void
        {
            this.isKeyDown = true;
            this.keyNormalBmp.visible = !this.isKeyDown;
            this.keyDownBmp.visible = this.isKeyDown;
            utils.CLib.noteOn(this.id, 0, 1);
            return;
        }

        public function upKey():void
        {
            this.isKeyDown = false;
            this.keyNormalBmp.visible = !this.isKeyDown;
            this.keyDownBmp.visible = this.isKeyDown;
            utils.CLib.noteOff(this.id, 0);
            return;
        }

        public function update():void
        {
            if (this.txt) 
            {
                this.txt.visible = false;
            }
            this.keyNormalBmp.visible = !this.isKeyDown;
            this.keyDownBmp.visible = this.isKeyDown;
            if (this.redyColor < 0) 
            {
                return;
            }
            this.rectSp.graphics.clear();
            if (this.isKeyRedy) 
            {
                this.rectSp.graphics.lineStyle(2, this.redyColor, this.isBlack ? 0.5 : 0.25);
                if (this.txt) 
                {
                    this.txt.alpha = 0.25;
                    this.txt.visible = true;
                }
            }
            if (this.isKeyDown) 
            {
                this.rectSp.graphics.beginFill(this.redyColor);
                if (this.txt) 
                {
                    this.txt.alpha = 1;
                    this.txt.visible = true;
                }
            }
            this.rectSp.graphics.drawRoundRect(this.x1, this.y1, this.w1, this.h1, 12, 12);
            return;
        }

        internal var keyNormalBmp:flash.display.Bitmap;

        internal var keyDownBmp:flash.display.Bitmap;

        internal var rectSp:flash.display.Shape;

        internal var isBlack:Boolean;

        public var redyColor:int=-1;

        public var isKeyRedy:Boolean=false;

        public var isKeyDown:Boolean=false;

        public var id:int;

        public var x1:int;

        public var y1:int;

        public var w1:int;

        public var h1:int;

        public var txt:flash.text.TextField;
    }
}
