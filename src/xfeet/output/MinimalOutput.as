package xfeet.output
{
    import com.bit101.components.TextArea;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.system.Capabilities;

    public class MinimalOutput extends Sprite implements IXfeetOutput
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function MinimalOutput()
        {
            super();
            if (stage)
            {
                build();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            }
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var text:TextArea;
        //======================================================================
        //  Public methods
        //======================================================================
        public function printStart():void
        {
            text.text += "Running tests on " + Capabilities.version;
            text.text += " " + (Capabilities.isDebugger ? "DEBUG" : "RELEASE");
        }
        public function printText(value:String, nextLine:Boolean = true):void
        {
            if (nextLine)
            {
                text.text += "\n";
            }
            text.text += value;
        }
        public function printComplete(result:XML):void
        {
            text.text += "\n\n";
            text.text += result.toXMLString();
            text.text += "\n\nTest complete.";
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function build():void
        {
            text = new TextArea(this, 0, 0);
            text.width = stage.stageWidth;
            text.height = stage.stageHeight;
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function addedToStageHandler(event:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            build();
        }
    }
}