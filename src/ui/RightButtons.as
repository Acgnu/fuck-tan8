package ui 
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    
    public class RightButtons extends flash.display.Sprite
    {
        public function RightButtons()
        {
            this.btnArr = [];
            super();
            var loc1:*=["全 屏", "移 调", "帮 助", "打 印"];
            var loc2:*=this.graphics;
            loc2.lineStyle(2, 10066329, 0.8);
            loc2.beginFill(0, 0.7);
            loc2.drawRoundRectComplex(0, 0, this.SIZE + 10, this.SIZE * loc1.length + 10, 10, 0, 10, 0);
            var loc3:*=[UI_kp, UI_Tune, UI_Help, UI_Print, UI_Share];
            var loc4:*=0;
            while (loc4 < loc1.length) 
            {
                this.nowC = loc3[loc4];
                this.btnArr[loc4] = this.createBtn(loc1[loc4]);
                addChild(this.btnArr[loc4]);
                this.btnArr[loc4].x = this.SIZE / 2 + 5;
                this.btnArr[loc4].y = this.SIZE / 2 + 5 + this.SIZE * loc4;
                this.btnArr[loc4].name = "" + loc4;
                this.btnArr[loc4].addEventListener(flash.events.MouseEvent.CLICK, this.on0);
                ++loc4;
            }
            return;
        }

        internal function on0(arg1:flash.events.Event):void
        {
            this.value = int((arg1.currentTarget as flash.display.SimpleButton).name);
            dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
            return;
        }

        internal function createBtn(arg1:String):flash.display.SimpleButton
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            loc1 = this.createSp(1, 13421772, arg1);
            loc2 = this.createSp(2, 16777215, arg1, 6737151);
            loc3 = this.createSp(3, 13421772, arg1);
            loc4 = this.createSp(4, 0, "");
            return new flash.display.SimpleButton(loc1, loc2, loc3, loc4);
        }

        internal function createSp(arg1:int, arg2:int, arg3:String, arg4:int=-1):flash.display.Sprite
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=new flash.display.Sprite();
            if (arg1 == 2 || arg1 == 4) 
            {
                loc1.graphics.beginFill(0, 0.3);
                loc1.graphics.drawRoundRect((-this.SIZE) / 2, (-this.SIZE) / 2, this.SIZE, this.SIZE, 10, 10);
                loc1.graphics.endFill();
            }
            if (arg1 != 4) 
            {
                (loc3 = new this.nowC()).y = -8;
                loc1.addChild(loc3);
                if (arg1 == 2) 
                {
                    (loc4 = new flash.geom.ColorTransform()).color = arg4;
                    loc3.transform.colorTransform = loc4;
                }
            }
            var loc2:*;
            (loc2 = new flash.text.TextField()).autoSize = flash.text.TextFieldAutoSize.LEFT;
            loc2.text = arg3;
            loc2.textColor = arg2;
            loc2.x = (-loc2.width) / 2;
            loc2.y = 5;
            loc1.addChild(loc2);
            return loc1;
        }

        internal var SIZE:Number=60;

        public var btnArr:Array;

        public var value:int;

        internal var nowC:Class;
    }
}
