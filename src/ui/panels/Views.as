package ui.panels 
{
    import flash.display.*;
    
    public class Views extends flash.display.Sprite
    {
        public function Views()
        {
            this.printView = new ui.panels.PrintView();
            this.moveTune = new ui.panels.MoveTune();
            this.help = new ui.panels.Help();
            this.arr = [];
            super();
            this.arr[0] = this.moveTune;
            this.arr[1] = this.help;
            this.arr[2] = this.printView;
            var loc1:*=0;
            while (loc1 < 3) 
            {
                addChild(this.arr[loc1]);
                this.arr[loc1].visible = false;
                ++loc1;
            }
            return;
        }

        public function show(arg1:int):void
        {
            if (this.arr[arg1].visible) 
            {
                this.arr[arg1].visible = false;
                return;
            }
            var loc1:*=0;
            while (loc1 < 4) 
            {
                this.arr[loc1].visible = loc1 == arg1;
                ++loc1;
            }
            return;
        }

        public var printView:ui.panels.PrintView;

        public var moveTune:ui.panels.MoveTune;

        public var help:ui.panels.Help;

        public var arr:Array;
    }
}
