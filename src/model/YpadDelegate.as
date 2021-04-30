package model 
{
    public interface YpadDelegate
    {
        function onNoteOn(arg1:int, arg2:int, arg3:int):void;

        function onNoteOff(arg1:int, arg2:int):void;

        function onShowNote(arg1:model.NoteRect, arg2:int, arg3:int):void;

        function onPlayComplete():void;
    }
}
