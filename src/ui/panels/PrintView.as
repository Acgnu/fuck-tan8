package ui.panels 
{
    import flash.events.*;
    import flash.net.*;
    
    public class PrintView extends ui__PrintView
    {
        public function PrintView()
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
            try 
            {
                flash.net.navigateToURL(new flash.net.URLRequest(Config.downloadURL));
            }
            catch (e:Error)
            {
            };
            return;
        }
    }
}
