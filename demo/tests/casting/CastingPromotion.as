package tests.casting{    [Unit(label="Evaluating impact of casting an array iterator", loops="1000000")]    public class CastingPromotion    {        //======================================================================
        //  Variables
        //======================================================================        private var values:Array;        private var i:int;        //======================================================================
        //  Public methods
        //======================================================================        [Before]
        public function setUp():void
        {            values = [];
            i = 0;
        }        [Test(label="i*2")]
        public function none():void
        {            values[i * 2] = i;
        }        [Test(label="uint(i*2)")]
        public function constructorCasting():void
        {            values[uint(i * 2)] = i;
        }        [Test(label="i*2 as uint")]
        public function asCasting():void
        {            values[i * 2 as uint] = i;
        }    }}