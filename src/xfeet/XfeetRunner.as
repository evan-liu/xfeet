package xfeet
{
    import p2.reflect.Reflection;

    import xfeet.data.SuiteData;
    import xfeet.data.UnitData;
    import xfeet.utils.isUnit;

    import flash.errors.IllegalOperationError;
    public class XfeetRunner
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XfeetRunner</code>.
         *
         * @param loops       The number of times to repeat the test within a single iteration.
         * @param iterations  The number of iterations to run with this test.
         */
        public function XfeetRunner(loops:uint = 1000000, iterations:uint = 4)
        {
            super();
            this.loops = loops;
            this.iterations = iterations;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var loops:uint;
        private var iterations:uint;
        //
        private var queue:Array;
        //======================================================================
        //  Public methods
        //======================================================================
        public function run(unitOrSuite:Class):void
        {
            if (queue)
            {
                throw new IllegalOperationError("It can be runned only once.");
            }
            //--
            var reflection:Reflection = Reflection.create(unitOrSuite);
            queue = isUnit(reflection) ? [new UnitData(unitOrSuite)] :
                                         new SuiteData(unitOrSuite).elements;
        }
    }
}