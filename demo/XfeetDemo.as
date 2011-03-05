package
{
    import xfeet.XfeetCore;
    import xfeet.output.MinimalOutput;
    [SWF(width="550", height="400", backgroundColor="0xFFFFFF", frameRate="30")]
    public class XfeetDemo extends MinimalOutput
    {
        public function XfeetDemo()
        {
            super();
            new XfeetCore(this).run(AllTests);
        }
    }
}