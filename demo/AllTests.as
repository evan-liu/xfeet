package
{
    import tests.Bitwise;
    import tests.Casting;
    import tests.CastingPromotion;

    [Suite]
    public class AllTests
    {
        public static function suite():Array
        {
            var tests:Array =
            [
               Casting,
               CastingPromotion,
               Bitwise,
            ];
            return tests;
        }
    }
}