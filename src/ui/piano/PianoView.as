package ui.piano 
{
    import flash.display.*;
    import flash.events.*;
    
    public class PianoView extends flash.display.Sprite
    {
        public function PianoView()
        {
            var loc1:*=0;
            var loc2:*=null;
            this.arr = [];
            super();
            loc1 = 0;
            while (loc1 < 52) 
            {
                loc2 = new ui.piano.PianoKey(whiteKey, whiteKeyDown, 7, 90, 16, 30, "" + ((loc1 + 5) % 7 + 1));
                loc2.id = whiteArr[loc1];
                this.arr[loc2.id] = loc2;
                loc2.x = loc1 * this.w1;
                loc2.x = Math.floor(loc2.x);
                addChild(loc2);
                ++loc1;
            }
            loc1 = 0;
            while (loc1 < 36) 
            {
                loc2 = new ui.piano.PianoKey(blackKey, blackKeyDown, 1, 40, 15, 30);
                loc2.id = blackArr[loc1];
                this.arr[loc2.id] = loc2;
                loc2.x = (blackArr[loc1] - loc1) * this.w1 - this.w2 / 2;
                loc2.x = Math.floor(loc2.x);
                addChild(loc2);
                ++loc1;
            }
            this.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onMouseDown);
            return;
        }

        internal function onMouseDown(arg1:flash.events.Event):void
        {
            mouseIsDown = true;
            var loc1:*=arg1.target as ui.piano.PianoKey;
            loc1.downKey();
            stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onMouseUp);
            this.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onMouseOver);
            this.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onMouseOut);
            return;
        }

        internal function onMouseUp(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            mouseIsDown = false;
            if (arg1.target is ui.piano.PianoKey) 
            {
                loc1 = arg1.target as ui.piano.PianoKey;
                loc1.upKey();
            }
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.onMouseUp);
            this.removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onMouseOver);
            this.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onMouseOut);
            return;
        }

        internal function onMouseOver(arg1:flash.events.Event):void
        {
            var loc1:*=arg1.target as ui.piano.PianoKey;
            loc1.downKey();
            return;
        }

        internal function onMouseOut(arg1:flash.events.Event):void
        {
            var loc1:*=arg1.target as ui.piano.PianoKey;
            loc1.upKey();
            return;
        }

        public function keyOn(arg1:int):void
        {
            var loc1:*=null;
            if (arg1 >= 0 && arg1 < 88) 
            {
                loc1 = this.arr[arg1];
                loc1.isKeyDown = true;
                loc1.update();
            }
            return;
        }

        public function keyOff(arg1:int):void
        {
            var loc1:*=null;
            if (arg1 >= 0 && arg1 < 88) 
            {
                loc1 = this.arr[arg1];
                loc1.isKeyDown = false;
                loc1.update();
            }
            return;
        }

        public function allKeyOff():void
        {
            var loc2:*=null;
            var loc1:*=0;
            while (loc1 < 88) 
            {
                loc2 = this.arr[loc1];
                loc2.isKeyDown = false;
                loc2.update();
                ++loc1;
            }
            return;
        }

        public function allRedyOff():void
        {
            var loc2:*=null;
            var loc1:*=0;
            while (loc1 < 88) 
            {
                loc2 = this.arr[loc1];
                loc2.isKeyRedy = false;
                loc2.update();
                ++loc1;
            }
            return;
        }

        public function redyColor(arg1:int, arg2:int):void
        {
            var loc1:*=null;
            if (arg1 >= 0 && arg1 < 88) 
            {
                loc1 = this.arr[arg1];
                loc1.isKeyRedy = true;
                loc1.redyColor = arg2;
                loc1.update();
            }
            return;
        }

        
        {
            whiteArr = [0, 2, 3, 5, 7, 8, 10, 12, 14, 15, 17, 19, 20, 22, 24, 26, 27, 29, 31, 32, 34, 36, 38, 39, 41, 43, 44, 46, 48, 50, 51, 53, 55, 56, 58, 60, 62, 63, 65, 67, 68, 70, 72, 74, 75, 77, 79, 80, 82, 84, 86, 87];
            blackArr = [1, 4, 6, 9, 11, 13, 16, 18, 21, 23, 25, 28, 30, 33, 35, 37, 40, 42, 45, 47, 49, 52, 54, 57, 59, 61, 64, 66, 69, 71, 73, 76, 78, 81, 83, 85];
            blackKey = ui.piano.PianoView_blackKey;
            blackKeyDown = ui.piano.PianoView_blackKeyDown;
            whiteKey = ui.piano.PianoView_whiteKey;
            whiteKeyDown = ui.piano.PianoView_whiteKeyDown;
            mouseIsDown = false;
        }

        internal const w1:Number=30;

        internal const w2:Number=18;

        internal var arr:Array;

        internal static var whiteArr:Array;

        internal static var blackArr:Array;

        internal static var blackKey:Class;

        internal static var blackKeyDown:Class;

        internal static var whiteKey:Class;

        internal static var whiteKeyDown:Class;

        internal static var mouseIsDown:Boolean=false;
    }
}
