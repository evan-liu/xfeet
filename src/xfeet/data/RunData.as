package xfeet.data
{
    import xfeet.output.IXfeetOutput;
    public class RunData
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function RunData(output:IXfeetOutput, loops:uint, iterations:uint,
                                printIteration:Boolean)
        {
            _output = output;
            _loops = loops;
            _iterations = iterations;
            _printIteration = printIteration;
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