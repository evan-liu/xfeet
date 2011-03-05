package xfeet.output
{
    public interface IXfeetOutput
    {
        function printStart():void;
        function printText(value:String, nextLine:Boolean = true):void;
        function printComplete(result:XML):void;
    }
}