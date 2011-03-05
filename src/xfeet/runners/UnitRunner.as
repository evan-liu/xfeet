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
            runData.fixUnit(unitData.loops, unitData.iterations);
            resultXML = <Unit name={unitData.name}/>;
            resultRoot.appendChild(resultXML);
            printStart();
            //
            unit = new unitData.unitClass();
            methods = unitData.testMethods;
            //
            tare();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function tare():void
        {
            new TareRunner().run(unit, unitData.tareMethod, runData, onTareComplete);
        }
        private function printStart():void
        {
            runData.output.printText("  [ " + unitData.name);
            if (unitData.description)
            {
                runData.output.printText(" . " + unitData.description, false);
                resultXML.@description = unitData.description;
            }
            var loops:uint = unitData.loops > 0 ? unitData.loops : runData.loops;
            runData.output.printText(" . " + loops + " loops", false);
            resultXML.@loops = loops;
            if (unitData.iterations > 0)
            {
                runData.output.printText(" . " + unitData.iterations + " iterations", false);
                resultXML.@iterations = unitData.iterations;
            }

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
            new MethodRunner().run(unit, test, runData, resultXML, onMethodComplete);
        }
        private function onMethodComplete():void
        {
            tearDownTest();
            checkNext();
        }
        private function onTareComplete():void
        {
            runData.output.printText(" . tareTime=" + runData.tareTime, false);
            runData.output.printText(" ]", false);
            resultXML.@tareTime = runData.tareTime;
            checkNext();
        }
    }
}