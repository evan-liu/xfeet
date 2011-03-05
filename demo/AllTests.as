package
{
    import tests.Bitwise;
    import tests.Casting;

    [Suite]
    public class AllTests
    {
        public static function suite():Array
        {
            var tests:Array =
            [
               Bitwise,
               Casting,
            ];
            return tests;
        }
    }
}