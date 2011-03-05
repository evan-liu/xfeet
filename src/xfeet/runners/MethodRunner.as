package xfeet.runners
{
    import xfeet.data.MethodData;
    import xfeet.data.RunData;
    import xfeet.utils.runGC;

    import flash.events.TimerEvent;
    import flash.system.System;
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
        private var time:Number = 0;
        //
        private var memory:int;
        private var retainedMemory:int;
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
            if (methodData.description)
            {
                runData.output.printText(" . " + methodData.description, false);
            }
            if (methodData.loops > 0)
            {
                runData.output.printText(" . " + methodData.loops + " loops", false);
            }
            if (methodData.iterations > 0)
            {
                runData.output.printText(" . " + methodData.iterations + " iterations", false);
            }
            runData.output.printText(" ]", false);
        }
        private function printComplete():void
        {
            time /= iterations;
            runData.output.printText("    [ " + methodData.name);
            runData.output.printText(" . " + time.toFixed(1), false);
            if (iterations > 1)
            {
                runData.output.printText(" . min=" + min, false);
                runData.output.printText(" . max=" + max, false);
                if (time > 0)
                {
                    var deviation:Number = (max - min) / time;
                    runData.output.printText(" . deviation=" + deviation.toFixed(3), false);
                }
            }
            if (memory > iterations)
            {
                memory /= iterations;
                retainedMemory /= iterations;
                runData.output.printText(" . memory=" + memory, false);
                runData.output.printText(" . retainedMemory=" + retainedMemory, false);
            }
            runData.output.printText(" ]", false);
        }
        private function printInteration(t:uint, memory:int, retainedMemory:int):void
        {
            runData.output.printText("      [  " + t);
            if (memory > 1)
            {
                runData.output.printText(" . memory=" + memory, false);
                runData.output.printText(" . retainedMemory=" + retainedMemory, false);
            }
            runData.output.printText(" ]", false);
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
            runGC();
            var mem:uint = System.totalMemory;
            var t:uint = getTimer();
            for (var i:int = 0; i < loops; i++)
            {
                method();
            }
            t = getTimer() - t - runData.tareTime;
            time += t;
            if (min == -1 || t < min)
            {
                min = t;
            }
            if (max == -1 || t > max)
            {
                max = t;
            }
            var thisMemory:int = System.totalMemory - mem >> 10;
            runGC();
            var thisRetainedMemory:int = System.totalMemory - mem >> 10;
            memory += thisMemory;
            retainedMemory += thisRetainedMemory;
            if (runData.iterations > 1 && runData.printIteration)
            {
                printInteration(t, thisMemory, thisRetainedMemory);
            }
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