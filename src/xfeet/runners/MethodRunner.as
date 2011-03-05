package xfeet.runners
{
    import xfeet.data.MethodData;
    import xfeet.data.RunData;
    import xfeet.utils.runGC;

    import flash.events.TimerEvent;
    import flash.system.System;
    import flash.utils.getTimer;
    public class MethodRunner extends AbstractRunner
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function MethodRunner(unit:*, methodData:MethodData)
        {
            this.unit = unit;
            this.methodData = methodData;
            targetData = methodData;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var unit:*;
        private var methodData:MethodData;
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
        override public function run(runData:RunData,
                            resultRoot:XML, completeHandler:Function):void
        {
            super.run(runData, resultRoot, completeHandler);
            runData.timer.addEventListener(TimerEvent.TIMER, timerHandler);
            checkIteration();
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        override protected function prepareStart(resultRoot:XML):void
        {
            resultXML = <Method name={targetData.name} />;
            resultRoot.appendChild(resultXML);
            iterations = methodData.iterations > 0 ? methodData.iterations :
                                                     runData.iterations;
            loops = runData.loops;
            method = unit[methodData.name];
        }
        override protected function printStart():void
        {
            printStartOpen("    [ ");
            printTargetAttribute("iterations");
            runData.output.printText(" ]", false);
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function printComplete():void
        {
            time /= iterations;
            runData.output.printText("    [ ===== " + time.toFixed(1));
            resultXML.@time = time.toFixed(1);
            if (iterations > 1)
            {
                printValue(min, "min");
                printValue(max, "max");
                if (time > 0)
                {
                    var deviation:Number = (max - min) / time;
                    printValue(deviation.toFixed(3), "deviation");
                }
            }
            if (memory > iterations)
            {
                memory /= iterations;
                retainedMemory /= iterations;
                printValue(memory, "memory");
                printValue(retainedMemory, "retainedMemory");
            }
            printCloseTag();
        }
        private function printIteration(t:uint, memory:int, retainedMemory:int):void
        {
            runData.output.printText("      [ " + t);
            var xml:XML = <Interation time={t} />;
            if (memory > 1)
            {
                printValue(memory, "memory", xml);
                printValue(retainedMemory, "retainedMemory", xml);
            }
            printCloseTag();
            resultXML.appendChild(xml);
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
                printIteration(t, thisMemory, thisRetainedMemory);
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