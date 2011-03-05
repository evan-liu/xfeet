package xfeet
{
    import xfeet.data.RunData;
    import p2.reflect.Reflection;

    import xfeet.data.SuiteData;
    import xfeet.data.UnitData;
    import xfeet.output.IXfeetOutput;
    import xfeet.runners.SuiteRunner;
    import xfeet.runners.UnitRunner;
    import xfeet.utils.isUnit;


    public class XfeetCore
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XfeetCore</code>.
         *
         * @param loops       The number of times to repeat the test within a single iteration.
         * @param iterations  The number of iterations to run with this test.
         */
        public function XfeetCore(output:IXfeetOutput, loops:uint = 100000, iterations:uint = 4)
        {
            super();
            data = new RunData(output, loops, iterations);
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var data:RunData;
        private var result:XML;
        //======================================================================
        //  Public methods
        //======================================================================
        public function run(unitOrSuite:Class):void
        {
            result = <TestCollection />;
            data.output.printStart();
            var reflection:Reflection = Reflection.create(unitOrSuite);
            if (isUnit(reflection))
            {
                new UnitRunner().run(new UnitData(unitOrSuite), data, result, onComplete);
            }
            else
            {
                new SuiteRunner().run(new SuiteData(unitOrSuite), data, result, onComplete);
            }
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function onComplete():void
        {
            data.output.printComplete(result);
        }
    }
}