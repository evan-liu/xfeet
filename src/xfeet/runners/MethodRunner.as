package xfeet.runners
{
    import xfeet.data.MethodData;
    import xfeet.data.RunData;

    import flash.events.TimerEvent;
    import flash.net.LocalConnection;
    import flash.utils.Timer;
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
        private var iterations:uint;
        private var loops:uint;
        private var timer:Timer = new Timer(1, 1);
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
            //
            resultXML = <Method name={methodData.name} />;
            resultRoot.appendChild(resultXML);
            printStart();
            //
            timer.addEventListener(TimerEvent.TIMER, timerHandler);
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
            runData.output.printText("    [ " + methodData.name + " . ]");
        }
        private function checkIteration():void
        {
            if (iterations > 0)
            {
                runIteration();
            }
            else
            {
                printComplete();
                timer.removeEventListener(TimerEvent.TIMER, timerHandler);
                completeHandler();
            }
        }
        private function runIteration():void
        {
            var loops:uint = runData.loops;
            var t:uint = getTimer();
            for (var i:int = 0; i < loops; i++)
            {
                unit[methodData.name]();
            }
            t = getTimer() - t;
            runData.output.printText("      [  " + t + " ms ]");
            runGC();
            iterations--;
            timer.reset();
            timer.start();
        }
        private static function runGC():void {
            try
            {
                new LocalConnection().connect("_FORCE_GC_");
                new LocalConnection().connect("_FORCE_GC_");
            } catch(e:*) {}
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