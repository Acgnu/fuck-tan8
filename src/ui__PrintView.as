package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="ui__PrintView.swf", symbol = "ui__PrintView")]
    public dynamic class ui__PrintView extends flash.display.Sprite
    {
        public function ui__PrintView()
        {
            super();
            return;
        }

        public var txt:flash.text.TextField;

        public var btn0:flash.display.SimpleButton;

        public var btn1:flash.display.SimpleButton;
    }
}
