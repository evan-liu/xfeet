package
{
    import tests.Bitwise;
    import tests.casting.CastingSuite;
    import tests.collection.Collections;

    [Suite]
    public class AllTests
    {
        public static function suite():Array
        {
            var tests:Array =
            [
                Collections,
                Bitwise,
                CastingSuite,
            ];
            return tests;
        }
    }
}