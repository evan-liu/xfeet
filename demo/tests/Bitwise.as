package tests{    [Unit(label="Comparing floor & round to bitwise equivalents")]    public class Bitwise    {        //======================================================================
        //  Variables
        //======================================================================        private var foo:Array;        private var i:uint;        //======================================================================
        //  Public methods
        //======================================================================        [Before]
        public function setUp():void
        {
            foo = [];            i = 0;
        }        [Tare]
        public function tare():void
        {            i++;
        }        [Test(label="Math.round(n), Math.floor(n), Math.floor(n/2)")]
        public function math():void
        {            var a:uint = Math.floor(i / 7);            var b:uint = Math.round(i / 3);            var c:uint = Math.floor(i / 2);            foo[i] = String(Math.random());            i++;        }        [Test(label="n+0.5|0, n|0, n>>1")]        public function bitwise():void        {            var a:uint = i / 7 | 0;            var b:uint = i / 3 + 0.5 | 0;            var c:uint = i >> 1;            i++;        }    }}