package xfeet
{
    import p2.reflect.ReflectionMetaData;
    import p2.reflect.ReflectionMethod;

    import xfeet.data.UnitData;
    public class TestMethod
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>TestMethod</code>.
         */
        public function TestMethod(unitData:UnitData,
                                   reflection:ReflectionMethod,
                                   metaDataName:String)
        {
            _unitData = unitData;
            _name = reflection.name;
            _metaData = reflection.getMetaDataByName(metaDataName);
            _order = int(_metaData.getValueFor("order"));
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  unitData
        //------------------------------
        private var _unitData:UnitData;
        /**
         * Data of the ui-unit.
         */
        public function get unitData():UnitData
        {
            return _unitData;
        }
        //------------------------------
        //  name
        //------------------------------
        private var _name:String;
        /**
         * Name of the ui-unit method.
         */
        public function get name():String
        {
            return _name;
        }
        //------------------------------
        //  metaData
        //------------------------------
        /**
         * Meta data of the method ([Test], [Before] or [After]).
         */
        private var _metaData:ReflectionMetaData;
        public function get metaData():ReflectionMetaData
        {
            return _metaData;
        }
        //------------------------------
        //  order
        //------------------------------
        private var _order:int;
        /**
         * Order of the method.
         */
        public function get order():int
        {
            return _order;
        }
        //------------------------------
        //  iterations
        //------------------------------
        private var _iterations:uint = 0;
        /**
         * The number of iterations to run with this test. Each iteration is run and timed independently.
         * A larger number of iterations provides a larger sample, and more accurate results. Each iteration
         * should run long enough to yield a significant result (ex. >10ms).
         * <br/><br/>
         * Setting this to 0 indicates that PerformanceTest should use the default iterations.
         **/
        public function get iterations():uint
        {
            return _iterations;
        }
        //------------------------------
        //  loops
        //------------------------------
        private var _loops:uint = 1;
        /**
         * Specifies how many times to repeat the test within a single iteration. This allows you to increase the significance of your
         * results, but also introduces some overhead time related to calling the method multiple times. It can be handy for comparative
         * testing though.
         **/
        public function get loops():uint
        {
            return _loops;
        }
        //------------------------------
        //  description
        //------------------------------
        private var _description:String;
        /**
         * Optional description for this test.
         */
        public function get description():String
        {
            return _description;
        }
    }
}