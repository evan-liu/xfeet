package
{
    import tests.BitwiseOrMath;

    import xfeet.XfeetCore;
    import xfeet.output.MinimalOutput;

    public class XfeetDemo extends MinimalOutput
    {
        public function XfeetDemo()
        {
            super();
            new XfeetCore(this).run(BitwiseOrMath);
        }
    }
}