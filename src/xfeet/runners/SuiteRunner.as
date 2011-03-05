package xfeet.runners
{
    import xfeet.data.RunData;
    import xfeet.data.SuiteData;
    import xfeet.data.UnitData;
    public class SuiteRunner extends AbstractRunner
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function SuiteRunner(suiteData:SuiteData)
        {
            this.suiteData = suiteData;
            targetData = suiteData;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var suiteData:SuiteData;
        private var elements:Array;
        //======================================================================
        //  Overridden methods
        //======================================================================
        override public function run(runData:RunData,
                            resultRoot:XML, completeHandler:Function):void
        {
            super.run(runData, resultRoot, completeHandler);
            //
            elements = suiteData.elements;
            checkNext();
        }
        override protected function prepareStart(resultRoot:XML):void
        {
            resultXML = <Suite name={targetData.name} />;
            resultRoot.appendChild(resultXML);
        }
        override protected function printStart():void
        {
            printStartOpen("\n[ ");
            printCloseTag();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function checkNext():void
        {
            if (elements.length == 0)
            {
                completeHandler();
                return;
            }
            if (elements[0] is UnitData)
            {
                new UnitRunner(elements.shift()).run(runData, resultXML, onComplete);
            }
            else
            {
                new SuiteRunner(elements.shift()).run(runData, resultXML, onComplete);
            }
        }
        private function onComplete():void
        {
            checkNext();
        }
    }
}