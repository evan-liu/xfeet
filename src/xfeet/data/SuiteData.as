package xfeet.data
{
    import p2.reflect.Reflection;
    import p2.reflect.ReflectionMetaData;
    import p2.reflect.ReflectionMethod;
    import p2.reflect.ReflectionVariable;

    import xfeet.utils.isSuite;
    import xfeet.utils.isUnit;

    import flash.utils.getDefinitionByName;
    public class SuiteData
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>SuiteData</code>.
         */
        public function SuiteData(suiteClass:Class)
        {
            var suiteReflection:Reflection = Reflection.create(suiteClass);
            //-- Name
            var metadata:ReflectionMetaData = suiteReflection.getMetaDataByName("Suite");
            _name = metadata.getValueFor("label");
            if (!_name)
            {
                _name = suiteReflection.name;
                if (_name.indexOf("::") != -1)
                {
                    _name = _name.split("::")[1];
                }
            }
            //-- description
            var desc:String = metadata.getValueFor("description");
            if (desc) {
                _description = desc;
            }
            //-- Elements
            var suiteMethod:ReflectionMethod = suiteReflection.getMethodByName("suite");
            if (suiteMethod && suiteMethod.returnType == "Array")
            {
                parseElementsFromSuiteMethod(suiteClass["suite"]());
            }
            else
            {
                parseElementsFromVariables(suiteReflection.variables);
            }
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  name
        //------------------------------
        private var _name:String;
        /**
         * Name of the suite. It's name of the suite class.
         * Use <code>[Suite(label="anotherValue")]</code> to set it to another value.
         */
        public function get name():String
        {
            return _name;
        }
        //------------------------------
        //  description
        //------------------------------
        private var _description:String = "";
        public function get description():String
        {
            return _description;
        }
        //------------------------------
        //  elements
        //------------------------------
        private var _elements:Array = [];
        /**
         * Elements (units or other suites) in the suite.
         */
        public function get elements():Array
        {
            return _elements.concat();
        }
        //==========================================================================
        //  Private methods
        //==========================================================================
        private function parseElementsFromSuiteMethod(elements:Array):void
        {
            for each (var elementClass:Class in elements)
            {
                parseElement(elementClass);
            }
        }
        private function parseElementsFromVariables(variables:Array):void
        {
            for each (var variable:ReflectionVariable in variables)
            {
                parseElement(Class(getDefinitionByName(variable.type)));
            }
        }
        private function parseElement(elementClass:Class):void {
            var elementReflection:Reflection = Reflection.create(elementClass);
            if (isUnit(elementReflection))
            {
                _elements.push(new UnitData(elementClass));
            }
            else if (isSuite(elementReflection))
            {
                _elements.push(new SuiteData(elementClass));
            }
        }
    }
}