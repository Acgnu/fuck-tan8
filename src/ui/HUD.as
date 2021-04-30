package ui 
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    
    public class HUD extends flash.display.Sprite
    {
        public function HUD()
        {
            this.button1 = new ui.UIButton(null, null, "", 0, 10, 80);
            this.button2 = new ui.UIButton(null, null, "", 0, 10, 80);
            this.txt = new flash.text.TextField();
            super();
            var loc1:*=300;
            var loc2:*=50;
            graphics.beginFill(0, 0.7);
            graphics.drawRoundRect((-loc1) / 2, (-loc2) / 2, loc1, loc2, 20, 20);
            graphics.endFill();
            this.txt.defaultTextFormat = new flash.text.TextFormat(null, 20, 16777215);
            this.txt.selectable = false;
            this.txt.autoSize = flash.text.TextFormatAlign.CENTER;
            this.txt.y = -12;
            addChild(this.txt);
            return;
        }

        internal function onResize(arg1:flash.events.Event):void
        {
            if (_stage) 
            {
                hud.x = _stage.stageWidth / 2;
                hud.y = _stage.stageHeight / 2;
            }
            return;
        }

        internal function onComplete():void
        {
            com.greensock.TweenLite.to(hud, 0.5, {"alpha":0, "onComplete":hud.onComplete2, "ease":com.greensock.easing.Circ.easeOut});
            return;
        }

        internal function onComplete2():void
        {
            _sp.removeChild(this);
            this.alpha = 1;
            return;
        }

        public static function show(arg1:String, arg2:Number=1.5):void
        {
            if (hud == null) 
            {
                hud = new HUD();
                hud.mouseChildren = false;
                hud.mouseEnabled = false;
                _stage.addEventListener(flash.events.Event.RESIZE, hud.onResize);
            }
            hud.x = _stage.stageWidth / 2;
            hud.y = _stage.stageHeight / 2;
            _sp.addChild(hud);
            hud.alpha = 1;
            if (arg1 == null) 
            {
                hud.onComplete();
            }
            else 
            {
                if (arg2 > 0) 
                {
                    com.greensock.TweenLite.to(hud, arg2, {"alpha":1, "onComplete":hud.onComplete});
                }
                hud.txt.text = arg1;
                hud.txt.x = (-hud.txt.width) / 2;
            }
            return;
        }

        public static function hide():void
        {
            show(null);
            return;
        }

        
        {
            hud = null;
        }

        internal var button1:ui.UIButton;

        internal var button2:ui.UIButton;

        internal var txt:flash.text.TextField;

        internal static var hud:ui.HUD=null;

        public static var _sp:flash.display.DisplayObjectContainer;

        public static var _stage:flash.display.Stage;
    }
}
