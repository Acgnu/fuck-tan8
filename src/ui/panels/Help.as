package ui.panels 
{
    import flash.events.*;
    
    public class Help extends ui__Help
    {
        public function Help()
        {
            super();
            btn0.addEventListener(flash.events.MouseEvent.CLICK, this.onClick0);
            return;
        }

        internal function onClick0(arg1:flash.events.Event):void
        {
            this.visible = false;
            return;
        }
    }
}
