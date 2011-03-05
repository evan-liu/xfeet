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
        private var subLoops:uint = 0;
        private var subIterations:uint = 0;
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  loops
        //------------------------------
        private var _loops:uint;
        public function get loops():uint
        {
            return subLoops > 0 ? subLoops : _loops;
        }
        //------------------------------
        //  iterations
        //------------------------------
        private var _iterations:uint;
        public function get iterations():uint
        {
            return subIterations > 0 ? subIterations : _iterations;
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
        private var _tareTime:uint;
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
        public function fixSub(loops:uint, iterations:uint, force:Boolean):void
        {
            if (force || loops > 0)
            {
                subLoops = loops;
            }
            if (force || iterations > 0)
            {
                subIterations = iterations;
            }
        }
    }
}