package ui.listview 
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    
    public dynamic class CellButton extends flash.display.Sprite
    {
        public function CellButton(arg1:flash.display.DisplayObjectContainer=null, arg2:String="", arg3:Number=0, arg4:Number=0, arg5:Number=50, arg6:Number=25)
        {
            this.labelText = new flash.text.TextField();
            this.sp = new flash.display.Sprite();
            super();
            if (arg1) 
            {
                arg1.addChild(this);
            }
            var loc1:*=new flash.text.TextFormat(null, 12, 13434624);
            this.labelText.defaultTextFormat = loc1;
            this.labelText.text = arg2;
            this.x = arg3;
            this.y = arg4;
            this._width = arg5;
            this._height = arg6;
            var loc2:*;
            this.labelText.mouseEnabled = loc2 = false;
            this.labelText.selectable = loc2;
            this.labelText.y = 2;
            this.buttonMode = true;
            this.sp.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onMouseEvent);
            this.sp.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onMouseEvent);
            this.sp.addChild(this.labelText);
            addChild(this.sp);
            this.labelText.x = 0;
            this.labelText.width = this._width - this.labelText.x;
            this.labelText.height = this._height;
            this.render();
            return;
        }

        public function set selected(arg1:Boolean):void
        {
            this.isSelected = arg1;
            this.labelText.textColor = this.isSelected ? selectedColor : outColor;
            this.labelText.filters = this.isSelected ? selectedFilters : outFilters;
            return;
        }

        public function get selected():Boolean
        {
            return this.isSelected;
        }

        internal function onMouseEvent(arg1:flash.events.MouseEvent):void
        {
            this.status = arg1.type;
            this.render();
            arg1.updateAfterEvent();
            return;
        }

        internal function render():void
        {
            if (this.status == flash.events.MouseEvent.MOUSE_OUT || this.status == flash.events.MouseEvent.MOUSE_UP) 
            {
                this.labelText.textColor = this.isSelected ? selectedColor : outColor;
                this.labelText.filters = this.isSelected ? selectedFilters : outFilters;
            }
            this.sp.graphics.clear();
            if (this.status != flash.events.MouseEvent.MOUSE_OVER) 
            {
                this.sp.graphics.beginFill(16777215, 0);
            }
            else 
            {
                this.sp.graphics.beginFill(16777215, 0.1);
                this.labelText.textColor = 15304489;
                this.labelText.filters = outFilters;
            }
            this.sp.graphics.drawRect(0, 0, this._width, this._height);
            return;
        }

        
        {
            outColor = 7829367;
            selectedColor = 6737151;
            outFilters = null;
            overFilters = null;
            selectedFilters = new Array(new flash.filters.GlowFilter(6737151, 1, 8, 8, 1.5));
        }

        public var labelText:flash.text.TextField;

        internal var sp:flash.display.Sprite;

        internal var isSelected:Boolean=false;

        internal var _width:Number=50;

        internal var _height:Number=25;

        internal var status:String="mouseOut";

        protected static var outColor:int=7829367;

        protected static var selectedColor:int=6737151;

        protected static var outFilters:Array=null;

        protected static var overFilters:Array=null;

        protected static var selectedFilters:Array;
    }
}
