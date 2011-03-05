package xfeet.runners
{
    import xfeet.data.RunData;
    public class AbstractRunner
    {
        //======================================================================
        //  Variables
        //======================================================================
        protected var runData:RunData;
        protected var completeHandler:Function;
        protected var resultXML:XML;
        //
        protected var targetData:Object;
        //======================================================================
        //  Public methods
        //======================================================================
        public function run(runData:RunData, resultRoot:XML,
                            completeHandler:Function):void
        {
            this.runData = runData;
            this.completeHandler = completeHandler;
            prepareStart(resultRoot);
            printStart();
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        protected function createResultXML(resultRoot:XML):void
        {
        }
        protected function prepareStart(resultRoot:XML):void
        {
        }
        protected function printStart():void
        {
        }
        protected function printTargetAttribute(key:String, printKey:Boolean = true):void
        {
            if (targetData[key])
            {
                printValue(targetData[key], printKey ? key : null);
            }
        }
        protected function printValue(value:*, key:String = null, targetXML:XML = null):void
        {
            var text:String = " ";
            if (key)
            {
                text += key + "=";
            }
            runData.output.printText(text + value, false);
            if (targetXML)
            {
                targetXML["@" + key] = value;
            }
            else
            {
                resultXML["@" + key] = value;
            }
        }
        protected function printStartOpen(pre:String):void
        {
            var text:String = pre + targetData.name;
            if (targetData.description)
            {
                text += " <_" + targetData.description + "_>";
            }
            runData.output.printText(text);
        }
        protected function printCloseTag():void
        {
            runData.output.printText(" ]", false);
        }
    }
}