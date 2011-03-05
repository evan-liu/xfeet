package xfeet.runners
{
    import xfeet.data.RunData;
    import xfeet.data.SuiteData;
    public class SuiteRunner
    {
        //======================================================================
        //  Public methods
        //======================================================================
        public function run(suiteData:SuiteData, runData:RunData,
                            result:XML, onComplete:Function):void
        {
        	runData.fixSub(suiteData.loops, suiteData.iterations, true);
        }
    }
}