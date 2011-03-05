package xfeet.data
{
    import xfeet.output.IXfeetOutput;

    import flash.utils.Timer;
    public class RunData
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function RunData(output:IXfeetOutput, loops:uint, iterations:uint,
                                printIteration:Boolean, delay:int)
        {
            _output = output;
            _loops = loops;
            _iterations = iterations;
            _printIteration = printIteration;
            _timer = new Timer(delay, 1);
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var unitLoops:uint = 0;
        private var unitIterations:uint = 0;
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  loops
        //------------------------------
        private var _loops:uint;
        public function get loops():uint
        {
            return unitLoops > 0 ? unitLoops : _loops;
        }
        //------------------------------
        //  iterations
        //------------------------------
        private var _iterations:uint;
        public function get iterations():uint
        {
            return unitIterations > 0 ? unitIterations : _iterations;
        }
        //------------------------------
        //  output
        //------------------------------
        private var _output:IXfeetOutput;
        public function get output():IXfeetOutput
        {
            return _output;
        }
        //------------------------------
        //  printIteration
        //------------------------------
        private var _printIteration:Boolean;
        public function get printIteration():Boolean
        {
            return _printIteration;
        }
        //------------------------------
        //  timer
        //------------------------------
        private var _timer:Timer;
        public function get timer():Timer
        {
            return _timer;
        }
        //------------------------------
        //  tareTime
        //------------------------------
        private var _tareTime:uint = 0;
        public function get tareTime():uint
        {
            return _tareTime;
        }
        public function set tareTime(value:uint):void
        {
            _tareTime = value;
        }
        //======================================================================
        //  Public methods
        //======================================================================
        public function fixUnit(loops:uint, iterations:uint):void
        {
            unitLoops = loops;
            unitIterations = iterations;
        }
    }
}