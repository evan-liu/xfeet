package xfeet.output
{
    import com.bit101.components.RadioButton;
    import com.bit101.components.TextArea;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
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
        private var console:TextArea;
        private var textButton:RadioButton;
        private var xmlButton:RadioButton;
        //
        private var text:String = "";
        private var xml:String = "";
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
            xml = result.toXMLString();
            xmlButton.enabled = true;
            //
            appendText("\n\nTest complete.");
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function build():void
        {
            textButton = new RadioButton(this, 10, 10, "Text", true, textHandler);
            xmlButton = new RadioButton(this, 60, 10, "XML", false, xmlHandler);
            xmlButton.enabled = false;
            console = new TextArea(this, 0, 30);
            console.width = stage.stageWidth;
            console.editable = false;
            console.height = stage.stageHeight - console.y;
        }
        private function appendText(value:String):void
        {
            text += value;
            showText();
            console.textField.scrollV = console.textField.maxScrollV;
        }
        private function showText():void
        {
            console.text = console.textField.text = text;
        }
        private function showXML():void
        {
            console.text = console.textField.text = xml;
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function addedToStageHandler(event:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            build();
        }
        private function textHandler(event:MouseEvent):void
        {
            showText();
        }
        private function xmlHandler(event:MouseEvent):void
        {
            showXML();
        }
    }
}