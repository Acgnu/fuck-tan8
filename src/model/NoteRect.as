package model 
{
    import __AS3__.vec.*;
    
    public class NoteRect extends Object
    {
        public function NoteRect()
        {
            super();
            return;
        }

        public var x1:Number;

        public var y1:Number;

        public var x2:Number;

        public var y2:Number;

        public var visible:Boolean;

        public var page:int;

        public var track:int;

        public var section:int;

        public var count:int=0;

        public var pos:int=0;

        public var tick:__AS3__.vec.Vector.<int>;

        public var note:__AS3__.vec.Vector.<int>;
    }
}
