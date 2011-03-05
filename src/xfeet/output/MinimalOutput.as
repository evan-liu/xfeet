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
            appendText("Running tests on " + Capabilities.version);
            appendText(" " + (Capabilities.isDebugger ? "DEBUG" : "RELEASE"));
        }
        public function printText(value:String, nextLine:Boolean = true):void
        {
            if (nextLine)
            {
                appendText("\n");
            }
            appendText(value);
        }
        public function printComplete(result:XML):void
        {
            appendText("\n\n");
            appendText(result.toXMLString());
            appendText("\n\nTest complete.");
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function build():void
        {
            text = new TextArea(this, 0, 0);
            text.width = stage.stageWidth;
            text.height = stage.stageHeight;
            text.editable = false;
        }
        private function appendText(value:String):void
        {
            text.text += value;
            text.textField.appendText(value);
            text.textField.scrollV = text.textField.maxScrollV;
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