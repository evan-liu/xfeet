package xfeet.runners
{
    import xfeet.data.MethodData;
    import xfeet.data.RunData;
    import xfeet.data.UnitData;
    public class UnitRunner
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var unitData:UnitData;
        private var runData:RunData;
        private var completeHandler:Function;
        //
        private var unit:*;
        private var methods:Array;
        private var resultXML:XML;
        //======================================================================
        //  Public methods
        //======================================================================
        public function run(unitData:UnitData, runData:RunData,
                            resultRoot:XML, completeHandler:Function):void
        {
            this.unitData = unitData;
            this.runData = runData;
            this.completeHandler = completeHandler;
            //
            printStart();
            runData.fixSub(unitData.loops, unitData.iterations, false);
            resultXML = <Unit name={unitData.name}/>;
            resultRoot.appendChild(resultXML);
            //
            unit = new unitData.unitClass();
            methods = unitData.testMethods;
            checkNext();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function printStart():void
        {
            runData.output.printText("\n  [ " + unitData.name);
            if (unitData.description) 
            {
                runData.output.printText(" . " + unitData.description, false);
            }
            runData.output.printText(" ]", false);

        }
        private function checkNext():void
        {
            if (methods.length == 0)
            {
                completeHandler();
            }
            else
            {
                setUpTest();
                runTest(methods.shift());
            }
        }
        private function setUpTest():void
        {
            for each (var method:String in unitData.beforeMethods)
            {
                unit[method]();
            }
        }
        private function tearDownTest():void
        {
            for each (var method:String in unitData.afterMethods)
            {
                unit[method]();
            }
        }
        private function runTest(test:MethodData):void
        {
            new MethodRunner().run(unit, test, runData, resultXML, onComplete);
        }
        private function onComplete():void
        {
            tearDownTest();
            checkNext();
        }
    }
}