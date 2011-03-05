package xfeet.runners
{
    import xfeet.data.MethodData;
    import xfeet.data.RunData;
    import xfeet.data.UnitData;
    public class UnitRunner extends AbstractRunner
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function UnitRunner(unitData:UnitData)
        {
            this.unitData = unitData;
            unit = new unitData.unitClass();
            methods = unitData.testMethods;
            targetData = unitData;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var unitData:UnitData;
        private var unit:*;
        private var methods:Array;
        //======================================================================
        //  Overridden methods
        //======================================================================
        override public function run(runData:RunData,
                            resultRoot:XML, completeHandler:Function):void
        {
            super.run(runData, resultRoot, completeHandler);
            tare();
        }
        override protected function prepareStart(resultRoot:XML):void
        {
            resultXML = <Unit name={targetData.name} />;
            resultRoot.appendChild(resultXML);
            runData.fixUnit(unitData.loops, unitData.iterations);
        }
        override protected function printStart():void
        {
            printStartOpen("\n  [ ");
            var loops:uint = unitData.loops > 0 ? unitData.loops : runData.loops;
            printValue(loops, "loops");
            printTargetAttribute("iterations");
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function tare():void
        {
            new TareRunner(unit, unitData.tareMethod).run(runData, null, onTareComplete);
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
            new MethodRunner(unit, test).run(runData, resultXML, onMethodComplete);
        }
        private function onMethodComplete():void
        {
            tearDownTest();
            checkNext();
        }
        private function onTareComplete():void
        {
            runData.output.printText(" tareTime=" + runData.tareTime, false);
            printCloseTag();
            resultXML.@tareTime = runData.tareTime;
            checkNext();
        }
    }
}