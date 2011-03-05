package xfeet.runners
{
    import xfeet.data.MethodData;
    import xfeet.data.RunData;
    import xfeet.utils.runGC;

    import flash.events.TimerEvent;
    import flash.utils.getTimer;
    public class MethodRunner
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var unit:*;
        private var methodData:MethodData;
        private var runData:RunData;
        private var completeHandler:Function;
        private var resultXML:XML;
        //
        private var method:Function;
        private var iterations:uint;
        private var loops:uint;
        //
        private var times:uint = 0;
        //
        private var min:int = -1;
        private var max:int = -1;
        private var total:int = 0;
        //======================================================================
        //  Public methods
        //======================================================================
        public function run(unit:*, methodData:MethodData, runData:RunData,
                            resultRoot:XML, completeHandler:Function):void
        {
            this.unit = unit;
            this.methodData = methodData;
            this.runData = runData;
            this.completeHandler = completeHandler;
            iterations = methodData.iterations > 0 ? methodData.iterations :
                                                     runData.iterations;
            loops = methodData.loops > 0 ? methodData.loops : runData.loops;
            method = unit[methodData.name];
            //
            resultXML = <Method name={methodData.name} />;
            resultRoot.appendChild(resultXML);
            printStart();
            //
            runData.timer.addEventListener(TimerEvent.TIMER, timerHandler);
            checkIteration();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function printStart():void
        {
            runData.output.printText("\n    [ " + methodData.name);
            runData.output.printText(" . " + loops + " loops", false);
            if (methodData.description)
            {
                runData.output.printText(" . " + methodData.description, false);
            }
            runData.output.printText(" ]", false);
        }
        private function printComplete():void
        {
            var time:Number = total / iterations;
            runData.output.printText("    [ " + methodData.name);
            runData.output.printText(" . " + time.toFixed(1), false);
            runData.output.printText(" ]", false);
        }
        private function printInteration(t:uint):void
        {
            runData.output.printText("      [  " + t + " ms ]");
        }
        private function checkIteration():void
        {
            if (times < iterations)
            {
                runIteration();
            }
            else
            {
                runData.timer.removeEventListener(TimerEvent.TIMER, timerHandler);
                printComplete();
                completeHandler();
            }
        }
        private function runIteration():void
        {
            var t:uint = getTimer();
            for (var i:int = 0; i < loops; i++)
            {
                method();
            }
            t = getTimer() - t - runData.tareTime;
            total += t;
            if (min == -1 || t < min)
            {
                min = t;
            }
            if (max == -1 || t > max)
            {
                max = t;
            }
            if (runData.iterations > 1 && runData.printIteration)
            {
                printInteration(t);
            }
            runGC();
            times++;
            runData.timer.reset();
            runData.timer.start();
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function timerHandler(event:TimerEvent):void
        {
            checkIteration();
        }
    }
}