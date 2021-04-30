package ui 
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    
    public dynamic class UIButton extends flash.display.Sprite
    {
        public function UIButton(arg1:flash.display.DisplayObjectContainer=null, arg2:flash.display.Sprite=null, arg3:String="", arg4:Number=0, arg5:Number=0, arg6:Number=50, arg7:Number=25)
        {
            this.labelText = new flash.text.TextField();
            this.sp = new flash.display.Sprite();
            this.tishiTxt = new flash.text.TextField();
            super();
            if (arg1) 
            {
                arg1.addChild(this);
            }
            var loc1:*;
            (loc1 = new flash.text.TextFormat(null, 12, 13434624)).align = flash.text.TextFormatAlign.CENTER;
            this.labelText.defaultTextFormat = loc1;
            this.labelText.text = arg3;
            this.x = arg4;
            this.y = arg5;
            this._width = arg6;
            this._height = arg7;
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
            if (arg2) 
            {
                arg2.mouseChildren = false;
                arg2.mouseEnabled = false;
                arg2.y = (this._height - arg2.height) / 2;
                addChild(arg2);
                if (arg3 == "") 
                {
                    arg2.x = (this._width - arg2.width) / 2;
                }
                else 
                {
                    arg2.x = arg2.y;
                    this.labelText.x = arg2.x * 2 + arg2.width;
                }
                arg2.x = Math.round(arg2.x);
                arg2.y = Math.round(arg2.y);
            }
            this.labelText.width = this._width - this.labelText.x;
            this.labelText.height = this._height;
            this.render();
            return;
        }

        public function set tishi(arg1:String):void
        {
            var loc1:*=new flash.text.TextFormat(null, 12, 0);
            loc1.align = flash.text.TextFormatAlign.CENTER;
            this.tishiTxt.defaultTextFormat = loc1;
            var loc2:*;
            this.tishiTxt.mouseEnabled = loc2 = false;
            this.tishiTxt.selectable = loc2;
            this.tishiTxt.text = arg1;
            this.tishiTxt.width = 56;
            this.tishiTxt.height = 20;
            this.tishiTxt.x = -27 + this._width / 2;
            this.tishiTxt.y = -22;
            this.tishiTxt.background = true;
            this.tishiTxt.backgroundColor = 15658734;
            this.tishiTxt.border = true;
            this.tishiTxt.borderColor = 6710886;
            addChild(this.tishiTxt);
            this.tishiTxt.visible = false;
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
            if (this.status != flash.events.MouseEvent.MOUSE_DOWN) 
            {
            };
            this.sp.graphics.clear();
            if (this.status != flash.events.MouseEvent.MOUSE_OVER) 
            {
                this.sp.graphics.beginFill(16777215, 0);
                this.tishiTxt.visible = false;
            }
            else 
            {
                this.sp.graphics.beginFill(16777215, 0.4);
                this.tishiTxt.visible = true;
            }
            this.sp.graphics.drawRoundRect(0, 0, this._width, this._height, 10, 10);
            return;
        }

        
        {
            outColor = 5263440;
            selectedColor = 16777215;
            outFilters = null;
            overFilters = null;
            selectedFilters = new Array(new flash.filters.GlowFilter(16746287, 1, 2, 2, 10));
        }

        public var labelText:flash.text.TextField;

        internal var sp:flash.display.Sprite;

        internal var isSelected:Boolean;

        internal var _width:Number=50;

        internal var _height:Number=25;

        internal var tishiTxt:flash.text.TextField;

        internal var status:String="mouseOut";

        protected static var outColor:int=5263440;

        protected static var selectedColor:int=16777215;

        protected static var outFilters:Array=null;

        protected static var overFilters:Array=null;

        protected static var selectedFilters:Array;
    }
}
