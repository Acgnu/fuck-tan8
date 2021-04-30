package model 
{
    import __AS3__.vec.*;
    
    public class Track extends Object
    {
        public function Track()
        {
            super();
            return;
        }

        public var tick:__AS3__.vec.Vector.<int>;

        public var cmd:__AS3__.vec.Vector.<int>;

        public var note:__AS3__.vec.Vector.<int>;

        public var velocity:__AS3__.vec.Vector.<int>;

        public var rect_index:__AS3__.vec.Vector.<int>;

        public var note_rect:__AS3__.vec.Vector.<model.NoteRect>;

        public var rectSectionEndIndex:__AS3__.vec.Vector.<int>;
    }
}
