package xfeet.runners
{
    import xfeet.data.MethodData;
    import xfeet.data.RunData;

    import flash.events.TimerEvent;
    import flash.utils.getTimer;
    public class TareRunner extends AbstractRunner
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function TareRunner(unit:*, methodData:MethodData)
        {
            this.unit = unit;
            this.methodData = methodData;
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
        private var total:int = 0;
        //======================================================================
        //  Overridden methods
        //======================================================================
        override public function run(runData:RunData, resultRoot:XML,
                                     completeHandler:Function):void
        {
            super.run(runData, resultRoot, completeHandler);
            //
            iterations = methodData && methodData.iterations > 0 ? methodData.iterations :
                                                                   runData.iterations;
            loops = runData.loops;
            method = methodData ? unit[methodData.name] : function():void {};
            //
            runData.timer.addEventListener(TimerEvent.TIMER, timerHandler);
            checkIteration();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function checkIteration():void
        {
            if (times < iterations)
            {
                runIteration();
            }
            else
            {
                runData.tareTime = total / iterations;
                runData.timer.removeEventListener(TimerEvent.TIMER, timerHandler);
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
            total += getTimer() - t;
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