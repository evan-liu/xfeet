package xfeet.data
{
    import p2.reflect.ReflectionMetaData;
    import p2.reflect.ReflectionMethod;

    public class MethodData
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>TestMethod</code>.
         */
        public function MethodData(reflection:ReflectionMethod,
                                   metaDataName:String)
        {
            _name = reflection.name;
            _metaData = reflection.getMetaDataByName(metaDataName);
            _order = _metaData.getValueFor("order");
            _iterations = _metaData.getValueFor("iterations");
            _description = _metaData.getValueFor("label");
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  unitData
        //------------------------------
        private var _unitData:UnitData;
        public function get unitData():UnitData
        {
            return _unitData;
        }
        //------------------------------
        //  name
        //------------------------------
        private var _name:String;
        public function get name():String
        {
            return _name;
        }
        //------------------------------
        //  metaData
        //------------------------------
        private var _metaData:ReflectionMetaData;
        public function get metaData():ReflectionMetaData
        {
            return _metaData;
        }
        //------------------------------
        //  order
        //------------------------------
        private var _order:int;
        public function get order():int
        {
            return _order;
        }
        //------------------------------
        //  iterations
        //------------------------------
        private var _iterations:uint;
        public function get iterations():uint
        {
            return _iterations;
        }
        //------------------------------
        //  description
        //------------------------------
        private var _description:String;
        public function get description():String
        {
            return _description;
        }
    }
}