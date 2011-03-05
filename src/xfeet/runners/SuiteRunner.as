package xfeet.runners
{
    import xfeet.data.RunData;
    import xfeet.data.SuiteData;
    import xfeet.data.UnitData;
    public class SuiteRunner
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var suiteData:SuiteData;
        private var runData:RunData;
        private var completeHandler:Function;
        //
        private var resultXML:XML;
        //
        private var elements:Array;
        //======================================================================
        //  Public methods
        //======================================================================
        public function run(suiteData:SuiteData, runData:RunData,
                            resultRoot:XML, completeHandler:Function):void
        {
            this.suiteData = suiteData;
            this.runData = runData;
            this.completeHandler = completeHandler;
            resultXML = <Suite name={suiteData.name}/>;
            resultRoot.appendChild(resultXML);
            printStart();
            //
            elements = suiteData.elements;
            checkNext();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function checkNext():void
        {
            if (elements.length == 0)
            {
                completeHandler();
                return;
            }
            if (elements[0] is UnitData)
            {
                new UnitRunner().run(elements.shift(), runData, resultXML, onComplete);
            }
            else
            {
                new SuiteRunner().run(elements.shift(), runData, resultXML, onComplete);
            }
        }
        private function printStart():void
        {
            runData.output.printText("[ " + suiteData.name);
            if (suiteData.description)
            {
                runData.output.printText(" . " + suiteData.description, false);
                resultXML.@description = suiteData.description;
            }
            runData.output.printText(" ]", false);
        }
        private function onComplete():void
        {
            checkNext();
        }
    }
}