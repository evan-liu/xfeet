package xfeet.data
{
    import p2.reflect.Reflection;
    import p2.reflect.ReflectionMetaData;
    import p2.reflect.ReflectionMethod;


    public class UnitData
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>UnitData</code>.
         */
        public function UnitData(unitClass:Class)
        {
            _unitClass = unitClass;
            _reflection = Reflection.create(unitClass);
            var metadata:ReflectionMetaData = _reflection.getMetaDataByName("Unit");
            if (metadata)
            {
                _description = metadata.getValueFor("label");
                _loops = metadata.getValueFor("loops");
                _iterations = metadata.getValueFor("iterations");
            }
            _name = reflection.name;
            if (_name.indexOf("::") != -1)
            {
                _name = _name.split("::")[1];
            }
            _beforeMethods = getFixtureMethods(reflection, "Before");
            _afterMethods = getFixtureMethods(reflection, "After");
            _tareMethod = getFixtureMethods(reflection, "Tare")[0];
            _testMethods = getTestMethods(reflection, "Test");
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  unitClass
        //------------------------------
        private var _unitClass:Class;
        /**
         * Class of the unit.
         */
        public function get unitClass():Class
        {
            return _unitClass;
        }
        //------------------------------
        //  reflection
        //------------------------------
        private var _reflection:Reflection;
        /**
         * Reflection value of the unit.
         */
        public function get reflection():Reflection
        {
            return _reflection;
        }
        //------------------------------
        //  name
        //------------------------------
        private var _name:String;
        /**
         * Name of the unit.
         */
        public function get name():String
        {
            return _name;
        }
        //------------------------------
        //  description
        //------------------------------
        private var _description:String;
        public function get description():String
        {
            return _description;
        }
        //------------------------------
        //  loops
        //------------------------------
        private var _loops:uint;
        public function get loops():uint
        {
            return _loops;
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
        //  beforeMethods
        //------------------------------
        private var _beforeMethods:Array;
        /**
         * List of set up methods run before each unit method.
         */
        public function get beforeMethods():Array
        {
            return _beforeMethods.concat();
        }
        //------------------------------
        //  afterMethods
        //------------------------------
        private var _afterMethods:Array;
        /**
         * List of tear down methods run after each unit method.
         */
        public function get afterMethods():Array
        {
            return _afterMethods.concat();
        }
        //------------------------------
        //  testMethods
        //------------------------------
        private var _testMethods:Array;
        /**
         * List of test methods.
         */
        public function get testMethods():Array
        {
            return _testMethods.concat();
        }
        //------------------------------
        //  tareMethod
        //------------------------------
        private var _tareMethod:String;
        public function get tareMethod():String
        {
            return _tareMethod;
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function getFixtureMethods(reflection:Reflection, metaDataName:String):Array
        {
            var methodReflections:Array = reflection.getMethodsByMetaData(metaDataName);
            var methods:Array = [];
            for each (var methodReflection:ReflectionMethod in methodReflections)
            {
                methods.push(methodReflection.name);
            }
            return methods;
        }
        private function getTestMethods(reflection:Reflection, metaDataName:String):Array
        {
            var methodReflections:Array = reflection.getMethodsByMetaData(metaDataName);
            var methods:Array = [];
            for each (var methodReflection:ReflectionMethod in methodReflections)
            {
                methods.push(new MethodData(methodReflection, metaDataName));
            }
            methods.sortOn(["order", "name"], Array.NUMERIC);
            return methods;
        }
    }
}