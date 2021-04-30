package ui.panels 
{
    import flash.events.*;
    import utils.*;
    
    public class MoveTune extends ui__MoveTune
    {
        public function MoveTune()
        {
            super();
            btn0.addEventListener(flash.events.MouseEvent.CLICK, this.onClick0);
			if(null != btn1){
				btn1.addEventListener(flash.events.MouseEvent.CLICK, this.onClick1);
			}
            return;
        }

        internal function onClick0(arg1:flash.events.Event):void
        {
            this.visible = false;
            return;
        }

        internal function onClick1(arg1:flash.events.Event):void
        {
            utils.Func.navigate(Config.IPadURL);
            return;
        }
    }
}
