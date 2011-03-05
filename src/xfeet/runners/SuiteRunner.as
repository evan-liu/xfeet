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
            trace("[SuiteRunner/run] " + suiteData.name, onComplete);
            this.suiteData = suiteData;
            this.runData = runData;
            this.completeHandler = completeHandler;
            printStart();
            runData.fixSub(suiteData.loops, suiteData.iterations, true);
            resultXML = <Suite name={suiteData.name}/>;
            resultRoot.appendChild(resultXML);
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
            runData.output.printText("\n[ " + suiteData.name);
            if (suiteData.description)
            {
                runData.output.printText(" . " + suiteData.description, false);
            }
            if (suiteData.loops > 0)
            {
                runData.output.printText(" . " + suiteData.loops + " loops", false);
            }
            if (suiteData.iterations > 0)
            {
                runData.output.printText(" . " + suiteData.iterations + " iterations", false);
            }
            runData.output.printText(" ]", false);
        }
        private function onComplete():void
        {
            checkNext();
        }
    }
}